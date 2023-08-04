"""
Cancer Clinical Trials Database Web Server
To run locally: python server.py
Go to http://localhost:8111 in your browser.
"""
import os
from sqlalchemy import *
from sqlalchemy.pool import NullPool
from flask import (Flask, request, render_template, g, redirect, Response, 
                   flash, url_for, session)
import functools

tmpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
app = Flask(__name__, template_folder=tmpl_dir)
app.secret_key = b'8b13a355666c9c10f40a910ee860189d327837989500d00c9dbf2849f56af334'


"""
URI to connect to the database.
Database run locally and password disabled for demonstration purposes.
DATABASEURI = "postgresql://postgres:@localhost/cancer_clinical_trials"
"""
DATABASE_USERNAME = "postgres"
DATABASE_PASSWRD = ""
DATABASE_HOST = "localhost"
DATABASEURI = (f"postgresql://{DATABASE_USERNAME}:{DATABASE_PASSWRD}"
                              f"@{DATABASE_HOST}/cancer_clinical_trials")

# Creates a database engine that knows how to connect to the URI above.
engine = create_engine(DATABASEURI)


def login_required(view):
    """
    Define @login_required decorator to require that user be logged in 
    """
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect('/login')

        return view(**kwargs)
    return wrapped_view


@app.before_request
def before_request():
    """
    This function is run at the beginning of every web request to setup a 
    database connection that can be used throughout the request.
    """
    try:
        g.conn = engine.connect()
    except:
        print("problem connecting to database")
        import traceback;
        traceback.print_exc()
        g.conn = None     
    else:
        session_name = session.get('name')
        
        if session_name is None:
            g.user = None
        else:
            params = {}
            params["param_name"] = session_name
            g.user = g.conn.execute(text(
                'SELECT * FROM user_account WHERE user_name = (:param_name)'), 
                params
            ).fetchone()


@app.teardown_request
def teardown_request(exception):
    """
    At the end of the web request, this makes sure to close the database 
    connection to prevent the database from running out of memory.
    """
    try:
        g.conn.close()
    except Exception as e:
        pass


# @app.route is a decorator that means run the function whenever the user tries
# to access the given path using a specified request
#
# For example, if you want the user to go to localhost:8111/foobar/ with POST or
# GET then you could use:
#
#   @app.route("/foobar/", methods=["POST", "GET"])
@app.route('/register', methods=('GET', 'POST'))
def login_create():
    """
    Insert new user record into user_account table based on input form
    information. Display error if username already exists.
    """
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        phone = request.form['phone number']
        email = request.form['email']
        error = None

        if not username:
            error = 'Username is required.'
        elif not password:
            error = 'Password is required.'
    
        if error is None:
            try:
                params = {}
                params["new_name"] = username
                params["new_password"] = password
                params["new_phone"] = phone
                params["new_email"] = email
                
                g.conn.execute(text(
                    "INSERT INTO user_account(user_name, user_phone_number, "
                                             "user_email, user_password) "
                     "VALUES (:new_name, :new_phone, :new_email, :new_password)"
                     ), params)
                
                g.conn.commit()   
            except exc.IntegrityError:
                error = f"User {username} is already registered."
            else:
                return redirect("/login")

        flash(error)

    return render_template('register.html')


@app.route('/login', methods=('GET', 'POST'))
def login():
    """
    Retrieve user information from user_account table based on input username.
    Verify that password is correct and logs the user in if so.
    """
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        error = None

        params = {}
        params["param_name"] = username
        user = g.conn.execute(text(
            'SELECT * FROM user_account WHERE user_name = (:param_name)'), 
            params).fetchone()

        if user is None:
            error = 'Incorrect username.'
        elif user[3] != password:
            error = 'Incorrect password.'

        if error is None:
            session.clear()
            session['name'] = user[0]
            return redirect('/')

        flash(error)

    return render_template('/login.html')


@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')
    

@app.route('/', methods=['GET', 'POST'])
@login_required
def homepage():
    """
    Display homepage for clinical trial website.
    """
    with engine.connect() as connection:
        # Display available countries in location drop down
        results = connection.execute(text(
            "SELECT address_country FROM location"))
        locations = sorted(set([row[0] for row in results]))

    return render_template("index.html", locations=locations)


@app.route('/results', methods=['GET', 'POST'])
@login_required
def results():
    """
    Construct results page according to search parameters.
    """
    with engine.connect() as connection:
        # Display available countries in location drop down
        results = connection.execute(text(
            "SELECT address_country FROM location"))
        locations = sorted(set([row[0] for row in results]))

    condition = request.form.get('condition')
    nct = request.form.get('nct')
    location = request.form.get('location')
    status = request.form.get('status')
    phase = request.form.get('phase')
    type = request.form.get('type')
    sex = request.form.get('sex')
    age = request.form.get('age')
    treatment_type = request.form.get('treatment_type')
    start_date = request.form.get('start_date')
    end_date = request.form.get('end_date')
    results = []
    
    if request.method == 'POST':
        with engine.connect() as connection:
            results_query = ["SELECT * FROM clinical_trials"]
            # Initial join to display cancer type and treatment on results page
            results_query.append(
                    "JOIN study ON clinical_trials.nct = study.nct")
            where_clause = []

            # Modify search query if additional selectors are applied.
            if condition:
                where_clause.append(
                    f"UPPER(trial_name) LIKE UPPER('%{condition}%') OR "
                    f"UPPER(description) LIKE UPPER('%{condition}%') OR "
                    f"UPPER(cancer_type) LIKE UPPER('%{condition}%') OR "
                    f"UPPER(treatment) LIKE UPPER('%{condition}%')")
            if nct:
                if nct[:3].upper() == "NCT":
                    nct = nct[3:]
                
                # invalid NCT number
                if nct.isdigit():
                    where_clause.append(f"clinical_trials.nct = {nct}")
                else:
                    # invalid NCT number
                    where_clause.append(f"clinical_trials.nct = -1")

            if location:
                results_query.append(
                    "JOIN takes_place ON clinical_trials.nct = takes_place.nct")
                results_query.append(
                    "JOIN location ON "
                     "takes_place.location_name = location.location_name")
                where_clause.append(f"location.address_country = '{location}'")

            if status:
                where_clause.append(f"status = '{status}'")

            if sex or age:
                results_query.append(
                    "JOIN eligibility ON "
                     "(clinical_trials.age = eligibility.age "
                     "AND clinical_trials.sex = eligibility.sex)")
                if sex:
                    where_clause.append(f"eligibility.sex = '{sex}'")
                if age:
                    where_clause.append(f"'{age}' = ANY(eligibility.age)")

            if treatment_type:
                where_clause.append(f"treatment_type = UPPER('{treatment_type}')")

            if phase:
                where_clause.append(f"'{phase}' = ANY(eligibility.phase)")
            
            if type:
                where_clause.append(f"type = '{type}'")

            if start_date:
                where_clause.append(f"start_date >= '{start_date}'")

            if end_date:
                where_clause.append(f"end_date <= '{end_date}'")

            if where_clause:
                results_query.append("WHERE (" + 
                                     ") AND (".join(where_clause) + ")")
            
            results_query = " ".join(results_query)
            results = connection.execute(text(results_query)).fetchall()

    return render_template("results.html", condition=condition, status=status, 
                           location=location, results=results, 
                           locations=locations, phase=phase, type=type, sex=sex,
                           age=age, treatment_type=treatment_type, nct=nct,
                           start_date=start_date, end_date=end_date)


@app.route('/trialpage/<int:trial_id>')
@login_required
def trialpage(trial_id):
    """
    Construct trial page for a given trial id with all its details.
    """
    with engine.connect() as connection:
        results_query = (
            "SELECT * FROM clinical_trials clin "
            "JOIN eligibility elig ON (clin.age = elig.age "
                                 "AND clin.sex = elig.sex) "
            "JOIN study stud ON stud.nct = clin.nct "
            "JOIN condition con ON con.cancer_type = stud.cancer_type "
            "JOIN intervention int ON (int.treatment = stud.treatment "
                                "AND int.treatment_type = stud.treatment_type) "
            f"WHERE clin.nct = '{trial_id}'")

        results = connection.execute(text(results_query))

        locations_query = (
            "SELECT * FROM clinical_trials clin "
            "JOIN takes_place tp ON tp.nct = clin.nct "
            "JOIN location loc ON loc.location_name = tp.location_name "
            f"WHERE clin.nct = '{trial_id}'")

        locations = connection.execute(text(locations_query))

        sponsors_query = (
            "SELECT * FROM clinical_trials clin "
            "JOIN sponsors spon ON spon.nct = clin.nct "
            "JOIN institution inst ON "
                "inst.institution_name = spon.institution_name "
            f"WHERE clin.nct = '{trial_id}'")

        sponsors = connection.execute(text(sponsors_query))

    return render_template("trialpage.html", results = results, 
                           sponsors = sponsors, locations = locations)


@app.route('/account')
@login_required
def account():
    """
    Construct account page with saved clinical trials for current user.
    """
    with engine.connect() as connection:
        user_query = ("SELECT * FROM user_account "
                    f"WHERE user_name = '{session['name']}'")

        user = connection.execute(text(user_query))

        results_query = ("SELECT * FROM clinical_trials clin "
                        "JOIN study ON clin.nct = study.nct "
                        "JOIN saves sav ON sav.nct = clin.nct "
                        "JOIN user_account ua ON ua.user_name = sav.user_name "
                        f"WHERE ua.user_name = '{session['name']}'")

        results = connection.execute(text(results_query))

    return render_template("account.html", results = results, user = user)


@app.route('/saves/add', methods=['POST'])
@login_required
def add_save():
    """
    Save clinical trial to user account.
    """
    trial_id = request.form['trial_id']

    # Check if trial already saved
    save_query = (f"SELECT * FROM saves WHERE user_name = '{session['name']}' "
                  f"AND nct = '{trial_id}'")
    save_row = g.conn.execute(text(save_query)).fetchone()

    if not save_row:
        params = {"user_name": session['name'], "nct": trial_id}
        g.conn.execute(text("INSERT INTO saves(user_name, nct) "
                            "VALUES (:user_name, :nct)"), params)
        g.conn.commit()

    return redirect(url_for('trialpage', trial_id = trial_id))


@app.route('/saves/remove', methods=['POST'])
@login_required
def remove_save():
    """
    Remove clinical trial to user account.
    """
    trial_id = request.form['trial_id']

    # Check if trial is actually saved
    save_query = (f"SELECT * FROM saves WHERE user_name = '{session['name']}' "
                  f"AND nct = '{trial_id}'")
    save_row = g.conn.execute(text(save_query)).fetchone()

    if save_row:
        params = {"user_name": session['name'], "nct": trial_id}
        g.conn.execute(text("DELETE FROM saves WHERE user_name = :user_name "
                            "AND nct = :nct"), params)
        g.conn.commit()

    return redirect(url_for('trialpage', trial_id = trial_id))


if __name__ == "__main__":
    import click

    @click.command()
    @click.option('--debug', is_flag=True)
    @click.option('--threaded', is_flag=True)
    @click.argument('HOST', default='0.0.0.0')
    @click.argument('PORT', default=8111, type=int)
    def run(debug, threaded, host, port):
        """
        This function handles command line parameters.
        Run the server using:
            python server.py
        Show the help text using:
            python server.py --help
        """

        HOST, PORT = host, port
        print("running on %s:%d" % (HOST, PORT))
        app.run(host=HOST, port=PORT, debug=debug, threaded=threaded)

run()
"""
Columbia's COMS W4111.001 Introduction to Databases
Example Webserver
To run locally:
    python server.py
Go to http://localhost:8111 in your browser.
A debugger such as "pdb" may be helpful for debugging.
Read about it online.
"""
import os
#import psycopg2
# accessible as a variable in index.html:
from sqlalchemy import *
from sqlalchemy import exc
from sqlalchemy.pool import NullPool
from flask import Flask, request, render_template, g, redirect, Response, flash, url_for
from flask import session
import functools

tmpl_dir = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'templates')
app = Flask(__name__, template_folder=tmpl_dir)
app.secret_key = b'8b13a355666c9c10f40a910ee860189d327837989500d00c9dbf2849f56af334'

#
# The following is a dummy URI that does not connect to a valid database. You will need to modify it to connect to your Part 2 database in order to use the data.
#
# XXX: The URI should be in the format of:
#
#     postgresql://USER:PASSWORD@34.73.36.248/project1
#
# For example, if you had username zy2431 and password 123123, then the following line would be:
#
#     DATABASEURI = "postgresql://zy2431:123123@34.73.36.248/project1"
#
# Modify these with your own credentials you received from TA!
DATABASE_USERNAME = "htd2109"
DATABASE_PASSWRD = "2740"
DATABASE_HOST = "34.148.107.47"  # change to 34.28.53.86 if you used database 2 for part 2
DATABASEURI = f"postgresql://{DATABASE_USERNAME}:{DATABASE_PASSWRD}@{DATABASE_HOST}/project1"

#
# This line creates a database engine that knows how to connect to the URI above.
#
engine = create_engine(DATABASEURI)

#
# Example of running queries in your database
# Note that this will probably not work if you already have a table named 'test' in your database, containing meaningful data. This is only an example showing you how to run queries in your database using SQLAlchemy.
#
# with engine.connect() as conn:
#     pass

def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect('/login')

        return view(**kwargs)

    return wrapped_view

@app.before_request
def before_request():
    """
    This function is run at the beginning of every web request
    (every time you enter an address in the web browser).
    We use it to setup a database connection that can be used throughout the request.
    The variable g is globally accessible.
    """
    try:
        g.conn = engine.connect()
    except:
        print("uh oh, problem connecting to database")
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
                'SELECT * FROM user_account WHERE user_name = (:param_name)'), params
            ).fetchone()

@app.teardown_request
def teardown_request(exception):
    """
    At the end of the web request, this makes sure to close the database connection.
    If you don't, the database could run out of memory!
    """
    try:
        g.conn.close()
    except Exception as e:
        pass


#
# @app.route is a decorator around index() that means:
#   run index() whenever the user tries to access the "/" path using a GET request
#
# If you wanted the user to go to, for example, localhost:8111/foobar/ with POST or GET then you could use:
#
#       @app.route("/foobar/", methods=["POST", "GET"])
#
# PROTIP: (the trailing / in the path is important)
#
# see for routing: https://flask.palletsprojects.com/en/1.1.x/quickstart/#routing
# see for decorators: http://simeonfranklin.com/blog/2012/jul/1/python-decorators-in-12-steps/

@app.route('/register', methods=('GET', 'POST'))
def login_create():
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
                # insert_table_command = "INSERT INTO user_account(user_name, user_phone_number, user_email, user_password) VALUES ({u}, {p}, {e}, {pa})".format(u = username, p = phone, e = email, pa = password)
                params = {}
                params["new_name"] = username
                params["new_password"] = password
                params["new_phone"] = phone
                params["new_email"] = email
                
                g.conn.execute(text('INSERT INTO user_account(user_name, user_phone_number, user_email, user_password) \
                                    VALUES (:new_name, :new_phone, :new_email, :new_password)'), params)
                g.conn.commit()   
            except exc.IntegrityError:
                error = f"User {username} is already registered."
            else:
                return redirect("/login")

        flash(error)

    return render_template('register.html')

@app.route('/login', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        error = None
        params = {}
        params["param_name"] = username
        user = g.conn.execute(text(
            'SELECT * FROM user_account WHERE user_name = (:param_name)'), params
        ).fetchone()

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
    

#Homepage
@app.route('/', methods=['GET', 'POST'])
@login_required
def homepage():
    with engine.connect() as connection:
        location_query = "SELECT location_name FROM location"
        result = connection.execute(text(location_query))
        locations = [row[0] for row in result]

    if request.method == 'POST':
        location = request.form.get('location')
        status = request.form.get('status')
        condition = request.form.get('condition')
        return redirect(url_for('results', location=location, status=status, condition=condition))

    return render_template("homepage.html", locations=locations)


@app.route('/results', methods=['GET', 'POST'])
@login_required
def results():
    location = request.form.get('location')
    status = request.form.get('status')
    condition = request.form.get('condition')

    with engine.connect() as connection:
        results_query = "SELECT * FROM clinical_trials"
        input = []

        if location:
            input.append("UPPER(location.location_name) = UPPER('{}')".format(location))
            results_query += " JOIN takes_place ON clinical_trials.nct = takes_place.nct"
            results_query += " JOIN location ON takes_place.location_name = location.location_name"
        if status != 'all':
            input.append("UPPER(status) = UPPER('{}')".format(status))
        if condition:
            input.append(
                "UPPER(trial_name) LIKE UPPER('%{}%') OR UPPER(description) LIKE UPPER('%{}%')".format(condition,
                                                                                                       condition))
        if input:
            results_query += " WHERE (" + ") AND (".join(input) + ")"

        results = connection.execute(text(results_query)).fetchall()

    return render_template("results.html", condition=condition, status=status, location=location, results = results)

@app.route('/trialpage/<int:trial_id>')
@login_required
def trialpage(trial_id):
    with engine.connect() as connection:
        results_query = "SELECT DISTINCT * FROM clinical_trials clin \
                        JOIN sponsors spon ON spon.nct = clin.nct \
                        JOIN institution inst ON inst.institution_name = spon.institution_name \
                        JOIN eligibility elig ON clin.eligibility_id = elig.eligibility_id \
                        JOIN takes_place tp ON tp.nct = clin.nct \
                        JOIN location loc ON loc.location_name = tp.location_name \
                        JOIN study stud ON stud.nct = clin.nct \
                        JOIN condition con ON con.cancer_type = stud.cancer_type \
                        JOIN intervention int ON int.treatment = stud.treatment AND int.treatment_type = stud.treatment_type \
                        WHERE clin.nct = '{}'".format(trial_id)

        results = connection.execute(text(results_query)).fetchone()

    return render_template("trialpage.html", results = results)

@app.route('/invalidsearch')
@login_required
def invalidsearch():
    return render_template("invalidsearch.html")

@app.route('/account')
@login_required
def account():
    with engine.connect() as connection:
        user_query = "SELECT * \
                        FROM user_account \
                        WHERE user_name = '{}'".format(session['name'])

        user = connection.execute(text(user_query))

        results_query = "SELECT * \
                        FROM clinical_trials clin \
                        JOIN saves sav ON sav.nct = clin.nct\
                        JOIN user_account ua ON ua.user_name = sav.user_name\
                        WHERE ua.user_name = '{}'".format(session['name'])

        results = connection.execute(text(results_query))

    return render_template("account.html", results = results, user = user)


@app.route('/saves/add', methods=['POST'])
@login_required
def add_save():
    trial_id = request.form['trial_id']
    institution_query = "SELECT institution_name FROM sponsors WHERE nct = {}".format(trial_id)
    institution_row = g.conn.execute(text(institution_query)).fetchone()
    institution = institution_row[0]

    params = {}
    params["username"] = "test"
    params["nct"] = trial_id
    params["institution"] = institution

    g.conn.execute(text("INSERT INTO saves (user_name,nct, institution_name) VALUES (:username, :nct, :institution)"),
                           params)
    g.conn.commit()

    '''TO DO
    favorited status on page
    unfavorite button
    prevent error when already favorited or unfavorited'''

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
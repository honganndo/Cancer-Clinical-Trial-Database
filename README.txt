Group 49
Hong-Ann Do
Peter Ma

PostgreSQL account: htd2109 (34.148.107.47)
URL:

The cancer clinical database created allows for users to to search cancer
clinical trials based on the condition/keyword. Users initially can select a
location as well as status of the trial. After pressing the search button, they
are taken to a results page that lists out all the clinical trials that satisfy
the search criteria. These entries are displayed in a table that lists the trial
name, description, status, number of patients, type, and phase of each. Users
have the option to further refine their search with additional search options
such as status, phase, type, sex, and location of the trial. Clicking into a
particular trial brings the user to that trial page. Here, the full description
and information of the trial is shown. Users also now have the option to save
the clincial trial.

An additional feature that we implemented was the creation of an user account
to access and save clinical trials for future use. When first accessing the
database, they are prompted to either login or to create a new account.
Afterwards, they can interact with the database logged in to their account and
log out when they are done. While logged in, users can save and unsave clinical
trials that they are interested in. These saves persist across logins and can be
viewed by the user under their account page.

The questionnaire form that was initially proposed was not implemented because
the database interface is simple and easily usable already. It would be
redundant to make users undergo a subsequent screening just to access the same
database functionalities.

The results web page provides the most interesting database operations as it
combines various parameters and inputs from the search bar and dropdown menu
options. Using these, it constructs a query that spans multiple data tables in
order to return the relevant results that the user wants. The query is pieced
together from different strings depending on if the user selected an option or
left it blank. This page is the crux of the database and what users are there to
see.

The login/register pages are also very interesting because they allow for the
creation of user accounts that store information accross sessions. The register
page inserts the inputted information for a new user into the user_account data
table, ensuring the integrity constraint of no duplicate users. The login page
checks that a username exists in the user_account data table and also that the
inputted password is correct. Finally after a user logs in, the clinical trials
that they save will be saved to their account and viewable in future visits to
the site.
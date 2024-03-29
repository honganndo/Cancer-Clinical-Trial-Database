# Cancer Clinical Trial Database

![Cancer Clinical Trial results page screenshot](./images/results_screenshot-2.png "Cancer Clinical Trial results page screenshot")

## Overview
Cancer is one of the deadliest diseases in the world and yet there is still no true cure for it. Many clinical trials are currently underway with the goal of providing better outcomes than standard treatments. We design a simple cancer clinical trial database that helps cancer patients navigate through various available trials. The database allows users to search through and learn more about each trial including the cancer type, interventions, and outcomes being studied; the times and locations each study takes place; the eligibility criteria for patients that are being accepted; as well as the institutions and sponsors that are conducting each study. Clinical trials can also be further filtered by various study parameters. Lastly, users can create an account to save clinical trials of their interest.

Project based on and sample data entries taken from [ClinicalTrials.gov](https://www.clinicaltrials.gov/).

## Log
**Notes**
- PostgreSQL database export provided as CCTexport.pgsql.
- PostgreSQL table declarations for database schema shown in documentation/schema.md.
- Sample data taken from ClinicalTrials.gov contained in documentation/Data Entries for Cancer Clinical Trials.xlsx.

**July 2023**
- Documentation updated and cleaned up by Peter. Added CSS styling, JavaScript event listeners, and additional application functionality.

**January - April 2023**
- Created by Ann and Peter as part of a project for the introduction to databases course at Columbia University. Frontend was implemented using HTML, backend using Python and Flask, and database using PostgreSQL.

## Features
**Entity–relationship model**
![Cancer Clinical Trial Database ER diagram](./images/er-diagram.png "Cancer Clinical Trial Database ER diagram")

**Web application**
- Web server implemented using Flask to handle web requests and database connection. HTML is dynamically generated using Jinja templates.

**Database queries**
- Various parameters and inputs from the search bar and dropdown menu options are combined to form a valid database query. The query operates across multiple data tables to return the relevant information in the results page. 

**User accounts**
- User accounts can be created to store clinical trials across web sessions. The register/login page allows for creation of new users (ensuring the integrity constraint of no duplicate users) as well as validation of username and password of returning users.

## Usage
Import the cancer clinical trial PostgreSQL database stored in `CCTexport.pgsql`:
```
$ psql -U username dbname < CCTexport.pgsql
```

To run server:
```
$ python server.py
```

**Packages Required**
- flask
- psycopg2
- sqlalchemy
- click
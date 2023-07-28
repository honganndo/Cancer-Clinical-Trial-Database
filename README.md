# Cancer Clinical Trial Database

## Overview
Cancer is one of the deadliest diseases in the world and yet there is still no true cure for it. Many clinical trials are currently underway with the goal of providing better outcomes than standard treatments. We design a simple cancer clinical trial database that helps cancer patients navigate through various available trials. The database allows users to search through and learn more about each trial including the cancer type, interventions, and outcomes being studied; the times and locations each study takes place; the eligibility criteria for patients that are being accepted; as well as the institutions and sponsors that are conducting each study. Clinical trials can also be further filtered by status, phase, type, sex, and location of the trial. Lastly, users can create an account to save clincial trials of their interest.

## Log
**July 2023**
Documentation updated and cleaned up by Peter. Frontend refactored with CSS and JS.

**January - April 2023**
Created by Ann and Peter as part of a project for the introduction to databases course at Columbia University. Frontend was implemented using HTML, backend using Python and Flask, and database using PostgreSQL.

## Features
Entity–relationship model:
![Cancer Clinical Trial Database ER diagram](./images/er.png "Cancer Clinical Trial Database ER diagram")

Database queries:
Various parameters and inputs from the search bar and dropdown menu options are combined to form a valid database query. The query operates across multiple data tables to return the relevant information in the results page. 

User accounts:
User accounts can be created to store clinical trials accross web sessions. The register/login page allows for creation of new users (ensuring the integrity constraint of no duplicate users) as well as validation of username and password of returning users.
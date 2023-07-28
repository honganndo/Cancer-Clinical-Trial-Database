# Cancer Clinical Trials Database Schema
PostgreSQL table declarations for database schema.

```sql
CREATE TABLE clinical_trials (
	NCT numeric(8, 0),
	trial_name varchar(120) NOT NULL,
	description varchar(500),
	status varchar(30) CHECK (status in ('not yet recruiting', 'actively recruiting', 'completed')) NOT NULL,
	number_of_patients int CHECK (number_of_patients >= 0) NOT NULL,
	type varchar(20) CHECK (type in ('interventional', 'observational')) NOT NULL,
	phase varchar(20) CHECK (phase in ('Early Phase', 'Phase 1', 'Phase 2', 'Phase 3', 'Phase 4')),
	start_date date NOT NULL,
	end_date date NOT NULL,	
	CHECK (end_date > start_date),
	PRIMARY KEY (NCT),
	eligibility_id varchar(20),
	FOREIGN KEY (eligibility_id) REFERENCES eligibility(eligibility_id) ON DELETE RESTRICT
);
```
```sql
CREATE TABLE institution (
	institution_name varchar(100),
	contact_person_name varchar(30),
	phone_number varchar(20) NOT NULL,
	email varchar(50) NOT NULL,
	address_street varchar(50),
	address_city varchar(30),
	address_state varchar(30),
	address_zipcode varchar(10),
	address_country varchar(30),
	PRIMARY KEY (institution_name)
);
```
```sql
CREATE TABLE sponsors (
	NCT numeric(8, 0),
	institution_name varchar(100),
	PRIMARY KEY (NCT, institution_name),
	FOREIGN KEY (NCT) REFERENCES clinical_trials(NCT) ON DELETE SET NULL,
	FOREIGN KEY (institution_name) REFERENCES institution(institution_name) ON DELETE SET NULL
);
```
```sql
CREATE TABLE eligibility (
	eligibility_id varchar(20),
	min_age int CHECK (min_age >= 0) NOT NULL,
	max_age int NOT NULL,
	CHECK (max_age > min_age),
	sex varchar(6) CHECK (sex in ('male', 'female')), 
	inclusion_exclusion_criteria varchar(500),
	PRIMARY KEY (eligibility_id)
);
```
```sql
CREATE TABLE location (
	location_name varchar(100) NOT NULL,
	address_street varchar(50) NOT NULL,
	address_city varchar(30) NOT NULL,
	address_state varchar(30),
	address_zipcode varchar(10),
	address_country varchar(30) NOT NULL,
	PRIMARY KEY (location_name)
);
```
```sql
CREATE TABLE takes_place (
	location_name varchar(100),
	NCT numeric(8, 0),
	PRIMARY KEY (NCT, location_name),
	FOREIGN KEY (NCT) REFERENCES clinical_trials(NCT) ON DELETE RESTRICT,
	FOREIGN KEY (location_name) REFERENCES location(location_name) ON DELETE RESTRICT
);
```
```sql
CREATE TABLE condition (
	cancer_type varchar(50),
	cancer_stage varchar(3) CHECK (cancer_stage in ('0', 'I', 'II', 'III', 'IV')),
	PRIMARY KEY (cancer_type)
);
```
```sql
CREATE TABLE intervention (
	treatment varchar(50),
	treatment_type varchar(50),
	PRIMARY KEY (treatment, treatment_type)
);
```
```sql
CREATE TABLE study (
	primary_measurements varchar(500),
	secondary_measurements varchar(500),
	other varchar(500),
	NCT numeric(8, 0),
	cancer_type varchar(50),
	treatment varchar(50),
	treatment_type varchar(50),
	PRIMARY KEY (NCT, cancer_type, treatment, treatment_type),
	FOREIGN KEY (NCT) REFERENCES clinical_trials(NCT) ON DELETE CASCADE,
	FOREIGN KEY (cancer_type) REFERENCES condition(cancer_type) ON DELETE RESTRICT,
	FOREIGN KEY (treatment, treatment_type) REFERENCES intervention(treatment, treatment_type) ON DELETE RESTRICT
);
```
```sql
CREATE TABLE user_account (
	user_name varchar(30),
	user_phone_number varchar(20),
	user_email varchar(50) NOT NULL,
	user_password varchar(50) NOT NULL,
	PRIMARY KEY (user_name)
);
```
```sql
CREATE TABLE saves (
	user_name varchar(30),
	NCT numeric(8, 0),
	institution_name varchar(100),
	PRIMARY KEY (user_name, NCT, institution_name),
	FOREIGN KEY (user_name) REFERENCES user_account(user_name) ON DELETE CASCADE,
	FOREIGN KEY (NCT) REFERENCES clinical_trials(NCT) ON DELETE CASCADE,
	FOREIGN KEY (institution_name ) REFERENCES institution(institution_name ) ON DELETE CASCADE
);
```

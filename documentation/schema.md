# Cancer Clinical Trials Database Schema
PostgreSQL table declarations for database schema.

```sql
CREATE TABLE clinical_trials (
	NCT numeric(8, 0),
	trial_name text NOT NULL,
	description text,
	status varchar(30) CHECK (status in ('active not recruiting', 'enrolling by invitation', 'not yet recruiting','recruiting', 'terminated', 'unknown', 'withdrawn', 'completed')) NOT NULL,
	number_of_patients int CHECK (number_of_patients >= 0) NOT NULL,
	type varchar(20) CHECK (type in ('interventional', 'observational')) NOT NULL,
	phase text[] CHECK(phase <@ ARRAY['n/a', 'early phase 1', 'phase 1', 'phase 2', 'phase 3', 'phase 4']),
	start_date date NOT NULL,
	end_date date NOT NULL,	
	CHECK (end_date > start_date),
	PRIMARY KEY (NCT),
	age text[],
	sex varchar(6),
	FOREIGN KEY (age, sex) REFERENCES eligibility(age, sex) ON DELETE RESTRICT
);
```
```sql
CREATE TABLE institution (
	institution_name text,
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
	institution_name text,
	PRIMARY KEY (NCT, institution_name),
	FOREIGN KEY (NCT) REFERENCES clinical_trials(NCT) ON DELETE SET NULL,
	FOREIGN KEY (institution_name) REFERENCES institution(institution_name) ON DELETE SET NULL
);
```
```sql
CREATE TABLE eligibility (
	age text[] CHECK(age <@ ARRAY['child', 'adult', 'older adult']),
	sex varchar(6) CHECK (sex in ('male', 'female', 'all')),
	PRIMARY KEY (age, sex)
);
```
```sql
CREATE TABLE location (
	location_name text NOT NULL,
	address_city varchar(30) NOT NULL,
	address_state varchar(30),
	address_zipcode varchar(30),
	address_country varchar(30) NOT NULL,
	PRIMARY KEY (location_name)
);
```
```sql
CREATE TABLE takes_place (
	location_name text,
	NCT numeric(8, 0),
	PRIMARY KEY (NCT, location_name),
	FOREIGN KEY (NCT) REFERENCES clinical_trials(NCT) ON DELETE RESTRICT,
	FOREIGN KEY (location_name) REFERENCES location(location_name) ON DELETE RESTRICT
);
```
```sql
CREATE TABLE condition (
	cancer_type text,
	PRIMARY KEY (cancer_type)
);
```
```sql
CREATE TABLE intervention (
	treatment varchar(200),
	treatment_type varchar(50),
	PRIMARY KEY (treatment, treatment_type)
);
```
```sql
CREATE TABLE study (
	primary_measurements text,
	secondary_measurements text,
	other text,
	NCT numeric(8, 0),
	cancer_type text,
	treatment varchar(200),
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
	institution_name text,
	PRIMARY KEY (user_name, NCT, institution_name),
	FOREIGN KEY (user_name) REFERENCES user_account(user_name) ON DELETE CASCADE,
	FOREIGN KEY (NCT) REFERENCES clinical_trials(NCT) ON DELETE CASCADE,
	FOREIGN KEY (institution_name ) REFERENCES institution(institution_name ) ON DELETE CASCADE
);
```

# Cancer Clinical Trials Database PostgreSQL Schema
```sql
CREATE TABLE clinical_trials (
    NCT         numeric(8, 0),
    trial_name  varchar(120) NOT NULL,
    description varchar(500),
    status      varchar(30) check (status in ('not yet recruiting', 'actively recruiting', 'completed')) NOT NULL,
    number_of_patients int check (number_of_patients >= 0) not null,
    type        varchar(20) check (type in ('interventional', 'observational')) NOT NULL,
    phase       varchar(20) check (phase in ('Early Phase', 'Phase 1', 'Phase 2', 'Phase 3', 'Phase 4')),
    start_date  date not null,
    end_date    date not null,	
    check (end_date > start_date),
    primary key (NCT),
    eligibility_id varchar(20),
    foreign key (eligibility_id) references eligibility(eligibility_id) ON DELETE RESTRICT
);
```
```sql
create table institution (
	institution_name 	    varchar(100),
	contact_person_name 	varchar(30),
	phone_number		    varchar(20) not null,
	email			        varchar(50) not null,
	address_street 	        varchar(50),
	address_city		    varchar(30),
	address_state		    varchar(30),
	address_zipcode 	    varchar(10),
	address_country 	    varchar(30),
    primary key(institution_name)
);
```

create table sponsors (
	sponsor_id 		numeric(8, 0),
NCT 			numeric(8, 0),
institution_name 	varchar(100),
	primary key(sponsor_id),
	foreign key (NCT) references clinical_trials(NCT) ON DELETE SET NULL,
foreign key (institution_name) references institution(institution_name) ON DELETE SET NULL
);


create table eligibility (
	eligibility_id varchar(20),
	min_age  int check (min_age >= 0) not null,
max_age  int not null,
check (max_age > min_age),
sex varchar(6) check (sex in ('male', 'female')), 
inclusion_exclusion_criteria varchar(500),
primary key(eligibility_id)
); 

create table location (
	location_name 	varchar(100) not null,
	address_street 	varchar(50) not null,
	address_city		varchar(30) not null,
	address_state		varchar(30),
	address_zipcode 	varchar(10),
	address_country 	varchar(30) not null,
primary key(location_name)
);

create table takes_place (
	location_name 	varchar(100),
NCT 			numeric(8, 0),
	primary key(NCT, location_name),
	foreign key (NCT) references clinical_trials(NCT) ON DELETE RESTRICT,
foreign key (location_name) references location(location_name) ON DELETE RESTRICT
);

create table condition (
	cancer_type 	varchar(50),
	cancer_stage	varchar(3) check (cancer_stage in ('0', 'I', 'II', 'III', 'IV')),
primary key(cancer_type)
);

create table intervention (
	treatment 	varchar(50),
treatment_type		varchar(50),
primary key(treatment, treatment_type)
);

create table study (
	primary_measurements 	varchar(500),
secondary_measurements 	varchar(500),
other 				varchar(500),
NCT 				numeric(8, 0),
cancer_type 			varchar(50),
treatment 			varchar(50),
treatment_type				varchar(50),
primary key(NCT, cancer_type, treatment, treatment_type),
foreign key (NCT) references clinical_trials(NCT) ON DELETE CASCADE,
foreign key (cancer_type) references condition(cancer_type) ON DELETE RESTRICT,
foreign key (treatment, treatment_type) references intervention(treatment, treatment_type) ON DELETE RESTRICT
);

create table user_account (
	user_name 		varchar(30),
user_phone_number	varchar(20),
user_email 		varchar(50) not null,
user_password		varchar(50) not null,
primary key(user_name)
);

create table saves (
	user_name 		varchar(30),
NCT 			numeric(8, 0),
institution_name 	varchar(100),
	primary key(user_name, NCT, institution_name),
foreign key (user_name) references user_account(user_name) ON DELETE CASCADE,
	foreign key (NCT) references clinical_trials(NCT) ON DELETE CASCADE,
	foreign key (institution_name ) references institution(institution_name ) ON DELETE CASCADE
);

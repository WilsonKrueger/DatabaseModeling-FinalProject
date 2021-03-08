/* ====================================================================
--	SQL Script for Clinic Database Records
--	This script will drop and then re-create the tables for the
--	Clinic database. 
--	Created by: Wilson Krueger, Madeline Warner, Clara Skeim
--	Created on: 12/4/2020
--	Modified by: Clara
--	Modified on: 12/4/2020- insert records for patient, physician, skill, & prescription
--	Modified by: Madeline
--	Modified on: 12/4/2020- insert records for clinic, phys_skill, & appointment
--	Modified by: Madeline, Wilson, Clara
--	Modified on: 12/4/2020- insert records for list
--	Modified by: Wilson
--	Modified on: 12/6/2020- insert records for phys_skill
--  Modified on: 12/8/2020- insert records for patient, physician, & appointment
-- ==================================================================== */

-- DROP all tables from previous uses of Clinic Database if they are stored
IF OBJECT_ID ('list')			IS NOT NULL		DROP TABLE list;
IF OBJECT_ID ('phys_skill')		IS NOT NULL		DROP TABLE phys_skill;
IF OBJECT_ID ('appointment')	IS NOT NULL     DROP TABLE appointment;
IF OBJECT_ID ('prescription')	IS NOT NULL     DROP TABLE prescription;
IF OBJECT_ID ('physician')		IS NOT NULL     DROP TABLE physician;
IF OBJECT_ID ('skill')			IS NOT NULL     DROP TABLE skill;
IF OBJECT_ID ('clinic')			IS NOT NULL     DROP TABLE clinic;
IF OBJECT_ID ('patient')		IS NOT NULL     DROP TABLE patient;

-- Create the patient table
CREATE TABLE patient (
	pat_id				VARCHAR(10)		NOT NULL	UNIQUE,
	pat_fname			VARCHAR(30)		NOT NULL,
	pat_lname			VARCHAR(30)		NOT NULL,
	pat_dob				DATE			NOT NULL,
	pat_gender			CHAR(1),
	pat_street			VARCHAR(40)		NOT NULL,
	pat_city			VARCHAR(20)		NOT NULL,
	pat_state			CHAR(2)			NOT NULL,
	pat_zip				CHAR(5)			NOT NULL,
	pat_county			VARCHAR(30),
	pat_phone			CHAR(12),
	pat_email			VARCHAR(30),
	pat_status			CHAR(1)			NOT NULL,
	pat_created_by		VARCHAR(30)		NOT NULL,
	pat_created_on		DATETIME		NOT NULL,
	pat_modified_by		VARCHAR(30),
	pat_modified_on		DATETIME,
PRIMARY KEY(pat_id));

-- Create the clinic table
CREATE TABLE clinic (
	clinic_num          VARCHAR(10)     NOT NULL    UNIQUE,
	clinic_name         VARCHAR(60)		NOT NULL,
	clinic_street       VARCHAR(40)		NOT NULL,
	clinic_city		    VARCHAR(20)		NOT NULL,
	clinic_state        CHAR(2)			NOT NULL,
	clinic_zip          CHAR(5)			NOT NULL,
	clinic_dt_of_op     VARCHAR(10),
	clinic_stime		TIME(0),
	clinic_etime		TIME(0),
	clinic_phone		CHAR(12),
PRIMARY KEY(clinic_num));

-- Create the skill table
CREATE TABLE skill (
	skill_id	        VARCHAR(10)     NOT NULL    UNIQUE,
	skill_name			VARCHAR(20)		NOT NULL,
	skill_descript      VARCHAR(45),
PRIMARY KEY(skill_id));

-- Create the physician table
CREATE TABLE physician (
	phys_id				VARCHAR(10)     NOT NULL    UNIQUE,
	clinic_num			VARCHAR(10)		NOT NULL,
	phys_license		CHAR(2)			NOT NULL,
	phys_fname			VARCHAR(30)		NOT NULL,
	phys_lname			VARCHAR(30)		NOT NULL,
	phys_stime			TIME(0),
	phys_etime			TIME(0),
	phys_status			CHAR(1)			NOT NULL,
PRIMARY KEY(phys_id),
FOREIGN KEY(clinic_num) REFERENCES clinic);

-- Create the prescription table
CREATE TABLE prescription (
	presc_num			VARCHAR(10)		NOT NULL    UNIQUE,
	pat_id				VARCHAR(10)		NOT NULL,
	phys_id				VARCHAR(10)		NOT NULL,
	presc_generic		VARCHAR(20)		NOT NULL,
	presc_brand			VARCHAR(20),
	presc_usage			VARCHAR(40)		NOT NULL,
	presc_dosage		VARCHAR(15),
	presc_start			DATE			NOT NULL,
	presc_status		CHAR(1)			NOT NULL,
PRIMARY KEY(presc_num),
FOREIGN KEY(pat_id)		REFERENCES patient,
FOREIGN KEY(phys_id)	REFERENCES physician);

-- Create the appointment table
CREATE TABLE appointment (
	app_num				VARCHAR(10)		NOT NULL    UNIQUE,
	pat_id				VARCHAR(10)		NOT NULL,
	phys_id				VARCHAR(10)		NOT NULL,
	app_type			VARCHAR(30)		NOT NULL,
	app_descript		VARCHAR(50),
	app_stime			DATETIME		NOT NULL,
	app_etime			DATETIME,
PRIMARY KEY(app_num),
FOREIGN KEY(pat_id)		REFERENCES patient,
FOREIGN KEY(phys_id)    REFERENCES physician);

-- Create the phys_skill table
CREATE TABLE phys_skill (
	phys_id				VARCHAR(10)		NOT NULL,
	skill_id			VARCHAR(10)		NOT NULL,
PRIMARY KEY(phys_id, skill_id),
FOREIGN KEY(phys_id)    REFERENCES physician,
FOREIGN KEY(skill_id)   REFERENCES skill);

-- Create the list table
CREATE TABLE list (
	list_id			VARCHAR(10)		NOT NULL    UNIQUE,
	list_name       VARCHAR(15)		NOT NULL,
	list_display    VARCHAR(50),
	list_value      VARCHAR(50),
	list_status     CHAR(1)			NOT NULL,
PRIMARY KEY(list_id));

-- Create patient records
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000001', 'Sharon', 'Vontrap', '04-JAN-1990', NULL, '140 2nd St', 'Esko', 'MN', '55742', 'Saint Louis', NULL, NULL, 'A', 'Sally Swanson', '08-AUG-2008', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000002', 'Florence', 'Skilling', '18-MAR-2000', 'F', '1547 Goldenrod Ln', 'Milaca', 'MN', '56353', 'Mille Lacs', NULL, NULL, 'A', 'Sally Swanson', '18-MAR-2019', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000003', 'Shailene', 'Hanson', '24-APR-1971', NULL, '5400 3rd St S', 'Mora', 'MN', '55051', 'Kanabec', NULL, NULL, 'A', 'Gloria Weston', '06-JUN-1985', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000004', 'Harry', 'Stewart', '11-NOV-2007', 'M', '42 Wallaby Way', 'Princeton', 'MN', '55371', 'Sherburne', NULL, NULL, 'A', 'Trey Anderson', '02-FEB-2018', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000005', 'Cecilia', 'Crason', '31-OCT-1993', NULL, '1300 2nd St W', 'Foley', 'MN', '56458', 'Benton', NULL, NULL, 'A', 'Gloria Weston', '01-NOV-2014', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000006', 'Stephanie', 'Medina', '14-FEB-1999', 'F', '3344 Plum St', 'Mora', 'MN', '55051', 'Kanabec', '320-364-5676', 'smedina@email.com', 'A', 'Gloria Weston', '05-MAR-2013', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000007', 'Henry', 'Henderson', '19-OCT-1991', NULL, '5435 Journey Ave', 'Foley', 'MN', '56458', 'Benton', '744-432-6443', 'hh2@email.com', 'A', 'Sally Swanson', '08-JUN-2001', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000008', 'Molly', 'Sentin', '03-MAY-2006', 'F', '501 Lengend Cir', 'North Branch', 'MN', '55032', 'Chisago', '654-766-9594', 'mollysentin@email.com', 'A', 'Trey Anderson', '11-DEC-2019', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000009', 'Addie', 'Hawkinson', '01-MAY-2001', 'F', '212 Maple St N', 'Milaca', 'MN', '56353', 'Mille Lacs', '951-345-6543', 'addiehawk@email.com', 'A', 'Gloria Weston', '17-JUL-2016', NULL, NULL);
INSERT INTO patient(pat_id, pat_fname, pat_lname, pat_dob, pat_gender, pat_street, pat_city, pat_state, pat_zip, pat_county, pat_phone, pat_email, pat_status, pat_created_by, pat_created_on, pat_modified_by, pat_modified_on)
	VALUES('1000010', 'Brenna', 'Menton', '18-AUG-1998', 'F', '4532 Bear Ave', 'Foley', 'MN', '56458', 'Benton', '432-745-5920', 'bmenton@email.com', 'A', 'Sally Swanson', '27-OCT-2010', NULL, NULL);

-- Create clinic records
INSERT INTO clinic(clinic_num, clinic_name, clinic_street, clinic_city, clinic_state, clinic_zip, clinic_dt_of_op, clinic_stime, clinic_etime, clinic_phone)
	VALUES('2000001', 'Fairview Lakes North Branch Clinic', '5366 386th Street', 'North Branch', 'MN', '55056', 'Thursday', '18:00', '21:00', '651-674-6726');
INSERT INTO clinic(clinic_num, clinic_name, clinic_street, clinic_city, clinic_state, clinic_zip, clinic_dt_of_op, clinic_stime, clinic_etime, clinic_phone)
	VALUES('2000002', 'Kanabec County Public Service Building', '905 E Forest Avenue', 'Mora', 'MN', '55051', 'Monday','15:00', '19:00', '320-674-6726');
INSERT INTO clinic(clinic_num, clinic_name, clinic_street, clinic_city, clinic_state, clinic_zip, clinic_dt_of_op, clinic_stime, clinic_etime, clinic_phone)
	VALUES('2000003', 'Outlook Clinic Chisago City', '10510 South Ave W', 'Chisago City', 'MN', '55013', 'Tuesday', '10:00', '17:00', '612-674-6726');
INSERT INTO clinic(clinic_num, clinic_name, clinic_street, clinic_city, clinic_state, clinic_zip, clinic_dt_of_op, clinic_stime, clinic_etime, clinic_phone)
	VALUES('2000004', 'Lower level of Isanti County Government Center Building', '555 SW 18th Ave', 'Cambridge', 'MN', '55008', 'Thursday', '13:00', '17:00','712-674-6726' );
INSERT INTO clinic(clinic_num, clinic_name, clinic_street, clinic_city, clinic_state, clinic_zip, clinic_dt_of_op, clinic_stime, clinic_etime, clinic_phone)
	VALUES('2000005', 'Hibbing Fairview Clinic', '11065 Spudville Road', 'Hibbing', 'MN', '55746', 'Wednesday', '10:00', '14:00', '218-674-6726');

-- Create skill records
INSERT INTO skill(skill_id, skill_name, skill_descript)
	VALUES('3000001', 'IUD', NULL);
INSERT INTO skill(skill_id, skill_name, skill_descript)
	VALUES('3000002', 'Vasectomy', NULL);
INSERT INTO skill(skill_id, skill_name, skill_descript)
	VALUES('3000003', 'Colposcopy', NULL);
INSERT INTO skill(skill_id, skill_name, skill_descript)
	VALUES('3000004', 'Telemedicine', NULL);
INSERT INTO skill(skill_id, skill_name, skill_descript)
	VALUES('3000005', 'Nexplanon', NULL);

-- Create physician records
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000001', '2000001', 'NP', 'Anna', 'Henderson', '18:15', NULL, 'A' );
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000002', '2000002', 'PA', 'Heather', 'Lund', '15:15', NULL, 'A' );
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000003', '2000003', 'NP', 'Jacob', 'Borich', '10:15', NULL, 'A' );
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000004', '2000004', 'PA', 'Rich', 'Mayer', '13:15', NULL, 'A' );
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000005', '2000005', 'MD', 'Claire', 'McGregor', '10:15', NULL, 'A' );
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000006', '2000005', 'NP', 'Steven', 'Anderson', '10:15', NULL, 'A' );
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000007', '2000003', 'PA', 'Hector', 'Vondreel', '11:15', NULL, 'A' );
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000008', '2000001', 'MD', 'Jonathan', 'Yonson', '18:15', NULL, 'A' );
INSERT INTO physician(phys_id, clinic_num, phys_license, phys_fname, phys_lname, phys_stime, phys_etime, phys_status)
	VALUES('4000009', '2000001', 'PA', 'Isaac', 'Newman', '19:15', NULL, 'A' );

-- Create prescription records
INSERT INTO prescription(presc_num, pat_id, phys_id, presc_generic, presc_brand, presc_usage, presc_dosage, presc_start, presc_status)
	VALUES('5000001', '1000001', '4000001', 'coc', NULL, 'Twice Daily', '30mg', '01-JAN-2010', 'A');
INSERT INTO prescription(presc_num, pat_id, phys_id, presc_generic, presc_brand, presc_usage, presc_dosage, presc_start, presc_status)
	VALUES('5000002', '1000002', '4000002', 'pop', NULL, 'Once Daily', '20mg', '19-MAR-2019', 'A');
INSERT INTO prescription(presc_num, pat_id, phys_id, presc_generic, presc_brand, presc_usage, presc_dosage, presc_start, presc_status)
	VALUES('5000003', '1000003', '4000003', 'depoprevera', NULL, 'Once Daily', '30mg', '15-DEC-1990', 'A');
INSERT INTO prescription(presc_num, pat_id, phys_id, presc_generic, presc_brand, presc_usage, presc_dosage, presc_start, presc_status)
	VALUES('5000004', '1000004', '4000004', 'nexplanon', NULL, 'Once every four years', NULL, '01-FEB-2020', 'A');
INSERT INTO prescription(presc_num, pat_id, phys_id, presc_generic, presc_brand, presc_usage, presc_dosage, presc_start, presc_status)
	VALUES('5000005', '1000005', '4000005', 'iud', NULL, 'Once every three years', NULL, '14-JUL-2016', 'A');

-- Create appointment records
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000001','1000001', '4000002', 'Medication Review', NULL, '01-JAN-2021 15:15', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000002','1000002', '4000003', 'Follow Up', NULL, '22-DEC-2020 12:15', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000003','1000004', '4000001', 'IUD Removal', NULL, '13-JAN-2021 19:15', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000004','1000003', '4000005', 'Colposcopy', NULL, '11-FEB-2021 10:15', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000005','1000005', '4000003', 'Refill', NULL, '01-JAN-2021 13:15', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000006','1000006', '4000006', 'IUD Insertion', NULL, '07-APR-2013 11:00', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000007','1000009', '4000008', 'Nexplanon Insertion', NULL, '31-OCT-2017 19:30', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000008','1000008', '4000007', 'Initial', NULL, '05-JAN-2020 11:15', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000009','1000007', '4000009', 'Vasectomy', NULL, '24-JUL-2003 20:15', NULL);
INSERT INTO appointment(app_num, pat_id, phys_id, app_type, app_descript, app_stime, app_etime)		
	VALUES( '6000010','1000005', '4000004', 'Recertification', NULL, '28-DEC-2014 13:15', NULL);

-- Create phys_skill records
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000001', '3000001');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000002', '3000002');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000003', '3000003');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000004', '3000004');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000005', '3000005');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000006', '3000001');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000007', '3000002');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000008', '3000003');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000009', '3000004');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000009', '3000005');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000001', '3000005');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000002', '3000004');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000003', '3000002');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000004', '3000001');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000005', '3000003');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000006', '3000004');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000007', '3000004');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000008', '3000005');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000009', '3000002');
INSERT INTO phys_skill(phys_id, skill_id)
	VALUES('4000001', '3000004');

-- Create list records
INSERT INTO list(list_id, list_name, list_display, list_value, list_status)
	VALUES('0000001', 'PHONE TYPE', 'Work', 'WORK', 'A');
INSERT INTO list(list_id, list_name, list_display, list_value, list_status)
	VALUES('0000002', 'PHONE TYPE', 'Home', 'HOME', 'A');
INSERT INTO list(list_id, list_name, list_display, list_value, list_status)
	VALUES('0000003', 'PHONE TYPE', 'Mobile', 'MOBILE', 'A');
INSERT INTO list(list_id, list_name, list_display, list_value, list_status)
	VALUES('0000004', 'COUNTY NAME', 'Mille Lacs', 'MILLE LACS', 'A');
INSERT INTO list(list_id, list_name, list_display, list_value, list_status)
	VALUES('0000005', 'COUNTY NAME', 'Kanabec', 'KANABEC', 'A');
INSERT INTO list(list_id, list_name, list_display, list_value, list_status)
	VALUES('0000006', 'COUNTY NAME', 'Sherburne', 'SHERBURNE', 'A');
INSERT INTO list(list_id, list_name, list_display, list_value, list_status)
	VALUES('0000007', 'COUNTY NAME', 'Saint Louis', 'SAINT LOUIS', 'A');
INSERT INTO list(list_id, list_name, list_display, list_value, list_status)
	VALUES('0000008', 'COUNTY NAME', 'Benton', 'BENTON', 'A');
-- ====================================================================
--  SQL Script for Clinic Database, used along with
--	the Clinic Database Reset Script
--	Created by: Wilson Krueger, Madeline Warner, Clara Skeim
--	Created on: 12/7/2020
--	Modified by: Clara
--  Modified on: 12/8/2020- created Query 1 & 3a
--	Modified by: Wilson
--  Modified on: 12/8/2020- created Query 3b
--	Modified by: Madeline Warner
--  Modified on: 12/9/2020- created Query 2
--	Modified by: Wilson, Madeline, Clara
--  Modified on: 12/11/2020- created Query 4 & 5
-- ====================================================================

-- 1. Display the physician id, first name, last name, clinic number, and 
--	the status.
SELECT ph.phys_id AS 'Physician ID', ph.phys_lname + ', ' + ph.phys_fname AS 'Physician Name', ph.clinic_num AS 'Clinic Number', ph.phys_status AS 'Status'
	FROM physician ph;


-- 2. Display the physician ID, last and first name, patient id, last name and first name, appointment type, and appointment start time & status for
-- the patient.
SELECT ph.phys_id AS 'Physician ID', ph.phys_lname + ', ' + ph.phys_fname AS 'Physician Name', p.pat_id as 'Pateint ID', p.pat_lname + ', ' + p.pat_fname AS 'Patient Name', a.app_type
	AS 'Appointment', a.app_stime AS 'Appointment Date and Time', p.pat_status
	FROM physician ph, appointment a, patient p
	WHERE ph.phys_id = a.phys_id
	AND p.pat_id = a.pat_id
	AND p.pat_status = 'A';


-- 3a. Display the total number of appointments with type 'Refill' or 'Follow Up'
SELECT COUNT(app_num) AS 'Refill or Follow Up Appointments'
	FROM appointment
	WHERE app_type = 'Refill' OR app_type = 'Follow Up';

-- 3b. Display the number of physicians as 'Number of Physicians' at each clinic (number and name) 
SELECT p.clinic_num 'Clinic Number', c.clinic_name AS 'Clinic Name', COUNT(p.phys_id) AS 'Number of Physicians'
	FROM physician p, clinic c
	WHERE c.clinic_num = p.clinic_num
	GROUP BY p.clinic_num, c.clinic_name;


-- 4. Display a list of patients(id and name) and their prescriptions(number, generic name, and dosage) whether or not they have a prescription.
SELECT p.pat_id AS 'Patient ID', p.pat_lname + ', ' + p.pat_fname AS 'Patient Name',
	pr.presc_num AS 'Prescription Number', pr.presc_generic AS 'Prescription Name', pr.presc_dosage AS 'Prescription Dosage'
	FROM patient p 
	FULL OUTER JOIN prescription pr 
	ON p.pat_id = pr.pat_id;


-- 5. Display the patient name, address for patients with the Mora zip code (55051)
-- Also, display the Mora clinic name and city, which would be the clinic they will most likely attend
SELECT p.pat_lname + ', ' + p.pat_fname AS 'Patient Name', p.pat_street + ', ' + p.pat_city + ', ' + p.pat_state + ' ' + p.pat_zip AS 'Patient Address', 
	c.clinic_name AS 'Clinic Name', c.clinic_city AS 'Clinic City'
	FROM patient p, clinic c 
	WHERE c.clinic_city = 'Mora'
	AND p.pat_zip IN (SELECT pat_zip FROM patient
	WHERE pat_zip LIKE '%55051%');
# Project - 2 Hospital Database Analysis

# An introduction about hospital Database

Sample Database: hospital

With the help of a Hospital Database, this exercises will help you undestand simple SQL select queries to advanced multi table JOIN queries.

Sample Database description:

Hospitals are the most important part of our lives, trying to provide the best medical facilities to people suffering from various type of illness, which may be due to change in climate conditions, increased work-load, emotional trauma stress etc. It is very much difficult for the hospital to maintain its day-to-day acitivities and records manually. That is why a database is required to keep records of all type of acitivities of a hospital.

# List of tables in the hospital database:

# physician
•	employeeid – this is a unique ID of a physician

•	name – this is the name of a physician

•	position – this is the designation of a physician

•	ssn – this is a security number of a physician


# department

•	departmentid – this is a unique ID for a department

•	name – this is the name of a department

•	head – this is the ID of the physician who is the head of a department, referencing to the column employeeid of the table physician


# affiliated_with
•	physician – this is the ID of the physicians which is referencing to the column employeeid of the physician table

•	department – this is the ID the department which is referencing to the column departmentid of the department table

•	primaryaffiliation – this is a logical column which indicate that whether the physicians are yet to be affiliated or not

•	Note: The combination of physician, department will come once in that table.

# procedure
•	code – this is the unique ID of a medical procedure

•	name – the name of the medical procedure

•	cost – the cost for the procedure

# trained_in
•	physician – this is ID of the physicians which is referencing to the column employeeid of the physician table

•	treatment – this is the ID of the medical procedure which is referencing to the column code of the procedure table

•	certificationdate – this is the starting date of certification

•	certificationexpires – this is the expiry date of certification

•	Note: The combination of physician and treatement will come once in that table.

# patient
•	ssn – this is a unique ID for each patient

•	name – this is the name of the patient

•	address – this is the address of the patient

•	phone – this is the phone number of the patient

•	insuranceid – this is the insurance id of the patient

•	pcp – this is the ID of the physician who primarily checked up the patient which is referencing to the column employeeid of the physician table

# nurse

•	employeeid – this is the unique ID for a nurse

•	name – name of the nurses

•	position – the designation of the nurses

•	registered – this is a logical column which indicate that whether the nurses are registered for nursing or not

•	ssn – this is the security number of a nurse

# appointment
•	appointmentid – this is the unique ID for an appointment

•	patient – this is the ID of each patient which is referencing to the ssn column of patient table

•	prepnurse – the ID of the nurse who may attend the patient with the physician, which is referencing to the column employeeid of the nurse table

•	physician – this is the ID the physicians which is referencing to the employeeid column of the physician table

•	start_dt_time – this is the schedule date and approximate time to meet the physician

•	end_dt_time – this is the schedule date and approximate time to end the meeting

•	examinationroom – this the room where to meet a patient to the physician

# medication
•	code – this is the unique ID for a medicine

•	name – this is the name of the medicine

•	brand – this is the brand of the medicine

•	description – this is the description of the medicine

# prescribes
•	physician – this is the ID of the physician referencing to the employeeid column of the physician table

•	patient – this is the ID of the patient which is referencing to the ssn column of the patient table

•	medication – the ID of the medicine which is referencing to the code of the medication table

•	date – the date and time of the prescribed medication

•	appointment – the prescription made by the physician to a patient who may taken an appointment which is referencing to column appointmentid of appointment table

•	dose – the dose prescribed by the physician

•	Note: The combination of physician, patient, medication, date will come once in that table.

# block
•	blockfloor – ID of the floor

•	blockcode - ID of the block

•	Note: The combination of blockfloor, blockcode will come once in that table.

# room
•	roomnumber – this is the unique ID of a room

•	roomtype – this is type of room

•	blockfloor - this is the floor ID where the room in

•	blockcode – this is the ID of the block where the room in

•	unavailable – this is the logical column which indicate that whether the room is available or not

•	Note: The of blockfloor, blockcode columns are refercing to the combination of blockfloor and blockcode columns of the table block.

# on_call
•	nurse – this is ID of the nurse which is referencing to the employeeid column of the table nurse

•	blockfloor - this is the ID of the floor

•	blockcode – this is the ID of block

•	oncallstart - the starting date and time of on call duration

•	oncallend – the ending date and time of on call duration

•	Note: The combination of nurse, blockfloor, blockcode, oncallstart, oncallend will come once in that table and the combination of blockfloor, blockcode columns are refercing to the combination of blockfloor and blockcode columns of the table block .

# stay
•	stayid - this is unique ID for the admission

•	patient – this is the ID of the patient which is referencing the ssn column of patient table

•	room - this is the ID of the room where the patient admitted and which is referencing to the roomnumber column of the room table

•	start_time – this is the time when a patient admitted

•	end_time – this is the time how long a patient is staying

# undergoes
•	patient - this is ID of the patient which is referencing to the ssn column of the patient table

•	procedure – this is ID of the procedure and referencing to the code column of the procedure table

•	stay - this is the ID admission of a patient, which is referencing to the stayid column of the stay table

•	date – this is the date when a patient undergoes for a medical procedure

•	physician – this is the ID of a physician which is referencing to the column employeeid of the table physician

•	assistingnurse – this is the ID of a nurse who will assists the physician, referencing to the column employeeid of the table nurse

•	Note: The combination ofpatient, procedure, stay, date will come once in that table.


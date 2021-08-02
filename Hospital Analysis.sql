-- Project Hospital Analysis

USE Hospital;

-- 1) Obtain the names of all physicians that have performed a medical
--    procedure the have never been certified to perform.

SELECT P.EmployeeID AS "Employee ID",
	   P.Name AS "Physician Name", 
       U.or_procedure AS "Procedure ID", 
       OP.Name AS "Procedure Name"
FROM Undergoes U JOIN Physician P ON (U.Physician = P.EmployeeID)
				 JOIN or_procedure OP ON (OP.Code = U.or_procedure)
EXCEPT

SELECT P.EmployeeID AS "Employee ID",
       P.Name AS "Physcian Name",
       T.Treatment AS "Treatment ID",
	   OP.Name AS "Procedure Name"
FROM Physician P JOIN Trained_In T ON (P.EmployeeID = T.Physician)
                 JOIN or_procedure OP ON (T.Treatment = OP.Code)


-- 2) Obtain the names of all physicians that have performed a medical
--    prodecure that they are certified to perform, but such that the 
--    procedure was done at a date after the physician's certification expired.

SELECT P.Name AS "Physician Name",
       U.or_procedure AS "Procedure Code", 
       CONVERT (VARCHAR, T.CertificationExpires, 105) AS "Certification Expires",
       CONVERT (VARCHAR, U.DateUndergoes, 105) AS "Date Undergoes"

FROM Physician P JOIN Undergoes U ON (P.EmployeeID = U.Physician)
				 JOIN Trained_In T ON (P.EmployeeID = T.Physician)

WHERE U.DateUndergoes > T.CertificationExpires


-- 3) Obtain the information for appointments where a patient met with physician 
--    other than his/her primary care physician. Show the following information:
--    Patient name, Physician name, Nurse name (if any), Start and end time of appointment, 
--    Examination room, and the name of the patient's primary care physician.

SELECT PA.Name AS "Patient Name",
       PH_RECIVING.Name AS "Reciving Physician", 
       N.Name AS "Nurse",
	   AP.start_time AS "Start Time", 
	   AP.End_time AS "End Time",
       AP.ExaminationRoom AS "Examination Room", 
	   PH_PRIMARY.Name AS "Primary Physician"

FROM Patient PA JOIN Physician PH_PRIMARY ON (PA.PCP = PH_PRIMARY.EmployeeID)
                JOIN Appointment AP ON (PA.SSN = AP.Patient)
                JOIN Physician PH_RECIVING ON (AP.Physician = PH_RECIVING.EmployeeID)
                LEFT JOIN Nurse N ON (N.EmployeeID = AP.PrepNurse)

WHERE PH_RECIVING.Name <> PH_PRIMARY.Name


-- 4) The patient field in Undergoes is redundant, since we can obtain it from the Stay table.
--    There are no constraints in force to prevent inconsistencies between these two tables. 
--    More specifically - the Undergoes table may include a row where the patient ID does not match 
--    the one we would obtain from the Stay table. Select all rows from Undergoes that exhibit this inconsistency.

SELECT S.StayID AS "Stay ID",
       U.Patient AS "Undergoes Patient ID",
       S.Patient AS "Stay Patiend ID"

FROM Undergoes U JOIN Stay S ON U.Patient <> S.Patient AND U.Stay = S.StayID



-- 5) Obtain the names of all the nurses who have ever been on call for room 123.

SELECT N.EmployeeID AS "Employee ID",
	   N.Name AS "Nurse Name", 
       N.Position AS "Position", 
       R.RoomNumber AS "Room Number"

FROM Nurse N JOIN On_Call OC ON (N.EmployeeID = OC.Nurse) 
             JOIN Block B ON (OC.BlockFloor = B.BlockFloor AND OC.BlockCode = B.BlockCode) 
             JOIN Room R ON (B.BlockFloor = R.BlockFloor AND B.BlockCode = R.BlockCode)

WHERE R.RoomNumber = 123


-- 6) The hospital has several examination rooms where appointments take place.
--   Obtain the number of appointments that have taken place in each examination room.

SELECT ExaminationRoom AS "Examination Room",
       COUNT(*) AS "Number of Appointments"
FROM Appointment
GROUP BY ExaminationRoom


-- 7) Obtain the names of all patients who have been prescribed 
--   some medication by their primary care physician.

SELECT PA.Name AS "Patient Name", 
       ME.Name AS "Medication",
       PR.Dose AS "Dose",
	   PR.Physician AS "Prescribstion Physician",
       PH.EmployeeID AS "Primary Physician"

FROM Patient PA JOIN Physician PH ON (PA.PCP=PH.EmployeeID)
                JOIN Prescribes PR ON (PR.Physician = PH.EmployeeID)
                JOIN Medication ME ON (PR.Medication = ME.Code)


-- 8) Obtain the names of all patients who have been undergone
--    a procedure with a cost larger then $5000.

SELECT P.Name AS "Patient Name",
	   OP.Code AS "Procedure Code",
       OP.Name AS "Procedure Name", 
       CAST (OP.Cost AS VARCHAR) + '$' AS "Procedure Cost",
       CONVERT(VARCHAR, U.DateUndergoes, 105) AS "Date Undergoes"

FROM Patient P JOIN Undergoes U ON (P.SSN = U.Patient)
               JOIN or_procedure OP ON (U.or_procedure = OP.Code)

WHERE OP.Cost > 5000



-- 9) Obtain the names of all patients who have had at least two appointments.

SELECT   PA.Name AS "Patient Name", 
         COUNT(AP.AppointmentID) AS "Number of appointments"

FROM     Patient PA JOIN Appointment AP ON (PA.SSN = AP.Patient)
GROUP BY PA.Name
HAVING   COUNT(AP.AppointmentID) >= 2



-- 10) Obtain the names of all patients which their care physician is not the head of any department.

SELECT PA.Name AS "Patient Name",
       PH.Name AS "Physician Name"
FROM   Patient PA JOIN Physician PH ON (PA.PCP = PH.EmployeeID)
                  LEFT JOIN Department DE ON (PH.EmployeeID = DE.Head AND DE.Head <> PA.PCP)



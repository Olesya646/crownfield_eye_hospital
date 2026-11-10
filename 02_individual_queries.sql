USE crownfield_eye_hospital;
-- QUERY 1: Aggregate – GROUP BY, COUNT, HAVING
SELECT
    clinician_id,
    COUNT(*) AS total_appointments
FROM appointment
GROUP BY clinician_id
HAVING COUNT(*) >= 2;

-- QUERY 2: INNER JOIN – Clinic, Appointment, Patient
SELECT
    cl.clinic_name,
    a.appointment_date,
    a.appointment_time,
    p.patient_number
FROM clinic cl
INNER JOIN appointment a
    ON cl.clinic_id = a.clinic_id
INNER JOIN patient p
    ON a.patient_id = p.patient_id
ORDER BY cl.clinic_name;

-- QUERY 3: LEFT JOIN – Clinicians without appointments
SELECT
    c.clinician_id,
    c.first_name,
    c.last_name
FROM clinician AS c
LEFT JOIN appointment AS a
    ON c.clinician_id = a.clinician_id
WHERE a.appointment_id IS NULL;

-- QUERY 4: Subquery – Display prescribed medicines

SELECT
    m.medicine_id,
    m.medicine_name
FROM medicine m
WHERE m.medicine_id IN (
    SELECT pi.medicine_id
    FROM prescription_item pi
    GROUP BY pi.medicine_id
    HAVING COUNT(*) >= 1
)
ORDER BY m.medicine_name;


-- QUERY 5: Stored Procedure – Appointments by Clinician
DELIMITER //
CREATE PROCEDURE GetAppointmentsByClinician(
    IN p_clinician_id INT
)
BEGIN
    SELECT
        appointment_id,
        appointment_date,
        appointment_time,
        patient_id
    FROM appointment
    WHERE clinician_id = p_clinician_id
    ORDER BY appointment_date;
END //

DELIMITER ;
CALL GetAppointmentsByClinician(1);

DESCRIBE appointment_audit;

DESCRIBE appointment;

-- QUERY 6: Creation and testing of the appointment status audit trigger.
DELIMITER //
CREATE TRIGGER trg_appointment_status_audit
AFTER UPDATE ON appointment
FOR EACH ROW
BEGIN
    IF OLD.appointment_status <> NEW.appointment_status THEN
        INSERT INTO appointment_audit (
            appointment_id,
            old_status,
            new_status,
            changed_at,
            changed_by)
     VALUES (
    OLD.appointment_id,
    OLD.appointment_status, NEW.appointment_status,
    CURRENT_TIMESTAMP, CURRENT_USER()
);
    END IF;
END //
DELIMITER ;
START TRANSACTION;
UPDATE appointment
SET appointment_status = 'Completed'
WHERE appointment_id = 10
AND appointment_status = 'Booked';
SELECT *
FROM appointment_audit
WHERE appointment_id = 10;
ROLLBACK;






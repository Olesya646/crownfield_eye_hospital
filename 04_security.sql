

-- CROWNFIELD EYE HOSPITAL
-- PART D: SECURITY, DATA PROTECTION AND CONTROL


USE crownfield_eye_hospital;

-- D1: Database roles and access permissions
-- D2: Patient data protection and encryption
-- D3: Verification of security permissions

-- D1: CREATE DATABASE ROLES


CREATE ROLE IF NOT EXISTS
    'hospital_admin',
    'hospital_doctor',
    'hospital_receptionist',
    'hospital_patient';
    -- Administrator has full access to the hospital database.

GRANT SELECT, INSERT, UPDATE, DELETE
ON crownfield_eye_hospital.*
TO 'hospital_admin';

-- Doctors can view clinical and patient records.

GRANT SELECT ON crownfield_eye_hospital.patient TO 'hospital_doctor';
GRANT SELECT ON crownfield_eye_hospital.appointment TO 'hospital_doctor';
GRANT SELECT ON crownfield_eye_hospital.clinician TO 'hospital_doctor';
GRANT SELECT ON crownfield_eye_hospital.diagnosis TO 'hospital_doctor';
GRANT SELECT ON crownfield_eye_hospital.appointment_diagnosis TO 'hospital_doctor';
GRANT SELECT ON crownfield_eye_hospital.prescription TO 'hospital_doctor';
GRANT SELECT ON crownfield_eye_hospital.medicine TO 'hospital_doctor';
GRANT SELECT ON crownfield_eye_hospital.prescription_item TO 'hospital_doctor';
GRANT SELECT ON crownfield_eye_hospital.follow_up TO 'hospital_doctor';

GRANT INSERT, UPDATE ON crownfield_eye_hospital.diagnosis TO 'hospital_doctor';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.appointment_diagnosis TO 'hospital_doctor';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.prescription TO 'hospital_doctor';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.prescription_item TO 'hospital_doctor';
GRANT INSERT, UPDATE ON crownfield_eye_hospital.follow_up TO 'hospital_doctor';

-- Receptionists can view basic patient and appointment information.
GRANT SELECT ON crownfield_eye_hospital.patient TO 'hospital_receptionist';
GRANT SELECT ON crownfield_eye_hospital.clinician TO 'hospital_receptionist';
GRANT SELECT ON crownfield_eye_hospital.clinic TO 'hospital_receptionist';
GRANT SELECT ON crownfield_eye_hospital.appointment TO 'hospital_receptionist';

-- Receptionists can create and update appointments.
GRANT INSERT, UPDATE ON crownfield_eye_hospital.appointment TO 'hospital_receptionist';

-- Patients can only execute the procedure to view their own details.
GRANT EXECUTE
ON PROCEDURE crownfield_eye_hospital.GetMyPatientDetails
TO 'hospital_patient';

-- D2: PATIENT DATA PROTECTION AND ENCRYPTION

-- Use AES-256-CBC encryption.
SET block_encryption_mode = 'aes-256-cbc';

-- Generate a temporary encryption key and IV.
SET @encryption_key = RANDOM_BYTES(32);
SET @encryption_iv = RANDOM_BYTES(16);

-- Encrypt the existing patient's email address.
UPDATE patient_contact_secure pcs
JOIN patient p ON pcs.patient_id = p.patient_id
SET
    pcs.encrypted_email = AES_ENCRYPT(
        p.email, @encryption_key, @encryption_iv
    ),
    pcs.encryption_iv = @encryption_iv
WHERE p.patient_number = 'OP001';

-- Verify that the encrypted email can be decrypted.
SELECT
    patient_id,
    AES_DECRYPT(
        encrypted_email,
        @encryption_key,
        encryption_iv
    ) = (
        SELECT email FROM patient WHERE patient_number = 'OP001'
    ) AS encryption_verified
FROM patient_contact_secure
WHERE patient_id = (
    SELECT patient_id FROM patient WHERE patient_number = 'OP001'
);

SHOW GRANTS FOR 'hospital_admin';
SHOW GRANTS FOR 'hospital_doctor';
SHOW GRANTS FOR 'hospital_receptionist';
SHOW GRANTS FOR 'hospital_patient';

-- Miguel
-- Eventos adversos graves, para revisar rápido qué pacientes tuvieron reacciones serias:
SELECT description, severity, onset_date
FROM AdverseEvent
WHERE severity >= 4
ORDER BY severity DESC
GO
-- Pacientes y el ensayo en el que están inscritos, con su estado de inscripción:
SELECT P.first_name, P.last_name, CT.title AS trial_title, PCT.status AS enrollment_status, PCT.enrollment_date
FROM Patient AS P, Patient_ClinicalTrial AS PCT, ClinicalTrial AS CT
WHERE P.id = PCT.patient_id AND PCT.trial_id = CT.id
ORDER BY CT.title, P.last_name
GO
-- Detalle completo de cada cita: paciente, ensayo, investigador y centro, más el evento adverso si lo tuvo:
SELECT P.first_name + ' ' + P.last_name AS patient_name, CT.title AS trial_title, R.first_name + ' ' + R.last_name AS researcher_name,
RC.name AS research_center, A.visitNumber, A.status AS appointment_status, A.scheduleDate, AE.description AS adverse_event, AE.severity
FROM Appointment AS A
    INNER JOIN Patient_ClinicalTrial AS PCT 
    ON A.patientClinicalTrial_id = PCT.id
        INNER JOIN Patient AS P 
        ON PCT.patient_id = P.id
            INNER JOIN ClinicalTrial AS CT 
            ON PCT.trial_id = CT.id
                INNER JOIN Researcher AS R 
                ON A.researcher_id = R.id
                    INNER JOIN ResearchCenter AS RC 
                    ON A.researchCenter_id = RC.id
                        LEFT JOIN AdverseEvent AS AE 
                        ON AE.appointment_id = A.id
ORDER BY CT.title, P.last_name, A.visitNumber
GO

-- Drago
-- Ensayos activos ordenados por fecha de inicio
SELECT title, status, start_date
FROM ClinicalTrial
WHERE status = 'Active'
ORDER BY start_date DESC
GO
-- Consulta multi-tabla: patrocinadores y sus ensayos
SELECT S.name AS sponsor_name, CT.title AS trial_title, CT.status
FROM Sponsor AS S, ClinicalTrial AS CT
WHERE S.id = CT.sponsor_id
ORDER BY S.name
GO
-- Medicamentos usados por ensayo, con fase y patrocinador
SELECT CT.title AS trial_title, S.name AS sponsor_name, TP.name AS phase_name, M.name AS medication_name, TM.dosage, TM.route
FROM TrialMedication AS TM
    INNER JOIN ClinicalTrial AS CT
    ON TM.ClinicalTrial_id = CT.id
        INNER JOIN Sponsor AS S
        ON CT.sponsor_id = S.id
            INNER JOIN TrialPhase AS TP
            ON CT.TrialPhase_id = TP.id
                INNER JOIN Medication AS M
                ON TM.Medication_id = M.id
ORDER BY S.name, CT.title
GO

--Sebastian
-- Investigadores agrupados por especialidad
SELECT specialization, COUNT(*) AS total_researchers
FROM Researcher
GROUP BY specialization
ORDER BY total_researchers DESC
GO
-- Investigadores y su centro
SELECT R.first_name, R.last_name, R.specialization, RC.name AS center_name, RC.country
FROM Researcher AS R, ResearchCenter AS RC
WHERE R.ResearchCenter_id = RC.id
ORDER BY RC.name
GO
-- Asignaciones de investigadores a ensayos
SELECT R.first_name + ' ' + R.last_name AS researcher_name, RC.name AS center_name, CT.title AS trial_title, RCT.roleInTrial, RCT.start_date
FROM ResearcherClinicalTrial AS RCT
    INNER JOIN Researcher AS R
    ON RCT.researcher_id = R.id
        INNER JOIN ResearchCenter AS RC
        ON R.ResearchCenter_id = RC.id
            INNER JOIN ClinicalTrial AS CT
            ON RCT.clinicalTrial_id = CT.id
ORDER BY RC.name, CT.title
GO

-- Yamil
-- Resultados fuera del rango de referencia
SELECT test_Name, measured_value, unit, referenceMin, referenceMax
FROM LabResult
WHERE measured_value > referenceMax OR measured_value < referenceMin
GO
-- Resultados de laboratorio con nombre de paciente
SELECT P.first_name, P.last_name, LR.test_Name, LR.measured_value, LR.unit
FROM Patient AS P, Patient_ClinicalTrial AS PCT, Appointment AS A, LabResult AS LR
WHERE P.id = PCT.patient_id AND PCT.id = A.patientClinicalTrial_id AND A.id = LR.appointment_id
ORDER BY P.last_name
GO
-- Trazabilidad completa de laboratorio
SELECT P.first_name + ' ' + P.last_name AS patient_name, CT.title AS trial_title, A.visitNumber, LR.test_Name, LR.measured_value, LR.referenceMin, LR.referenceMax
FROM LabResult AS LR
    INNER JOIN Appointment AS A
    ON LR.appointment_id = A.id
        INNER JOIN Patient_ClinicalTrial AS PCT
        ON A.patientClinicalTrial_id = PCT.id
            INNER JOIN Patient AS P
            ON PCT.patient_id = P.id
                INNER JOIN ClinicalTrial AS CT
                ON PCT.trial_id = CT.id
ORDER BY CT.title, P.last_name
GO

-- Denis
-- Consentimientos revocados
SELECT patientClinicalTrial_id, signedDate, revokedDate, protocolVersion
FROM ConsentForm
WHERE revokedDate IS NOT NULL
GO
-- Pacientes retirados y su ensayo
SELECT P.first_name, P.last_name, CT.title AS trial_title, PCT.enrollment_date
FROM Patient AS P, Patient_ClinicalTrial AS PCT, ClinicalTrial AS CT
WHERE P.id = PCT.patient_id AND PCT.trial_id = CT.id AND PCT.status = 'Withdrawn'
GO
-- Consentimiento + inscripción + ensayo + centro asignado
SELECT P.first_name + ' ' + P.last_name AS patient_name, CT.title AS trial_title, CF.signedDate, CF.protocolVersion, CF.revokedDate, RC.name AS center_name
FROM ConsentForm AS CF
    INNER JOIN Patient_ClinicalTrial AS PCT
    ON CF.patientClinicalTrial_id = PCT.id
        INNER JOIN Patient AS P
        ON PCT.patient_id = P.id
            INNER JOIN ClinicalTrial AS CT
            ON PCT.trial_id = CT.id
                INNER JOIN ClinicalTrialCenter AS CTC
                ON CTC.clinicalTrial_id = CT.id
                    INNER JOIN ResearchCenter AS RC
                    ON CTC.researchCenter_id = RC.id
ORDER BY CT.title, P.last_name
GO
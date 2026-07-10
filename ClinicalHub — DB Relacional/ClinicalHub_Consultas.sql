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
-- Detalle de los ensayos activos, su patrocinador, fase y régimen de medicación
SELECT 
    ct.title AS trial_title,
    s.name AS sponsor_name,
    tp.name AS trial_phase,
    m.name AS medication_name,
    tm.dosage,
    tm.route,
    tm.frequency
FROM ClinicalTrial ct
INNER JOIN Sponsor s ON ct.sponsor_id = s.id
INNER JOIN TrialPhase tp ON ct.TrialPhase_id = tp.id
LEFT JOIN TrialMedication tm ON tm.ClinicalTrial_id = ct.id
LEFT JOIN Medication m ON tm.Medication_id = m.id
WHERE ct.status = 'Active'
ORDER BY s.name, ct.title;

-- Estadísticas de pacientes por ensayo clínico (Total, Activos, Screening y Retirados)
SELECT 
    ct.title AS trial_title,
    COUNT(pct.patient_id) AS total_patients,
    SUM(CASE WHEN pct.status = 'Active' THEN 1 ELSE 0 END) AS active_patients,
    SUM(CASE WHEN pct.status = 'Screening' THEN 1 ELSE 0 END) AS screening_patients,
    SUM(CASE WHEN pct.status = 'Withdrawn' THEN 1 ELSE 0 END) AS withdrawn_patients
FROM ClinicalTrial ct
LEFT JOIN Patient_ClinicalTrial pct ON ct.id = pct.trial_id
GROUP BY ct.title
ORDER BY total_patients DESC, ct.title;

-- Distribución de pacientes por género y edad promedio en cada ensayo clínico
SELECT 
    ct.title AS trial_title,
    p.gender,
    COUNT(p.id) AS patient_count,
    AVG(DATEDIFF(YEAR, p.date_birth, GETDATE())) AS average_age
FROM ClinicalTrial ct
INNER JOIN Patient_ClinicalTrial pct ON ct.id = pct.trial_id
INNER JOIN Patient p ON pct.patient_id = p.id
GROUP BY 
    ct.title, 
    p.gender
ORDER BY ct.title, p.gender;
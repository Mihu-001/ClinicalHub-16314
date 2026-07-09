--Eventos adversos graves, para revisar rápido qué pacientes tuvieron reacciones serias:
SELECT description, severity, onset_date
FROM AdverseEvent
WHERE severity >= 4
ORDER BY severity DESC;

--Pacientes y el ensayo en el que están inscritos, con su estado de inscripción:
SELECT 
    p.first_name,
    p.last_name,
    ct.title AS trial_title,
    pct.status AS enrollment_status,
    pct.enrollment_date
FROM Patient p, Patient_ClinicalTrial pct, ClinicalTrial ct
WHERE p.id = pct.patient_id AND pct.trial_id = ct.id
ORDER BY ct.title, p.last_name;

--Detalle completo de cada cita: paciente, ensayo, investigador y centro, más el evento adverso si lo tuvo:
SELECT 
    p.first_name + ' ' + p.last_name AS patient_name,
    ct.title AS trial_title,
    r.first_name + ' ' + r.last_name AS researcher_name,
    rc.name AS research_center,
    a.visitNumber,
    a.status AS appointment_status,
    a.scheduleDate,
    ae.description AS adverse_event,
    ae.severity
FROM Appointment a
INNER JOIN Patient_ClinicalTrial pct ON a.patientClinicalTrial_id = pct.id
INNER JOIN Patient p ON pct.patient_id = p.id
INNER JOIN ClinicalTrial ct ON pct.trial_id = ct.id
INNER JOIN Researcher r ON a.researcher_id = r.id
INNER JOIN ResearchCenter rc ON a.researchCenter_id = rc.id
LEFT JOIN AdverseEvent ae ON ae.appointment_id = a.id
ORDER BY ct.title, p.last_name, a.visitNumber;


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
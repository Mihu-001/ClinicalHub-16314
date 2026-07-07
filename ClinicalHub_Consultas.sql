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
-- ClinicalHub - Datos de prueba realistas
-- Ejecutar DESPUES del script de creacion de tablas (ClinicalHub_Completo.sql)
-- Los IDs asumen que las tablas estan vacias (IDENTITY arranca en 1)

USE ClinicalHub;
GO

-- Sponsor
INSERT INTO Sponsor (name, contact_info, org_type, country) VALUES
('Pfizer Inc.', 'contact@pfizer.com', 'Pharmaceutical', 'USA'),
('Novartis AG', 'contact@novartis.com', 'Pharmaceutical', 'Switzerland'),
('F. Hoffmann-La Roche Ltd', 'contact@roche.com', 'Pharmaceutical', 'Switzerland'),
('AstraZeneca PLC', 'contact@astrazeneca.com', 'Pharmaceutical', 'United Kingdom'),
('Instituto Nacional de Salud', 'contacto@ins.gob.pe', 'Government', 'Peru');
GO

-- TrialPhase
INSERT INTO TrialPhase (phase_number, name, objective) VALUES
(1, 'Phase I', 'Assess safety and dosage'),
(2, 'Phase II', 'Evaluate efficacy and side effects'),
(3, 'Phase III', 'Confirm efficacy and monitor adverse reactions vs standard treatment'),
(4, 'Phase IV', 'Post-marketing surveillance');
GO

-- Medication
INSERT INTO Medication (name, activeIngredient) VALUES
('Glucofast', 'Metformin hydrochloride'),
('Lipiblock', 'Atorvastatin calcium'),
('Presolan', 'Losartan potassium'),
('Empaglyx', 'Empagliflozin'),
('Oncoshield', 'Pembrolizumab'),
('Virostop', 'Remdesivir'),
('Analvex', 'Ibuprofen'),
('Insulyn Glar', 'Insulin glargine'),
('Mindease', 'Sertraline hydrochloride'),
('Immunar', 'Adalimumab');
GO

-- ResearchCenter
INSERT INTO ResearchCenter (name, location, facility_type, country, contactEmail) VALUES
('Hospital Nacional Cayetano Heredia', 'Lima', 'Hospital', 'Peru', 'contacto@cayetano.pe'),
('Clinica Ricardo Palma', 'Lima', 'Clinic', 'Peru', 'contacto@ricardopalma.pe'),
('Mayo Clinic', 'Rochester MN', 'Hospital', 'USA', 'info@mayoclinic.org'),
('Cleveland Clinic', 'Cleveland OH', 'Hospital', 'USA', 'info@clevelandclinic.org'),
('Hospital Clinic de Barcelona', 'Barcelona', 'Hospital', 'Spain', 'info@hospitalclinic.cat'),
('Instituto Nacional de Cancerologia', 'Bogota', 'Research Institute', 'Colombia', 'info@incancerologia.co'),
('Charite Universitaetsmedizin', 'Berlin', 'University Hospital', 'Germany', 'info@charite.de'),
('Hospital Italiano', 'Buenos Aires', 'Hospital', 'Argentina', 'info@hospitalitaliano.org.ar');
GO

-- Researcher
INSERT INTO Researcher (ResearchCenter_id, first_name, last_name, specialization, email, role) VALUES
(1, 'Carlos', 'Ramirez', 'Cardiology', 'carlos.ramirez@cayetano.pe', 'Principal Investigator'),
(1, 'Maria', 'Fernandez', 'Endocrinology', 'maria.fernandez@cayetano.pe', 'Sub-Investigator'),
(2, 'Jorge', 'Salinas', 'Oncology', 'jorge.salinas@ricardopalma.pe', 'Principal Investigator'),
(2, 'Lucia', 'Vargas', 'Neurology', 'lucia.vargas@ricardopalma.pe', 'Coordinator'),
(3, 'John', 'Smith', 'Cardiology', 'john.smith@mayoclinic.org', 'Principal Investigator'),
(3, 'Emily', 'Johnson', 'Oncology', 'emily.johnson@mayoclinic.org', 'Sub-Investigator'),
(4, 'Michael', 'Brown', 'Immunology', 'michael.brown@ccf.org', 'Principal Investigator'),
(4, 'Sarah', 'Davis', 'Infectious Disease', 'sarah.davis@ccf.org', 'Coordinator'),
(5, 'Marc', 'Alonso', 'Endocrinology', 'marc.alonso@hospitalclinic.cat', 'Principal Investigator'),
(5, 'Laura', 'Prat', 'Cardiology', 'laura.prat@hospitalclinic.cat', 'Sub-Investigator'),
(6, 'Andres', 'Gomez', 'Oncology', 'andres.gomez@incancerologia.co', 'Principal Investigator'),
(6, 'Paula', 'Rojas', 'Oncology', 'paula.rojas@incancerologia.co', 'Coordinator'),
(7, 'Hans', 'Muller', 'Infectious Disease', 'hans.muller@charite.de', 'Principal Investigator'),
(7, 'Anna', 'Schmidt', 'Psychiatry', 'anna.schmidt@charite.de', 'Sub-Investigator'),
(8, 'Roberto', 'Diaz', 'Rheumatology', 'roberto.diaz@hospitalitaliano.org.ar', 'Principal Investigator');
GO

-- ClinicalTrial
INSERT INTO ClinicalTrial (sponsor_id, TrialPhase_id, title, status, description, start_date, end_date) VALUES
(1, 2, 'Efficacy of Empagliflozin in Type 2 Diabetes', 'Active', 'Randomized controlled trial evaluating glycemic control', '2025-01-15', NULL),
(2, 3, 'Long-term Safety of Adalimumab in Rheumatoid Arthritis', 'Recruiting', 'Multicenter safety follow-up study', '2025-06-01', NULL),
(3, 3, 'Pembrolizumab in Advanced NSCLC', 'Active', 'Immunotherapy efficacy study in stage IV lung cancer', '2024-09-10', NULL),
(4, 2, 'Remdesivir in Hospitalized COVID-19 Patients', 'Completed', 'Antiviral treatment outcomes study', '2023-03-01', '2024-01-15'),
(1, 4, 'Post-Marketing Surveillance of Atorvastatin', 'Active', 'Long-term cardiovascular outcomes monitoring', '2025-02-01', NULL),
(5, 1, 'Dose-Finding Study of Insulin Glargine', 'Recruiting', 'Phase I dose escalation study', '2026-01-10', NULL),
(2, 3, 'Losartan vs Placebo in Hypertension', 'Suspended', 'Comparative antihypertensive efficacy trial', '2024-05-01', NULL),
(3, 2, 'Sertraline for Depression in Cancer Patients', 'Planned', 'Study of antidepressant efficacy in oncology patients', NULL, NULL);
GO

-- Patient
INSERT INTO Patient (first_name, last_name, date_birth, gender, blood_type, contactEmail) VALUES
('Ana', 'Torres', '1985-03-12', 'Female', 'O+', 'ana.torres@mail.com'),
('Luis', 'Gonzales', '1978-07-22', 'Male', 'A+', 'luis.gonzales@mail.com'),
('Maria', 'Sanchez', '1990-11-05', 'Female', 'B+', 'maria.sanchez@mail.com'),
('Pedro', 'Ramirez', '1965-01-30', 'Male', 'O-', 'pedro.ramirez@mail.com'),
('Carmen', 'Flores', '1982-09-14', 'Female', 'AB+', 'carmen.flores@mail.com'),
('Jose', 'Martinez', '1970-05-18', 'Male', 'A-', 'jose.martinez@mail.com'),
('Rosa', 'Diaz', '1995-12-01', 'Female', 'B-', 'rosa.diaz@mail.com'),
('Miguel', 'Castro', '1988-04-25', 'Male', 'O+', 'miguel.castro@mail.com'),
('Elena', 'Vega', '1975-08-09', 'Female', 'A+', 'elena.vega@mail.com'),
('Francisco', 'Rojas', '1960-02-14', 'Male', 'AB-', 'francisco.rojas@mail.com'),
('Patricia', 'Mora', '1992-06-30', 'Female', 'O+', 'patricia.mora@mail.com'),
('Ricardo', 'Silva', '1983-10-11', 'Male', 'B+', 'ricardo.silva@mail.com'),
('Isabel', 'Nunez', '1977-03-27', 'Female', 'A+', 'isabel.nunez@mail.com'),
('Fernando', 'Ortiz', '1968-11-19', 'Male', 'O-', 'fernando.ortiz@mail.com'),
('Gabriela', 'Paredes', '1991-01-08', 'Female', 'AB+', 'gabriela.paredes@mail.com'),
('John', 'Anderson', '1980-06-15', 'Male', 'A+', 'john.anderson@mail.com'),
('Emily', 'Clark', '1987-09-22', 'Female', 'O+', 'emily.clark@mail.com'),
('David', 'Lee', '1973-12-03', 'Male', 'B+', 'david.lee@mail.com'),
('Sophia', 'Turner', '1994-04-17', 'Female', 'A-', 'sophia.turner@mail.com'),
('James', 'Walker', '1966-08-29', 'Male', 'O+', 'james.walker@mail.com'),
('Laura', 'Martin', '1989-02-14', 'Female', 'AB-', 'laura.martin@mail.com'),
('Thomas', 'Hall', '1979-10-05', 'Male', 'B-', 'thomas.hall@mail.com'),
('Olivia', 'King', '1996-07-21', 'Female', 'O+', 'olivia.king@mail.com'),
('Daniel', 'Wright', '1963-03-09', 'Male', 'A+', 'daniel.wright@mail.com'),
('Sophie', 'Muller', '1984-11-30', 'Female', 'AB+', 'sophie.muller@mail.com'),
('Lukas', 'Wagner', '1971-05-13', 'Male', 'O-', 'lukas.wagner@mail.com'),
('Marta', 'Fischer', '1993-09-06', 'Female', 'B+', 'marta.fischer@mail.com'),
('Julia', 'Weber', '1986-01-25', 'Female', 'A+', 'julia.weber@mail.com'),
('Diego', 'Fernandez', '1981-07-11', 'Male', 'O+', 'diego.fernandez@mail.com'),
('Valentina', 'Cruz', '1998-04-02', 'Female', 'AB-', 'valentina.cruz@mail.com');
GO

-- Patient_ClinicalTrial (inscripciones)
INSERT INTO Patient_ClinicalTrial (trial_id, patient_id, status, enrollment_date) VALUES
(1, 1, 'Active', '2025-01-20'),
(1, 2, 'Active', '2025-01-21'),
(1, 3, 'Active', '2025-01-22'),
(1, 4, 'Active', '2025-01-23'),
(1, 5, 'Active', '2025-01-24'),
(2, 6, 'Enrolled', '2025-06-05'),
(2, 7, 'Enrolled', '2025-06-10'),
(2, 8, 'Enrolled', '2025-06-15'),
(2, 9, 'Enrolled', '2025-06-20'),
(3, 10, 'Active', '2024-09-15'),
(3, 11, 'Active', '2024-09-20'),
(3, 12, 'Active', '2024-09-25'),
(3, 13, 'Active', '2024-09-30'),
(3, 14, 'Active', '2024-10-05'),
(4, 15, 'Completed', '2023-03-05'),
(4, 16, 'Completed', '2023-03-10'),
(4, 17, 'Completed', '2023-03-15'),
(4, 18, 'Completed', '2023-03-20'),
(5, 19, 'Active', '2025-02-05'),
(5, 20, 'Active', '2025-02-10'),
(5, 21, 'Active', '2025-02-15'),
(5, 22, 'Active', '2025-02-20'),
(5, 23, 'Active', '2025-02-25'),
(6, 24, 'Screening', NULL),
(6, 25, 'Screening', NULL),
(6, 26, 'Screening', NULL),
(7, 27, 'Withdrawn', '2024-05-05'),
(7, 28, 'Withdrawn', '2024-05-10'),
(8, 29, 'Screening', NULL),
(8, 30, 'Screening', NULL);
GO

-- ResearcherClinicalTrial
INSERT INTO ResearcherClinicalTrial (researcher_id, clinicalTrial_id, roleInTrial, start_date, end_date) VALUES
(1, 1, 'Principal Investigator', '2025-01-15', NULL),
(2, 1, 'Sub-Investigator', '2025-01-15', NULL),
(3, 2, 'Principal Investigator', '2025-06-01', NULL),
(4, 2, 'Coordinator', '2025-06-01', NULL),
(5, 3, 'Principal Investigator', '2024-09-10', NULL),
(6, 3, 'Sub-Investigator', '2024-09-10', NULL),
(7, 4, 'Principal Investigator', '2023-03-01', '2024-01-15'),
(8, 4, 'Coordinator', '2023-03-01', '2024-01-15'),
(9, 5, 'Principal Investigator', '2025-02-01', NULL),
(10, 5, 'Sub-Investigator', '2025-02-01', NULL),
(11, 6, 'Principal Investigator', '2026-01-10', NULL),
(12, 6, 'Coordinator', '2026-01-10', NULL),
(13, 7, 'Principal Investigator', '2024-05-01', NULL),
(14, 7, 'Sub-Investigator', '2024-05-01', NULL),
(15, 8, 'Principal Investigator', NULL, NULL),
(1, 8, 'Sub-Investigator', NULL, NULL);
GO

-- ClinicalTrialCenter
INSERT INTO ClinicalTrialCenter (clinicalTrial_id, researchCenter_id, start_date, end_date, status) VALUES
(1, 1, '2025-01-15', NULL, 'Active'),
(1, 3, '2025-01-15', NULL, 'Active'),
(2, 2, '2025-06-01', NULL, 'Active'),
(2, 4, '2025-06-01', NULL, 'Active'),
(3, 3, '2024-09-10', NULL, 'Active'),
(3, 6, '2024-09-10', NULL, 'Active'),
(4, 4, '2023-03-01', '2024-01-15', 'Closed'),
(4, 7, '2023-03-01', '2024-01-15', 'Closed'),
(5, 1, '2025-02-01', NULL, 'Active'),
(5, 5, '2025-02-01', NULL, 'Active'),
(6, 6, '2026-01-10', NULL, 'Active'),
(7, 2, '2024-05-01', NULL, 'Inactive'),
(8, 8, NULL, NULL, 'Active');
GO

-- TrialMedication
INSERT INTO TrialMedication (Medication_id, ClinicalTrial_id, frequency, dosage, route) VALUES
(4, 1, 'Once daily', 10.0, 'Oral'),
(10, 2, 'Every 2 weeks', 40.0, 'Subcutaneous'),
(5, 3, 'Every 3 weeks', 200.0, 'Intravenous'),
(6, 4, 'Once daily x 5 days', 100.0, 'Intravenous'),
(2, 5, 'Once daily', 20.0, 'Oral'),
(8, 6, 'Once daily', 10.0, 'Subcutaneous'),
(3, 7, 'Once daily', 50.0, 'Oral'),
(9, 8, 'Once daily', 50.0, 'Oral');
GO

-- ConsentForm (solo pacientes ya enrolados, no los en Screening puro)
INSERT INTO ConsentForm (patientClinicalTrial_id, signedDate, protocolVersion, revokedDate) VALUES
(1, '2025-01-20', 'v1.0', NULL),
(2, '2025-01-21', 'v1.0', NULL),
(3, '2025-01-22', 'v1.0', NULL),
(4, '2025-01-23', 'v1.0', NULL),
(5, '2025-01-24', 'v1.0', NULL),
(6, '2025-06-05', 'v1.0', NULL),
(7, '2025-06-10', 'v1.0', NULL),
(8, '2025-06-15', 'v1.0', NULL),
(9, '2025-06-20', 'v1.0', NULL),
(10, '2024-09-15', 'v1.0', NULL),
(11, '2024-09-20', 'v1.0', NULL),
(12, '2024-09-25', 'v1.0', NULL),
(13, '2024-09-30', 'v1.0', NULL),
(14, '2024-10-05', 'v1.0', NULL),
(15, '2023-03-05', 'v1.0', NULL),
(16, '2023-03-10', 'v1.0', NULL),
(17, '2023-03-15', 'v1.0', NULL),
(18, '2023-03-20', 'v1.0', NULL),
(19, '2025-02-05', 'v1.0', NULL),
(20, '2025-02-10', 'v1.0', NULL),
(21, '2025-02-15', 'v1.0', NULL),
(22, '2025-02-20', 'v1.0', NULL),
(23, '2025-02-25', 'v1.0', NULL),
(27, '2024-05-06', 'v1.0', '2024-05-20'),
(28, '2024-05-11', 'v1.0', '2024-05-25');
GO

-- Appointment
INSERT INTO Appointment (patientClinicalTrial_id, researcher_id, researchCenter_id, status, visitNumber, scheduleDate, attendedDate, vital_signs, clinicalNote) VALUES
(1, 1, 1, 'Completed', 1, '2025-01-25 08:00:00', '2025-01-25 08:10:00', 'BP 120, HR 70 bpm, Temp 36.5 C', 'Baseline visit, patient tolerating treatment well'),
(1, 1, 1, 'Completed', 2, '2025-02-25 09:15:00', '2025-02-25 09:32:00', 'BP 120, HR 70 bpm, Temp 36.5 C', 'Follow-up visit, no significant changes reported'),
(2, 1, 1, 'Completed', 1, '2025-01-26 10:30:00', '2025-01-26 10:54:00', 'BP 121, HR 71 bpm, Temp 36.5 C', 'Baseline visit, patient tolerating treatment well'),
(2, 1, 1, 'Completed', 2, '2025-02-26 11:45:00', '2025-02-26 12:16:00', 'BP 121, HR 71 bpm, Temp 36.5 C', 'Follow-up visit, no significant changes reported'),
(3, 1, 1, 'Completed', 1, '2025-01-27 12:00:00', '2025-01-27 12:38:00', 'BP 122, HR 72 bpm, Temp 36.5 C', 'Baseline visit, patient tolerating treatment well'),
(3, 1, 1, 'Completed', 2, '2025-02-27 13:15:00', '2025-02-27 13:29:00', 'BP 122, HR 72 bpm, Temp 36.5 C', 'Follow-up visit, no significant changes reported'),
(4, 1, 1, 'Completed', 1, '2025-01-28 14:30:00', '2025-01-28 14:51:00', 'BP 123, HR 73 bpm, Temp 36.5 C', 'Baseline visit, patient tolerating treatment well'),
(4, 1, 1, 'Completed', 2, '2025-02-28 15:45:00', '2025-02-28 16:13:00', 'BP 123, HR 73 bpm, Temp 36.5 C', 'Follow-up visit, no significant changes reported'),
(5, 1, 1, 'Completed', 1, '2025-01-28 16:00:00', '2025-01-28 16:35:00', 'BP 124, HR 74 bpm, Temp 36.5 C', 'Baseline visit, patient tolerating treatment well'),
(5, 1, 1, 'Completed', 2, '2025-02-28 08:15:00', '2025-02-28 08:26:00', 'BP 124, HR 74 bpm, Temp 36.5 C', 'Follow-up visit, no significant changes reported'),
(6, 3, 2, 'Completed', 1, '2025-06-10 09:30:00', '2025-06-10 09:48:00', 'BP 118, HR 68 bpm, Temp 36.6 C', 'Screening and enrollment visit'),
(6, 3, 2, 'Completed', 2, '2025-07-10 10:45:00', '2025-07-10 11:10:00', 'BP 118, HR 68 bpm, Temp 36.6 C', 'Routine safety follow-up'),
(7, 3, 2, 'Completed', 1, '2025-06-13 11:00:00', '2025-06-13 11:32:00', 'BP 119, HR 69 bpm, Temp 36.6 C', 'Screening and enrollment visit'),
(7, 3, 2, 'Completed', 2, '2025-07-13 12:15:00', '2025-07-13 12:54:00', 'BP 119, HR 69 bpm, Temp 36.6 C', 'Routine safety follow-up'),
(8, 3, 2, 'Completed', 1, '2025-06-16 13:30:00', '2025-06-16 13:45:00', 'BP 120, HR 70 bpm, Temp 36.6 C', 'Screening and enrollment visit'),
(8, 3, 2, 'Scheduled', 2, '2025-07-16 14:45:00', NULL, NULL, 'Routine safety follow-up'),
(9, 3, 2, 'Completed', 1, '2025-06-19 15:00:00', '2025-06-19 15:29:00', 'BP 121, HR 71 bpm, Temp 36.6 C', 'Screening and enrollment visit'),
(9, 3, 2, 'Scheduled', 2, '2025-07-19 16:15:00', NULL, NULL, 'Routine safety follow-up'),
(10, 5, 3, 'Completed', 1, '2024-09-15 08:30:00', '2024-09-15 08:42:00', 'BP 130, HR 75 bpm, Temp 36.7 C', 'Baseline tumor assessment via imaging'),
(10, 5, 3, 'Completed', 2, '2024-11-15 09:45:00', '2024-11-15 10:04:00', 'BP 130, HR 75 bpm, Temp 36.7 C', 'Follow-up imaging and response evaluation'),
(11, 5, 3, 'Completed', 1, '2024-09-18 10:00:00', '2024-09-18 10:26:00', 'BP 131, HR 76 bpm, Temp 36.7 C', 'Baseline tumor assessment via imaging'),
(11, 5, 3, 'Completed', 2, '2024-11-18 11:15:00', '2024-11-18 11:48:00', 'BP 131, HR 76 bpm, Temp 36.7 C', 'Follow-up imaging and response evaluation'),
(12, 5, 3, 'Completed', 1, '2024-09-21 12:30:00', '2024-09-21 13:10:00', 'BP 132, HR 77 bpm, Temp 36.7 C', 'Baseline tumor assessment via imaging'),
(12, 5, 3, 'Completed', 2, '2024-11-21 13:45:00', '2024-11-21 14:01:00', 'BP 132, HR 77 bpm, Temp 36.7 C', 'Follow-up imaging and response evaluation'),
(13, 5, 3, 'Completed', 1, '2024-09-24 14:00:00', '2024-09-24 14:23:00', 'BP 133, HR 78 bpm, Temp 36.7 C', 'Baseline tumor assessment via imaging'),
(13, 5, 3, 'Completed', 2, '2024-11-24 15:15:00', '2024-11-24 15:45:00', 'BP 133, HR 78 bpm, Temp 36.7 C', 'Follow-up imaging and response evaluation'),
(14, 5, 3, 'Completed', 1, '2024-09-27 16:30:00', '2024-09-27 17:07:00', 'BP 134, HR 79 bpm, Temp 36.7 C', 'Baseline tumor assessment via imaging'),
(14, 5, 3, 'Completed', 2, '2024-11-27 08:45:00', '2024-11-27 08:58:00', 'BP 134, HR 79 bpm, Temp 36.7 C', 'Follow-up imaging and response evaluation'),
(15, 7, 4, 'Completed', 1, '2023-03-10 09:00:00', '2023-03-10 09:20:00', 'BP 100, HR 80 bpm, Temp 37.2 C', 'COVID-19 treatment day 1, monitoring respiratory function'),
(15, 7, 4, 'Completed', 2, '2023-04-10 10:15:00', '2023-04-10 10:42:00', 'BP 100, HR 80 bpm, Temp 36.9 C', 'COVID-19 treatment day 2, monitoring respiratory function'),
(15, 7, 4, 'Completed', 3, '2023-05-10 11:30:00', '2023-05-10 12:04:00', 'BP 100, HR 80 bpm, Temp 36.6 C', 'COVID-19 treatment day 3, monitoring respiratory function'),
(16, 7, 4, 'Completed', 1, '2023-03-13 12:45:00', '2023-03-13 12:55:00', 'BP 101, HR 81 bpm, Temp 37.2 C', 'COVID-19 treatment day 1, monitoring respiratory function'),
(16, 7, 4, 'Completed', 2, '2023-04-13 13:00:00', '2023-04-13 13:17:00', 'BP 101, HR 81 bpm, Temp 36.9 C', 'COVID-19 treatment day 2, monitoring respiratory function'),
(16, 7, 4, 'Completed', 3, '2023-05-13 14:15:00', '2023-05-13 14:39:00', 'BP 101, HR 81 bpm, Temp 36.6 C', 'COVID-19 treatment day 3, monitoring respiratory function'),
(17, 7, 4, 'Completed', 1, '2023-03-16 15:30:00', '2023-03-16 16:01:00', 'BP 102, HR 82 bpm, Temp 37.2 C', 'COVID-19 treatment day 1, monitoring respiratory function'),
(17, 7, 4, 'Completed', 2, '2023-04-16 16:45:00', '2023-04-16 17:23:00', 'BP 102, HR 82 bpm, Temp 36.9 C', 'COVID-19 treatment day 2, monitoring respiratory function'),
(17, 7, 4, 'Completed', 3, '2023-05-16 08:00:00', '2023-05-16 08:14:00', 'BP 102, HR 82 bpm, Temp 36.6 C', 'COVID-19 treatment day 3, monitoring respiratory function'),
(18, 7, 4, 'Completed', 1, '2023-03-19 09:15:00', '2023-03-19 09:36:00', 'BP 103, HR 83 bpm, Temp 37.2 C', 'COVID-19 treatment day 1, monitoring respiratory function'),
(18, 7, 4, 'Completed', 2, '2023-04-19 10:30:00', '2023-04-19 10:58:00', 'BP 103, HR 83 bpm, Temp 36.9 C', 'COVID-19 treatment day 2, monitoring respiratory function'),
(18, 7, 4, 'Completed', 3, '2023-05-19 11:45:00', '2023-05-19 12:20:00', 'BP 103, HR 83 bpm, Temp 36.6 C', 'COVID-19 treatment day 3, monitoring respiratory function'),
(19, 9, 1, 'Completed', 1, '2025-02-05 12:00:00', '2025-02-05 12:11:00', 'BP 125, HR 72 bpm, Temp 36.5 C', 'Baseline lipid panel and cardiovascular assessment'),
(19, 9, 1, 'Completed', 2, '2025-05-05 13:15:00', '2025-05-05 13:33:00', 'BP 125, HR 72 bpm, Temp 36.5 C', 'Follow-up lipid panel'),
(20, 9, 1, 'Completed', 1, '2025-02-09 14:30:00', '2025-02-09 14:55:00', 'BP 126, HR 73 bpm, Temp 36.5 C', 'Baseline lipid panel and cardiovascular assessment'),
(20, 9, 1, 'Completed', 2, '2025-05-09 15:45:00', '2025-05-09 16:17:00', 'BP 126, HR 73 bpm, Temp 36.5 C', 'Follow-up lipid panel'),
(21, 9, 1, 'Completed', 1, '2025-02-13 16:00:00', '2025-02-13 16:39:00', 'BP 127, HR 74 bpm, Temp 36.5 C', 'Baseline lipid panel and cardiovascular assessment'),
(21, 9, 1, 'Completed', 2, '2025-05-13 08:15:00', '2025-05-13 08:30:00', 'BP 127, HR 74 bpm, Temp 36.5 C', 'Follow-up lipid panel'),
(22, 9, 1, 'Completed', 1, '2025-02-17 09:30:00', '2025-02-17 09:52:00', 'BP 128, HR 75 bpm, Temp 36.5 C', 'Baseline lipid panel and cardiovascular assessment'),
(22, 9, 1, 'Completed', 2, '2025-05-17 10:45:00', '2025-05-17 11:14:00', 'BP 128, HR 75 bpm, Temp 36.5 C', 'Follow-up lipid panel'),
(23, 9, 1, 'Completed', 1, '2025-02-21 11:00:00', '2025-02-21 11:36:00', 'BP 129, HR 76 bpm, Temp 36.5 C', 'Baseline lipid panel and cardiovascular assessment'),
(23, 9, 1, 'Completed', 2, '2025-05-21 12:15:00', '2025-05-21 12:27:00', 'BP 129, HR 76 bpm, Temp 36.5 C', 'Follow-up lipid panel'),
(24, 11, 6, 'Scheduled', 1, '2026-07-20 13:30:00', NULL, NULL, 'Initial screening visit pending'),
(25, 11, 6, 'Scheduled', 1, '2026-07-22 14:45:00', NULL, NULL, 'Initial screening visit pending'),
(26, 11, 6, 'Scheduled', 1, '2026-07-24 15:00:00', NULL, NULL, 'Initial screening visit pending'),
(27, 13, 2, 'Completed', 1, '2024-05-15 16:15:00', '2024-05-15 16:55:00', 'BP 140, HR 88 bpm, Temp 37.0 C', 'Patient reported severe adverse reaction, withdrew consent after this visit'),
(28, 13, 2, 'Completed', 1, '2024-05-20 08:30:00', '2024-05-21 08:46:00', 'BP 138, HR 85 bpm, Temp 36.9 C', 'Patient withdrew due to personal reasons unrelated to treatment'),
(29, 15, 8, 'Scheduled', 1, '2026-08-01 09:45:00', NULL, NULL, 'Initial screening visit pending'),
(30, 15, 8, 'Scheduled', 1, '2026-08-05 10:00:00', NULL, NULL, 'Initial screening visit pending');
GO

-- AdverseEvent
INSERT INTO AdverseEvent (appointment_id, description, severity, onset_date) VALUES
(2, 'Mild headache reported after treatment initiation', 1, '2025-02-25'),
(6, 'Mild nausea and gastrointestinal discomfort', 2, '2025-02-01'),
(14, 'Moderate injection site reaction with redness and swelling', 2, '2025-07-01'),
(20, 'Fatigue and general malaise', 2, '2024-11-01'),
(26, 'Moderate joint pain in lower extremities', 3, '2024-11-01'),
(33, 'Elevated liver enzymes detected on routine monitoring', 4, '2023-05-10'),
(36, 'Skin rash covering torso and arms', 3, '2023-05-10'),
(42, 'Muscle pain and mild myalgia', 2, '2025-03-01'),
(48, 'Severe hypoglycemic episode requiring medical attention', 5, '2025-04-01'),
(54, 'Severe allergic reaction leading to trial withdrawal', 5, '2024-05-15');
GO

-- LabResult
INSERT INTO LabResult (appointment_id, test_type, measured_value, unit, test_Name, referenceMin, referenceMax) VALUES
(1, 'Chemistry', 97.3, 'mg/dL', 'LDL Cholesterol', 0, 130),
(1, 'Hematology', 10.9, 'g/dL', 'Hemoglobin', 12, 17),
(2, 'Chemistry', 1.1, 'mg/dL', 'Creatinine', 0.6, 1.3),
(3, 'Chemistry', 64.3, 'mg/dL', 'Fasting Glucose', 70, 100),
(4, 'Chemistry', 117.5, 'mg/dL', 'Total Cholesterol', 125, 200),
(4, 'Chemistry', 4.7, '%', 'HbA1c', 4.0, 5.7),
(5, 'Hematology', 16.1, 'g/dL', 'Hemoglobin', 12, 17),
(6, 'Immunology', 0.3, 'mg/L', 'C-Reactive Protein', 0, 5),
(7, 'Chemistry', 90.4, 'mg/dL', 'Fasting Glucose', 70, 100),
(8, 'Chemistry', 30.4, 'U/L', 'ALT (Liver Enzyme)', 7, 56),
(9, 'Chemistry', 38.7, 'U/L', 'ALT (Liver Enzyme)', 7, 56),
(10, 'Chemistry', 178.2, 'mg/dL', 'Total Cholesterol', 125, 200),
(11, 'Chemistry', 0.6, 'mg/dL', 'Creatinine', 0.6, 1.3),
(12, 'Chemistry', 93.9, 'mg/dL', 'Fasting Glucose', 70, 100),
(13, 'Immunology', 1.8, 'mg/L', 'C-Reactive Protein', 0, 5),
(13, 'Chemistry', 5.2, '%', 'HbA1c', 4.0, 5.7),
(14, 'Chemistry', 0.8, 'mg/dL', 'Creatinine', 0.6, 1.3),
(14, 'Chemistry', 26.9, 'mg/dL', 'LDL Cholesterol', 0, 130),
(15, 'Chemistry', 177.3, 'mg/dL', 'Total Cholesterol', 125, 200),
(17, 'Chemistry', 1.0, 'mg/dL', 'Creatinine', 0.6, 1.3),
(17, 'Chemistry', 5.3, '%', 'HbA1c', 4.0, 5.7),
(19, 'Chemistry', 169.6, 'mg/dL', 'Total Cholesterol', 125, 200),
(20, 'Chemistry', 0.7, 'mg/dL', 'Creatinine', 0.6, 1.3),
(21, 'Immunology', 5.5, 'mg/L', 'C-Reactive Protein', 0, 5),
(21, 'Chemistry', 63.8, 'mg/dL', 'Fasting Glucose', 70, 100),
(22, 'Chemistry', 0.9, 'mg/dL', 'Creatinine', 0.6, 1.3),
(22, 'Chemistry', 5.0, '%', 'HbA1c', 4.0, 5.7),
(23, 'Chemistry', 117.8, 'mg/dL', 'Total Cholesterol', 125, 200),
(23, 'Immunology', 1.6, 'mg/L', 'C-Reactive Protein', 0, 5),
(24, 'Chemistry', 100.1, 'mg/dL', 'Fasting Glucose', 70, 100),
(25, 'Chemistry', 5.7, '%', 'HbA1c', 4.0, 5.7),
(25, 'Chemistry', 132.6, 'mg/dL', 'LDL Cholesterol', 0, 130),
(26, 'Chemistry', 79.2, 'mg/dL', 'Fasting Glucose', 70, 100),
(26, 'Hematology', 15.9, 'g/dL', 'Hemoglobin', 12, 17),
(27, 'Chemistry', 102.1, 'mg/dL', 'Fasting Glucose', 70, 100),
(27, 'Chemistry', 122.3, 'mg/dL', 'Total Cholesterol', 125, 200),
(28, 'Immunology', 2.2, 'mg/L', 'C-Reactive Protein', 0, 5),
(29, 'Chemistry', 161.8, 'mg/dL', 'Total Cholesterol', 125, 200),
(29, 'Chemistry', 5.1, '%', 'HbA1c', 4.0, 5.7),
(30, 'Immunology', 5.0, 'mg/L', 'C-Reactive Protein', 0, 5),
(31, 'Immunology', 3.9, 'mg/L', 'C-Reactive Protein', 0, 5),
(31, 'Chemistry', 56.9, 'mg/dL', 'LDL Cholesterol', 0, 130),
(32, 'Chemistry', 12.4, 'mg/dL', 'LDL Cholesterol', 0, 130),
(33, 'Hematology', 16.4, 'g/dL', 'Hemoglobin', 12, 17),
(34, 'Chemistry', 6.0, '%', 'HbA1c', 4.0, 5.7),
(35, 'Chemistry', 22.4, 'U/L', 'ALT (Liver Enzyme)', 7, 56),
(36, 'Immunology', 3.1, 'mg/L', 'C-Reactive Protein', 0, 5),
(37, 'Chemistry', 128.5, 'mg/dL', 'LDL Cholesterol', 0, 130),
(37, 'Chemistry', 1.4, 'mg/dL', 'Creatinine', 0.6, 1.3),
(38, 'Chemistry', 6.2, '%', 'HbA1c', 4.0, 5.7),
(39, 'Immunology', 2.3, 'mg/L', 'C-Reactive Protein', 0, 5),
(39, 'Hematology', 14.7, 'g/dL', 'Hemoglobin', 12, 17),
(40, 'Chemistry', 63.2, 'mg/dL', 'Fasting Glucose', 70, 100),
(40, 'Chemistry', 132.1, 'mg/dL', 'Total Cholesterol', 125, 200),
(41, 'Chemistry', 148.3, 'mg/dL', 'Total Cholesterol', 125, 200),
(42, 'Chemistry', 106.3, 'mg/dL', 'Total Cholesterol', 125, 200),
(43, 'Chemistry', 223.7, 'mg/dL', 'Total Cholesterol', 125, 200),
(44, 'Chemistry', 214.4, 'mg/dL', 'Total Cholesterol', 125, 200),
(45, 'Chemistry', 37.7, 'mg/dL', 'LDL Cholesterol', 0, 130),
(45, 'Chemistry', 0.9, 'mg/dL', 'Creatinine', 0.6, 1.3),
(46, 'Chemistry', 3.8, '%', 'HbA1c', 4.0, 5.7),
(46, 'Chemistry', 86.6, 'mg/dL', 'Fasting Glucose', 70, 100),
(47, 'Chemistry', 4.4, '%', 'HbA1c', 4.0, 5.7),
(47, 'Hematology', 11.5, 'g/dL', 'Hemoglobin', 12, 17),
(48, 'Chemistry', 54.4, 'U/L', 'ALT (Liver Enzyme)', 7, 56),
(48, 'Hematology', 11.7, 'g/dL', 'Hemoglobin', 12, 17),
(49, 'Hematology', 19.1, 'g/dL', 'Hemoglobin', 12, 17),
(50, 'Chemistry', 81.2, 'mg/dL', 'LDL Cholesterol', 0, 130),
(50, 'Chemistry', 0.5, 'mg/dL', 'Creatinine', 0.6, 1.3),
(54, 'Chemistry', 210.9, 'mg/dL', 'Total Cholesterol', 125, 200),
(54, 'Chemistry', 1.0, 'mg/dL', 'Creatinine', 0.6, 1.3),
(55, 'Chemistry', 1.3, 'mg/dL', 'Creatinine', 0.6, 1.3);
GO

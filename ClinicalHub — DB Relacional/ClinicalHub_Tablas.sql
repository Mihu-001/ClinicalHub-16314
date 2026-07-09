-- ==============================================================================
-- ClinicalHub - Script COMPLETO de creación de base de datos
-- ==============================================================================
-- Orden de ejecución pensado para simular un caso real:
--   1) Crear la base de datos
--   2) Crear tablas "base" (sin dependencias / catálogos)                -> Nivel 0
--   3) Crear tablas que dependen de las de Nivel 0                      -> Nivel 1
--   4) Crear tablas que dependen de Nivel 1                             -> Nivel 2
--   5) Crear tablas puente/intermedias (dependen de tablas ya creadas)  -> Nivel 3
--   6) Agregar las FOREIGN KEYS (una vez que TODAS las tablas existen)
--   7) Agregar restricciones UNIQUE compuestas (reglas de negocio)
--   8) Agregar restricciones CHECK (valores válidos / coherencia)
--   9) Crear índices sobre las columnas FK
-- ==============================================================================

CREATE DATABASE ClinicalHub;
GO

USE ClinicalHub;
GO


-- ==============================================================================
-- NIVEL 0: Tablas base (catálogos / entidades sin dependencias foráneas)
-- ==============================================================================

-- Patrocinador del ensayo clínico
CREATE TABLE Sponsor
(
  id           int          NOT NULL IDENTITY(1,1),
  name         varchar(150) NOT NULL,
  contact_info varchar(100),
  org_type     varchar(100),
  country      varchar(100),
  CONSTRAINT PK_Sponsor PRIMARY KEY (id)
)
GO

-- Fase del ensayo (I, II, III, IV)
CREATE TABLE TrialPhase
(
  id           int          NOT NULL IDENTITY(1,1),
  phase_number int          NOT NULL,
  name         varchar(100) NOT NULL,
  objective    varchar(200),
  CONSTRAINT PK_TrialPhase PRIMARY KEY (id)
)
GO

-- Medicamento (catálogo general, no depende de ningún ensayo específico)
CREATE TABLE Medication
(
  id               int          NOT NULL IDENTITY(1,1),
  name             varchar(150),
  activeIngredient varchar(150),
  CONSTRAINT PK_Medication PRIMARY KEY (id)
)
GO

-- Paciente
CREATE TABLE Patient
(
  id           int          NOT NULL IDENTITY(1,1),
  first_name   varchar(30)  NOT NULL,
  last_name    varchar(30)  NOT NULL,
  date_birth   date         NOT NULL,
  gender       varchar(20)  NOT NULL,
  blood_type   varchar(10)  NOT NULL,
  contactEmail varchar(100) NOT NULL,
  CONSTRAINT PK_Patient PRIMARY KEY (id)
)
GO

-- Centro de investigación
CREATE TABLE ResearchCenter
(
  id            int          NOT NULL IDENTITY(1,1),
  name          varchar(100) NOT NULL,
  location      varchar(100) NOT NULL,
  facility_type varchar(50)  NOT NULL,
  country       varchar(100),
  contactEmail  varchar(100) NOT NULL,
  CONSTRAINT PK_ResearchCenter PRIMARY KEY (id)
)
GO

-- ==============================================================================
-- NIVEL 1: Tablas que dependen únicamente de tablas de Nivel 0
-- ==============================================================================

-- Investigador, depende de ResearchCenter
CREATE TABLE Researcher
(
  id                int          NOT NULL IDENTITY(1,1),
  ResearchCenter_id int          NOT NULL,
  first_name        varchar(30)  NOT NULL,
  last_name         varchar(30)  NOT NULL,
  specialization    varchar(50)  NOT NULL,
  email             varchar(100) NOT NULL,
  role              varchar(50) ,
  CONSTRAINT PK_Researcher PRIMARY KEY (id)
)
GO

-- Ensayo clínico, depende de Sponsor y TrialPhase
CREATE TABLE ClinicalTrial
(
  id             int          NOT NULL IDENTITY(1,1),
  sponsor_id     int          NOT NULL,
  TrialPhase_id  int          NOT NULL,
  title          varchar(255) NOT NULL,
  status         varchar(50)  NOT NULL,
  description    varchar(500),
  start_date     date        ,
  end_date       date        ,
  CONSTRAINT PK_ClinicalTrial PRIMARY KEY (id)
)
GO


-- ==============================================================================
-- NIVEL 2: Tablas que dependen de tablas de Nivel 1
-- ==============================================================================

-- Inscripción de un paciente en un ensayo clínico (tabla puente Patient <-> ClinicalTrial)
-- NOTA: aunque conceptualmente es una tabla "intermedia" muchos-a-muchos entre
-- Patient y ClinicalTrial, se crea aquí porque AMBAS tablas base (Patient y
-- ClinicalTrial) ya existen en este punto del script. Nunca antes que ellas.
CREATE TABLE Patient_ClinicalTrial
(
  id               int          NOT NULL IDENTITY(1,1),
  trial_id         int          NOT NULL,
  patient_id       int          NOT NULL,
  status           varchar(50)  NOT NULL,
  enrollment_date  date        ,
  CONSTRAINT PK_Patient_ClinicalTrial PRIMARY KEY (id)
)
GO

-- Investigadores asignados a un ensayo (tabla puente Researcher <-> ClinicalTrial)
CREATE TABLE ResearcherClinicalTrial
(
  id               int         NOT NULL IDENTITY(1,1),
  researcher_id    int         NOT NULL,
  clinicalTrial_id int         NOT NULL,
  roleInTrial      varchar(50) NOT NULL,
  start_date       date       ,
  end_date         date       ,
  CONSTRAINT PK_ResearcherClinicalTrial PRIMARY KEY (id)
)
GO

-- Centros asignados a un ensayo (tabla puente ClinicalTrial <-> ResearchCenter)
CREATE TABLE ClinicalTrialCenter
(
  id                int          NOT NULL IDENTITY(1,1),
  clinicalTrial_id  int          NOT NULL,
  researchCenter_id int          NOT NULL,
  start_date        date        ,
  end_date          date        ,
  status            varchar(50)  NOT NULL,
  CONSTRAINT PK_ClinicalTrialCenter PRIMARY KEY (id)
)
GO

-- Medicamentos usados en un ensayo (tabla puente Medication <-> ClinicalTrial)
CREATE TABLE TrialMedication
(
  id               int           NOT NULL IDENTITY(1,1),
  Medication_id    int           NOT NULL,
  ClinicalTrial_id int           NOT NULL,
  frequency        varchar(50)  ,
  dosage           decimal(10,2),
  route            varchar(50)  ,
  CONSTRAINT PK_TrialMedication PRIMARY KEY (id)
)
GO


-- ==============================================================================
-- NIVEL 3: Tablas que dependen de Nivel 2
-- ==============================================================================

-- Consentimiento informado, depende de la inscripción del paciente en el ensayo
CREATE TABLE ConsentForm
(
  id                      int          NOT NULL IDENTITY(1,1),
  patientClinicalTrial_id int          NOT NULL,
  signedDate              date         NOT NULL,
  protocolVersion         varchar(100) NOT NULL,
  revokedDate             date        ,
  CONSTRAINT PK_ConsentForm PRIMARY KEY (id)
)
GO

-- Cita/visita clínica, depende de Patient_ClinicalTrial, Researcher y ResearchCenter
CREATE TABLE Appointment
(
  id                      int          NOT NULL IDENTITY(1,1),
  patientClinicalTrial_id int          NOT NULL,
  researcher_id           int          NOT NULL,
  researchCenter_id       int          NOT NULL,
  status                  varchar(50)  NOT NULL,
  visitNumber             int          NOT NULL,
  scheduleDate            datetime    ,
  attendedDate            datetime    ,
  vital_signs             varchar(200),
  clinicalNote            varchar(500),
  CONSTRAINT PK_Appointment PRIMARY KEY (id)
)
GO

-- ==============================================================================
-- NIVEL 4: Tablas que dependen de Appointment (Nivel 3)
-- ==============================================================================

-- Evento adverso, depende de la cita en la que se detectó
CREATE TABLE AdverseEvent
(
  id             int          NOT NULL IDENTITY(1,1),
  appointment_id int          NOT NULL,
  description    varchar(200),
  severity       int         ,
  onset_date     date        ,
  CONSTRAINT PK_AdverseEvent  PRIMARY KEY (id)
)
GO

-- Resultado de laboratorio, depende de la cita en la que se tomó la muestra
CREATE TABLE LabResult
(
  id             int         NOT NULL IDENTITY(1,1),
  appointment_id int         NOT NULL,
  test_type      varchar(50),
  measured_value float      ,
  unit           varchar(10),
  test_Name      varchar(50),
  referenceMin   float      ,
  referenceMax   float      ,
  CONSTRAINT PK_LabResult  PRIMARY KEY (id)
)
GO

-- ==============================================================================
-- FOREIGN KEYS
-- (Se agregan al final, cuando TODAS las tablas ya existen. Así el orden de
--  creación de tablas nunca puede fallar por una referencia inexistente.)
-- ==============================================================================

-- Researcher
ALTER TABLE Researcher
  ADD CONSTRAINT FK_ResearchCenter_TO_Researcher
    FOREIGN KEY (ResearchCenter_id) REFERENCES ResearchCenter (id)
GO

-- ClinicalTrial
ALTER TABLE ClinicalTrial
  ADD CONSTRAINT FK_Sponsor_TO_ClinicalTrial
    FOREIGN KEY (sponsor_id) REFERENCES Sponsor (id)
GO

ALTER TABLE ClinicalTrial
  ADD CONSTRAINT FK_TrialPhase_TO_ClinicalTrial
    FOREIGN KEY (TrialPhase_id) REFERENCES TrialPhase (id)
GO

-- Patient_ClinicalTrial
ALTER TABLE Patient_ClinicalTrial
  ADD CONSTRAINT FK_ClinicalTrial_TO_Patient_ClinicalTrial
    FOREIGN KEY (trial_id) REFERENCES ClinicalTrial (id)
GO

ALTER TABLE Patient_ClinicalTrial
  ADD CONSTRAINT FK_Patient_TO_Patient_ClinicalTrial
    FOREIGN KEY (patient_id) REFERENCES Patient (id)
GO

-- ResearcherClinicalTrial
ALTER TABLE ResearcherClinicalTrial
  ADD CONSTRAINT FK_Researcher_TO_ResearcherClinicalTrial
    FOREIGN KEY (researcher_id) REFERENCES Researcher (id)
GO

ALTER TABLE ResearcherClinicalTrial
  ADD CONSTRAINT FK_ClinicalTrial_TO_ResearcherClinicalTrial
    FOREIGN KEY (clinicalTrial_id) REFERENCES ClinicalTrial (id)
GO

-- ClinicalTrialCenter
ALTER TABLE ClinicalTrialCenter
  ADD CONSTRAINT FK_ClinicalTrial_TO_ClinicalTrialCenter
    FOREIGN KEY (clinicalTrial_id) REFERENCES ClinicalTrial (id)
GO

ALTER TABLE ClinicalTrialCenter
  ADD CONSTRAINT FK_ResearchCenter_TO_ClinicalTrialCenter
    FOREIGN KEY (researchCenter_id) REFERENCES ResearchCenter (id)
GO

-- TrialMedication
ALTER TABLE TrialMedication
  ADD CONSTRAINT FK_Medication_TO_TrialMedication
    FOREIGN KEY (Medication_id) REFERENCES Medication (id)
GO

ALTER TABLE TrialMedication
  ADD CONSTRAINT FK_ClinicalTrial_TO_TrialMedication
    FOREIGN KEY (ClinicalTrial_id) REFERENCES ClinicalTrial (id)
GO

-- ConsentForm
ALTER TABLE ConsentForm
  ADD CONSTRAINT FK_Patient_ClinicalTrial_TO_ConsentForm
    FOREIGN KEY (patientClinicalTrial_id) REFERENCES Patient_ClinicalTrial (id)
GO

-- Appointment
ALTER TABLE Appointment
  ADD CONSTRAINT FK_Patient_ClinicalTrial_TO_Appointment
    FOREIGN KEY (patientClinicalTrial_id) REFERENCES Patient_ClinicalTrial (id)
GO

ALTER TABLE Appointment
  ADD CONSTRAINT FK_Researcher_TO_Appointment
    FOREIGN KEY (researcher_id) REFERENCES Researcher (id)
GO

ALTER TABLE Appointment
  ADD CONSTRAINT FK_ResearchCenter_TO_Appointment
    FOREIGN KEY (researchCenter_id) REFERENCES ResearchCenter (id)
GO

-- AdverseEvent
ALTER TABLE AdverseEvent
  ADD CONSTRAINT FK_Appointment_TO_AdverseEvent
    FOREIGN KEY (appointment_id) REFERENCES Appointment (id)
GO

-- LabResult
ALTER TABLE LabResult
  ADD CONSTRAINT FK_Appointment_TO_LabResult
    FOREIGN KEY (appointment_id) REFERENCES Appointment (id)
GO

-- ==============================================================================
-- RESTRICCIONES UNIQUE (correos + reglas de negocio en tablas puente)
-- ==============================================================================

ALTER TABLE Patient
  ADD CONSTRAINT UQ_Patient_contactEmail UNIQUE (contactEmail)
GO

ALTER TABLE ResearchCenter
  ADD CONSTRAINT UQ_ResearchCenter_contactEmail UNIQUE (contactEmail)
GO

ALTER TABLE Researcher
  ADD CONSTRAINT UQ_Researcher_email UNIQUE (email)
GO

-- Un paciente no puede inscribirse dos veces en el mismo ensayo
ALTER TABLE Patient_ClinicalTrial
  ADD CONSTRAINT UQ_Patient_Trial UNIQUE (patient_id, trial_id)
GO

-- Un investigador no se repite con el mismo rol en el mismo ensayo
ALTER TABLE ResearcherClinicalTrial
  ADD CONSTRAINT UQ_Researcher_Trial UNIQUE (researcher_id, clinicalTrial_id)
GO

-- Un centro no se vincula dos veces al mismo ensayo
ALTER TABLE ClinicalTrialCenter
  ADD CONSTRAINT UQ_Trial_Center UNIQUE (clinicalTrial_id, researchCenter_id)
GO

-- Un medicamento no se repite dentro del mismo ensayo
ALTER TABLE TrialMedication
  ADD CONSTRAINT UQ_Medication_Trial UNIQUE (Medication_id, ClinicalTrial_id)
GO

-- No se repite el número de visita para el mismo paciente-ensayo
ALTER TABLE Appointment
  ADD CONSTRAINT UQ_PatientTrial_Visit UNIQUE (patientClinicalTrial_id, visitNumber)
GO

-- cada inscripción tenga como máximo un solo ConsentForm
ALTER TABLE ConsentForm
  ADD CONSTRAINT UQ_ConsentForm_PatientClinicalTrial UNIQUE (patientClinicalTrial_id)
GO

-- ==============================================================================
-- RESTRICCIONES CHECK (valores válidos y coherencia de fechas)
-- ==============================================================================

ALTER TABLE ClinicalTrial
  ADD CONSTRAINT CK_ClinicalTrial_status
    CHECK (status IN ('Planned','Recruiting','Active','Suspended','Completed','Terminated'))
GO

ALTER TABLE Patient_ClinicalTrial
  ADD CONSTRAINT CK_PatientTrial_status
    CHECK (status IN ('Screening','Enrolled','Active','Withdrawn','Completed'))
GO

ALTER TABLE ClinicalTrialCenter
  ADD CONSTRAINT CK_TrialCenter_status
    CHECK (status IN ('Active','Inactive','Closed'))
GO

ALTER TABLE Appointment
  ADD CONSTRAINT CK_Appointment_status
    CHECK (status IN ('Scheduled','Completed','Cancelled','NoShow','Rescheduled'))
GO

ALTER TABLE AdverseEvent
  ADD CONSTRAINT CK_AdverseEvent_severity
    CHECK (severity BETWEEN 1 AND 5)  -- 1 = Leve ... 5 = Grave/Fatal
GO

ALTER TABLE Patient
  ADD CONSTRAINT CK_Patient_gender
    CHECK (gender IN ('Male','Female','Other','Prefer not to say'))
GO

ALTER TABLE Patient
  ADD CONSTRAINT CK_Patient_bloodType
    CHECK (blood_type IN ('A+','A-','B+','B-','AB+','AB-','O+','O-'))
GO

ALTER TABLE ClinicalTrial
  ADD CONSTRAINT CK_ClinicalTrial_dates
    CHECK (end_date IS NULL OR start_date IS NULL OR start_date <= end_date)
GO

ALTER TABLE ClinicalTrialCenter
  ADD CONSTRAINT CK_TrialCenter_dates
    CHECK (end_date IS NULL OR start_date IS NULL OR start_date <= end_date)
GO

ALTER TABLE ResearcherClinicalTrial
  ADD CONSTRAINT CK_ResearcherTrial_dates
    CHECK (end_date IS NULL OR start_date IS NULL OR start_date <= end_date)
GO

ALTER TABLE Appointment
  ADD CONSTRAINT CK_Appointment_dates
    CHECK (attendedDate IS NULL OR scheduleDate IS NULL OR attendedDate >= scheduleDate)
GO


-- ==============================================================================
-- ÍNDICES SOBRE COLUMNAS FK (SQL Server no las indexa automáticamente)
-- ==============================================================================

CREATE INDEX IX_Researcher_ResearchCenter ON Researcher (ResearchCenter_id)
GO
CREATE INDEX IX_ClinicalTrial_Sponsor ON ClinicalTrial (sponsor_id)
GO
CREATE INDEX IX_ClinicalTrial_TrialPhase ON ClinicalTrial (TrialPhase_id)
GO
CREATE INDEX IX_PatientTrial_Trial ON Patient_ClinicalTrial (trial_id)
GO
CREATE INDEX IX_PatientTrial_Patient ON Patient_ClinicalTrial (patient_id)
GO
CREATE INDEX IX_ResearcherTrial_Researcher ON ResearcherClinicalTrial (researcher_id)
GO
CREATE INDEX IX_ResearcherTrial_ClinicalTrial ON ResearcherClinicalTrial (clinicalTrial_id)
GO
CREATE INDEX IX_TrialCenter_ClinicalTrial ON ClinicalTrialCenter (clinicalTrial_id)
GO
CREATE INDEX IX_TrialCenter_ResearchCenter ON ClinicalTrialCenter (researchCenter_id)
GO
CREATE INDEX IX_TrialMedication_Medication ON TrialMedication (Medication_id)
GO
CREATE INDEX IX_TrialMedication_ClinicalTrial ON TrialMedication (ClinicalTrial_id)
GO
CREATE INDEX IX_ConsentForm_PatientClinicalTrial ON ConsentForm (patientClinicalTrial_id)
GO
CREATE INDEX IX_Appointment_PatientClinicalTrial ON Appointment (patientClinicalTrial_id)
GO
CREATE INDEX IX_Appointment_Researcher ON Appointment (researcher_id)
GO
CREATE INDEX IX_Appointment_ResearchCenter ON Appointment (researchCenter_id)
GO
CREATE INDEX IX_AdverseEvent_Appointment ON AdverseEvent (appointment_id)
GO
CREATE INDEX IX_LabResult_Appointment ON LabResult (appointment_id)
GO


-- ==============================================================================
-- FIN DEL SCRIPT
-- ==============================================================================
-- Resumen del orden real de dependencias:
-- Nivel 0 (sin FK):        Sponsor, TrialPhase, Medication, Patient, ResearchCenter
-- Nivel 1 (dependen de 0): Researcher, ClinicalTrial
-- Nivel 2 (dependen de 1): Patient_ClinicalTrial, ResearcherClinicalTrial,
--                          ClinicalTrialCenter, TrialMedication  <- tablas puente
-- Nivel 3 (dependen de 2): ConsentForm, Appointment
-- Nivel 4 (dependen de 3): AdverseEvent, LabResult
-- Las FKs, UNIQUE, CHECK e índices se agregan al final, una vez existen todas
-- las tablas, evitando cualquier error de referencia a objetos inexistentes.
-- ==============================================================================

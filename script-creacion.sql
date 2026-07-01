-- ==============================================================================
-- Creación de la Base de Datos
-- ==============================================================================
CREATE DATABASE ClinicalHub;
GO

USE ClinicalHub;
GO


-- Creación de Tablas (Sin dependencias foráneas)
-- ==============================================================================

-- Creación de la tabla AdverseEvent
CREATE TABLE AdverseEvent 
(
  id             int          NOT NULL IDENTITY(1,1),
  appointment_id int          NOT NULL,
  description    varchar(100),
  severity       int         ,
  onset_date     date        ,
  CONSTRAINT PK_AdverseEvent  PRIMARY KEY (id)
)
GO

-- Creación de la tabla Appointment
CREATE TABLE Appointment
(
  id                      int          NOT NULL IDENTITY(1,1),
  patientClinicalTrial_id int          NOT NULL,
  researcher_id           int          NOT NULL,
  researchCenter_id       int          NOT NULL,
  status                  varchar(100) NOT NULL,
  visitNumber             int          NOT NULL,
  scheduleDate            datetime    ,
  attendedDate            datetime    ,
  vital_signs             varchar(100),
  clinicalNote            varchar(500),
  CONSTRAINT PK_Appointment PRIMARY KEY (id)
)
GO

-- Creación de la tabla ClinicalTrial
CREATE TABLE ClinicalTrial
(
  id             int          NOT NULL IDENTITY(1,1),
  sponsor_id     int          NOT NULL,
  TrialPhase_id  int          NOT NULL,
  title          varchar(30)  NOT NULL,
  status         varchar(100) NOT NULL,
  description    varchar(100),
  start_date     date        ,
  end_date       date        ,
  CONSTRAINT PK_ClinicalTrial PRIMARY KEY (id)
)
GO

-- Creación de la tabla ClinicalTrialCenter
CREATE TABLE ClinicalTrialCenter
(
  id                int          NOT NULL IDENTITY(1,1),
  clinicalTrial_id  int          NOT NULL,
  researchCenter_id int          NOT NULL,
  start_date        date        ,
  end_date          date        ,
  status            varchar(100) NOT NULL,
  CONSTRAINT PK_ClinicalTrialCenter PRIMARY KEY (id)
)
GO

-- Creación de la tabla ConsentForm
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

-- Creación de la tabla LabResult
CREATE TABLE LabResult 
(
  id             int         NOT NULL IDENTITY(1,1),
  appointment_id int         NOT NULL,
  test_type      varchar(30),
  measured_value float      ,
  unit           varchar(10),
  test_Name      varchar(30),
  referenceMin   float      ,
  referenceMax   float      ,
  CONSTRAINT PK_LabResult  PRIMARY KEY (id)
)
GO

-- Creación de la tabla Medication
CREATE TABLE Medication
(
  id               int          NOT NULL IDENTITY(1,1),
  name             varchar(100),
  activeIngredient varchar(100),
  CONSTRAINT PK_Medication PRIMARY KEY (id)
)
GO

-- Creación de la tabla Patient
CREATE TABLE Patient
(
  id           int          NOT NULL IDENTITY(1,1),
  first_name   varchar(30)  NOT NULL,
  last_name    varchar(30)  NOT NULL,
  date_birth   date         NOT NULL,
  gender       varchar(20)  NOT NULL,
  blood_type   varchar(30)  NOT NULL,
  contactEmail varchar(100) NOT NULL,
  CONSTRAINT PK_Patient PRIMARY KEY (id)
)
GO

-- Restricción UNIQUE para el correo del paciente *
ALTER TABLE Patient
  ADD CONSTRAINT UQ_Patient_contactEmail UNIQUE (contactEmail)
GO

-- Creación de la tabla Patient_ClinicalTrial
CREATE TABLE Patient_ClinicalTrial
(
  id               int          NOT NULL IDENTITY(1,1),
  trial_id         int          NOT NULL,
  patient_id       int          NOT NULL,
  status           varchar(100) NOT NULL,
  enrollment_date  date        ,
  CONSTRAINT PK_Patient_ClinicalTrial PRIMARY KEY (id)
)
GO

-- Creación de la tabla ResearchCenter
CREATE TABLE ResearchCenter
(
  id            int          NOT NULL IDENTITY(1,1),
  name          varchar(30)  NOT NULL,
  location      varchar(20)  NOT NULL,
  facility_type varchar(20)  NOT NULL,
  country       varchar(100),
  contactEmail  varchar(100) NOT NULL,
  CONSTRAINT PK_ResearchCenter PRIMARY KEY (id)
)
GO

-- Restricción UNIQUE para el correo del centro de investigación *
ALTER TABLE ResearchCenter
  ADD CONSTRAINT UQ_ResearchCenter_contactEmail UNIQUE (contactEmail)
GO

-- Creación de la tabla Researcher
CREATE TABLE Researcher
(
  id                int          NOT NULL IDENTITY(1,1),
  ResearchCenter_id int          NOT NULL,
  first_name        varchar(30)  NOT NULL,
  last_name         varchar(30)  NOT NULL,
  specialization    varchar(20)  NOT NULL,
  email             varchar(100) NOT NULL,
  role              varchar(50) ,
  CONSTRAINT PK_Researcher PRIMARY KEY (id)
)
GO

-- Restricción UNIQUE para el correo del investigador *
ALTER TABLE Researcher
  ADD CONSTRAINT UQ_Researcher_email UNIQUE (email)
GO

-- Creación de la tabla ResearcherClinicalTrial
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

-- Creación de la tabla Sponsor
CREATE TABLE Sponsor
(
  id           int          NOT NULL IDENTITY(1,1),
  name         varchar(100) NOT NULL,
  contact_info varchar(100),
  org_type     varchar(100),
  country      varchar(100),
  CONSTRAINT PK_Sponsor PRIMARY KEY (id)
)
GO

-- Creación de la tabla TrialMedication
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

-- Creación de la tabla TrialPhase
CREATE TABLE TrialPhase
(
  id           int          NOT NULL IDENTITY(1,1),
  phase_number int          NOT NULL,
  name         varchar(100) NOT NULL,
  objective    varchar(100),
  CONSTRAINT PK_TrialPhase PRIMARY KEY (id)
)
GO

-- CREACIÓN DE LLAVES FORÁNEAS
-- ==============================================================================

-- Relaciones para la tabla ClinicalTrial
ALTER TABLE ClinicalTrial
  ADD CONSTRAINT FK_Sponsor_TO_ClinicalTrial
    FOREIGN KEY (sponsor_id)
    REFERENCES Sponsor (id)
GO

ALTER TABLE ClinicalTrial
  ADD CONSTRAINT FK_TrialPhase_TO_ClinicalTrial
    FOREIGN KEY (TrialPhase_id)
    REFERENCES TrialPhase (id)
GO

-- Relaciones para la tabla Appointment
ALTER TABLE Appointment
  ADD CONSTRAINT FK_Researcher_TO_Appointment
    FOREIGN KEY (researcher_id)
    REFERENCES Researcher (id)
GO

ALTER TABLE Appointment
  ADD CONSTRAINT FK_ResearchCenter_TO_Appointment
    FOREIGN KEY (researchCenter_id)
    REFERENCES ResearchCenter (id)
GO

ALTER TABLE Appointment
  ADD CONSTRAINT FK_Patient_ClinicalTrial_TO_Appointment
    FOREIGN KEY (patientClinicalTrial_id)
    REFERENCES Patient_ClinicalTrial (id)
GO

-- Relaciones para la tabla LabResult	
ALTER TABLE LabResult 
  ADD CONSTRAINT FK_Appointment_TO_LabResult 
    FOREIGN KEY (appointment_id)
    REFERENCES Appointment (id)
GO

-- Relaciones para la tabla Patient_ClinicalTrial
ALTER TABLE Patient_ClinicalTrial
  ADD CONSTRAINT FK_ClinicalTrial_TO_Patient_ClinicalTrial
    FOREIGN KEY (trial_id)
    REFERENCES ClinicalTrial (id)
GO

ALTER TABLE Patient_ClinicalTrial
  ADD CONSTRAINT FK_Patient_TO_Patient_ClinicalTrial
    FOREIGN KEY (patient_id)
    REFERENCES Patient (id)
GO

-- Relaciones para la tabla ResearcherClinicalTrial
ALTER TABLE ResearcherClinicalTrial
  ADD CONSTRAINT FK_Researcher_TO_ResearcherClinicalTrial
    FOREIGN KEY (researcher_id)
    REFERENCES Researcher (id)
GO

ALTER TABLE ResearcherClinicalTrial
  ADD CONSTRAINT FK_ClinicalTrial_TO_ResearcherClinicalTrial
    FOREIGN KEY (clinicalTrial_id)
    REFERENCES ClinicalTrial (id)
GO

-- Relaciones para la tabla TrialMedication
ALTER TABLE TrialMedication
  ADD CONSTRAINT FK_Medication_TO_TrialMedication
    FOREIGN KEY (Medication_id)
    REFERENCES Medication (id)
GO

ALTER TABLE TrialMedication
  ADD CONSTRAINT FK_ClinicalTrial_TO_TrialMedication
    FOREIGN KEY (ClinicalTrial_id)
    REFERENCES ClinicalTrial (id)
GO

-- Relaciones para la tabla Researcher
ALTER TABLE Researcher
  ADD CONSTRAINT FK_ResearchCenter_TO_Researcher
    FOREIGN KEY (ResearchCenter_id)
    REFERENCES ResearchCenter (id)
GO

-- Relaciones para la tabla AdverseEvent
ALTER TABLE AdverseEvent 
  ADD CONSTRAINT FK_Appointment_TO_AdverseEvent 
    FOREIGN KEY (appointment_id)
    REFERENCES Appointment (id)
GO

-- Relaciones para la tabla ConsentForm
ALTER TABLE ConsentForm
  ADD CONSTRAINT FK_Patient_ClinicalTrial_TO_ConsentForm
    FOREIGN KEY (patientClinicalTrial_id)
    REFERENCES Patient_ClinicalTrial (id)
GO

-- Relaciones para la tabla ClinicalTrialCenter
ALTER TABLE ClinicalTrialCenter
  ADD CONSTRAINT FK_ClinicalTrial_TO_ClinicalTrialCenter
    FOREIGN KEY (clinicalTrial_id)
    REFERENCES ClinicalTrial (id)
GO

ALTER TABLE ClinicalTrialCenter
  ADD CONSTRAINT FK_ResearchCenter_TO_ClinicalTrialCenter
    FOREIGN KEY (researchCenter_id)
    REFERENCES ResearchCenter (id)
GO


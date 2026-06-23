# ClinicalHub Database — Modelo de datos

## Descripción general

Este modelo de base de datos gestiona el ciclo completo de ensayos clínicos: desde los patrocinadores y centros de investigación hasta los pacientes, citas, resultados de laboratorio y eventos adversos.

---

## Diagrama de entidades

```
Sponsor ──────────────── ClinicalTrial ──── TrialPhase
                              │
              ┌───────────────┼──────────────────┐
              │               │                  │
    Patient_ClinicalTrial  TrialMedication  ProtocolAmendment
       /           \              │
  Patient      Researcher   Medication
                   │
         ResearcherClinicalTrial
                   │
              Appointment ─── LabResult
                   │
             AdverseEvent
                   │
             ConsentForm
```

---

## Tablas

### `Sponsor`
Organización que financia y patrocina el ensayo clínico.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `name` | varchar(100) | NOT NULL | Nombre del patrocinador |
| `contact_info` | varchar(100) | | Información de contacto |
| `org_type` | varchar(100) | | Tipo de organización |
| `country` | varchar(100) | | País de origen |

---

### `ClinicalTrial`
Ensayo clínico registrado. Cada ensayo tiene un patrocinador, una fase y puede tener múltiples participantes, medicamentos y enmiendas.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `sponsor_id` | int | FK → Sponsor.id | Patrocinador del ensayo |
| `TrialPhase_id` | int | FK → TrialPhase.id | Fase del ensayo |
| `title` | varchar(30) | NOT NULL | Título del ensayo |
| `description` | varchar(100) | | Descripción |
| `status` | varchar(100) | NOT NULL | Estado actual |
| `start_date` | date | | Fecha de inicio |
| `end_date` | date | | Fecha de finalización |

---

### `TrialPhase`
Catálogo de fases clínicas (Fase I, II, III, IV).

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `phase_number` | int | NOT NULL | Número de fase |
| `name` | varchar(100) | NOT NULL | Nombre de la fase |
| `objective` | varchar(100) | | Objetivo de la fase |

---

### `ResearchCenter`
Centro de investigación donde se ejecuta el ensayo.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `name` | varchar(30) | NOT NULL | Nombre del centro |
| `location` | varchar(20) | NOT NULL | Ubicación |
| `facility_type` | varchar(20) | NOT NULL | Tipo de instalación |
| `country` | varchar(100) | | País |
| `contactEmail` | varchar(100) | NOT NULL, UNIQUE | Correo de contacto |

---

### `Researcher`
Investigador o profesional médico que participa en el ensayo.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `ResearchCenter_id` | int | FK → ResearchCenter.id | Centro al que pertenece |
| `first_name` | varchar(30) | NOT NULL | Nombre |
| `last_name` | varchar(30) | NOT NULL | Apellido |
| `specialization` | varchar(20) | NOT NULL | Especialización |
| `email` | varchar(100) | NOT NULL, UNIQUE | Correo electrónico |
| `role` | varchar(50) | | Rol general |

---

### `Patient`
Paciente registrado en el sistema.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `first_name` | varchar(30) | NOT NULL | Nombre |
| `last_name` | varchar(30) | NOT NULL | Apellido |
| `date_birth` | date | NOT NULL | Fecha de nacimiento |
| `gender` | varchar(20) | NOT NULL | Género |
| `blood_type` | varchar(30) | NOT NULL | Tipo de sangre |
| `contactEmail` | varchar(100) | NOT NULL, UNIQUE | Correo de contacto |

---

### `Patient_ClinicalTrial` *(tabla de unión)*
Registra la inscripción de un paciente en un ensayo clínico específico.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `trial_id` | int | FK → ClinicalTrial.id | Ensayo clínico |
| `patient_id` | int | FK → Patient.id | Paciente inscrito |
| `status` | varchar(100) | NOT NULL | Estado de participación |
| `enrollment_date` | date | | Fecha de inscripción |

---

### `ResearcherClinicalTrial` *(tabla de unión)*
Asigna un investigador a un ensayo clínico con un rol específico.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `researcher_id` | int | FK → Researcher.id | Investigador asignado |
| `clinicalTrial_id` | int | FK → ClinicalTrial.id | Ensayo clínico |
| `roleInTrial` | varchar(50) | NOT NULL | Rol en el ensayo |
| `start_date` | date | | Fecha de inicio de asignación |
| `end_date` | date | | Fecha de fin de asignación |

---

### `ClinicalTrialCenter` *(tabla de unión)*
Relaciona un ensayo con los centros de investigación donde se ejecuta.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `clinicalTrial_id` | int | FK → ClinicalTrial.id | Ensayo clínico |
| `researchCenter_id` | int | FK → ResearchCenter.id | Centro de investigación |
| `start_date` | date | | Fecha de inicio |
| `end_date` | date | | Fecha de fin |
| `status` | varchar(100) | NOT NULL | Estado de la relación |

---

### `Appointment`
Visita o cita programada para un paciente dentro de un ensayo.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `patientClinicalTrial_id` | int | FK → Patient_ClinicalTrial.id | Inscripción del paciente |
| `researcher_id` | int | FK → Researcher.id | Investigador responsable |
| `researchCenter_id` | int | FK → ResearchCenter.id | Centro donde se realiza |
| `status` | varchar(100) | NOT NULL | Estado de la cita |
| `visitNumber` | int | NOT NULL | Número de visita |
| `scheduleDate` | datetime | | Fecha programada |
| `attendedDate` | varchar(100) | | Fecha real de asistencia |
| `vital_signs` | varchar(100) | | Signos vitales registrados |
| `clinicalNote` | varchar(500) | | Notas clínicas |

---

### `LabResult`
Resultado de laboratorio vinculado a una cita.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `appointment_id` | int | FK → Appointment.id | Cita asociada |
| `test_type` | varchar(30) | | Tipo de prueba |
| `test_Name` | varchar(30) | | Nombre del test |
| `measured_value` | float | | Valor medido |
| `unit` | varchar(10) | | Unidad de medida |
| `referenceMin` | float | | Valor mínimo de referencia |
| `referenceMax` | float | | Valor máximo de referencia |

---

### `AdverseEvent`
Evento adverso reportado durante el ensayo, vinculado a una cita.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `appointment_id` | int | FK → Appointment.id | Cita donde se detectó |
| `description` | varchar(100) | | Descripción del evento |
| `severity` | int | | Nivel de severidad |
| `onset_date` | date | | Fecha de inicio del evento |

---

### `Medication`
Catálogo de medicamentos disponibles.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `name` | varchar(100) | | Nombre del medicamento |
| `activeIngredient` | varchar(100) | | Ingrediente activo |

---

### `TrialMedication` *(tabla de unión)*
Especifica qué medicamentos se usan en un ensayo y con qué protocolo.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `Medication_id` | int | FK → Medication.id | Medicamento utilizado |
| `ClinicalTrial_id` | int | FK → ClinicalTrial.id | Ensayo clínico |
| `frequency` | varchar(50) | | Frecuencia de administración |
| `dosage` | decimal(10,2) | | Dosis |
| `route` | varchar(50) | | Vía de administración |

---

### `ConsentForm`
Formulario de consentimiento informado del paciente para un ensayo.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `patientClinicalTrial_id` | int | FK → Patient_ClinicalTrial.id | Inscripción del paciente |
| `signedDate` | date | NOT NULL | Fecha de firma |
| `protocolVersion` | varchar(100) | NOT NULL | Versión del protocolo firmado |
| `revokedDate` | date | | Fecha de revocación (si aplica) |

---

### `ProtocolAmendment`
Enmienda o modificación al protocolo de un ensayo.

| Columna | Tipo | Restricción | Descripción |
|---------|------|-------------|-------------|
| `id` | int | PK, NOT NULL, Auto Increment | Identificador único |
| `trial_id` | int | FK → ClinicalTrial.id | Ensayo modificado |
| `amendmentDate` | date | NOT NULL | Fecha de la enmienda |
| `version` | varchar(20) | NOT NULL | Versión del protocolo |
| `description` | varchar(500) | | Descripción del cambio |
| `reason` | varchar(500) | | Motivo de la enmienda |

---

## Relaciones

| Relación | Tipo | Descripción |
|----------|------|-------------|
| Sponsor → ClinicalTrial | 1 : N | Un patrocinador puede financiar varios ensayos |
| TrialPhase → ClinicalTrial | 1 : N | Una fase puede aplicar a varios ensayos |
| ClinicalTrial → Patient_ClinicalTrial | 1 : N | Un ensayo puede tener múltiples pacientes inscritos |
| Patient → Patient_ClinicalTrial | 1 : N | Un paciente puede inscribirse en varios ensayos |
| ClinicalTrial → ResearcherClinicalTrial | 1 : N | Un ensayo puede tener varios investigadores |
| Researcher → ResearcherClinicalTrial | 1 : N | Un investigador puede participar en varios ensayos |
| ClinicalTrial → ClinicalTrialCenter | 1 : N | Un ensayo puede ejecutarse en varios centros |
| ResearchCenter → ClinicalTrialCenter | 1 : N | Un centro puede albergar varios ensayos |
| ResearchCenter → Researcher | 1 : N | Un centro puede tener varios investigadores |
| Patient_ClinicalTrial → Appointment | 1 : N | Una inscripción genera múltiples citas |
| Researcher → Appointment | 1 : N | Un investigador puede atender múltiples citas |
| ResearchCenter → Appointment | 1 : N | Un centro puede tener múltiples citas |
| Appointment → LabResult | 1 : N | Una cita puede generar varios resultados de laboratorio |
| Appointment → AdverseEvent | 1 : N | Una cita puede reportar varios eventos adversos |
| Patient_ClinicalTrial → ConsentForm | 1 : N | Una inscripción puede tener varios formularios de consentimiento |
| ClinicalTrial → TrialMedication | 1 : N | Un ensayo puede usar varios medicamentos |
| Medication → TrialMedication | 1 : N | Un medicamento puede usarse en varios ensayos |
| ClinicalTrial → ProtocolAmendment | 1 : N | Un ensayo puede tener múltiples enmiendas |

---

## Flujo general del sistema

```
1. Sponsor registra un ClinicalTrial
2. ClinicalTrial se asigna a una TrialPhase y a centros (ClinicalTrialCenter)
3. Investigators (Researcher) se asignan al ensayo (ResearcherClinicalTrial)
4. Medications se vinculan al ensayo (TrialMedication)
5. Patient se inscribe → Patient_ClinicalTrial → ConsentForm firmado
6. Se crean Appointments para cada visita
7. En cada Appointment se registran:
   - LabResult (resultados de laboratorio)
   - AdverseEvent (eventos adversos)
8. ProtocolAmendment registra cambios al protocolo del ensayo
```

// ClinicalHub - Datos de prueba MongoDB (patrones: Referencing, Embedded, Subset)

use ClinicalHub;

// ResearchCenter — colección destino del Patrón de Referencias

db.ResearchCenter.insertMany([
  { _id: ObjectId("6a46b8b575cc1762fccd1dd4"), name: "Instituto Nacional de Salud",         location: "Lima, Peru",       facility_type: "Instituto" },
  { _id: ObjectId("6a46b8b575cc1762fccd1dd5"), name: "Hospital Nacional Cayetano Heredia",  location: "Lima, Peru",       facility_type: "Hospital" },
  { _id: ObjectId("6a46b8b575cc1762fccd1dd6"), name: "Mayo Clinic",                         location: "Rochester, USA",   facility_type: "Hospital" },
  { _id: ObjectId("6a46b8b575cc1762fccd1dd7"), name: "Cleveland Clinic",                    location: "Cleveland, USA",   facility_type: "Hospital" }
]);

// Researcher — Patrón de Referencias hacia ResearchCenter (research_center_id)

db.Researcher.insertMany([
  { _id: ObjectId("6a46b6ea75cc1762fccd1dca"), first_name: "Andrea",  last_name: "Salazar",  specialization: "Cardiologia",              research_center_id: ObjectId("6a46b8b575cc1762fccd1dd4") },
  { _id: ObjectId("6a46b6ea75cc1762fccd1dcb"), first_name: "Carlos",  last_name: "Ramirez",  specialization: "Cardiologia",              research_center_id: ObjectId("6a46b8b575cc1762fccd1dd5") },
  { _id: ObjectId("6a46b6ea75cc1762fccd1dcc"), first_name: "Maria",   last_name: "Fernandez",specialization: "Endocrinologia",           research_center_id: ObjectId("6a46b8b575cc1762fccd1dd5") },
  { _id: ObjectId("6a46b6ea75cc1762fccd1dcd"), first_name: "John",    last_name: "Smith",    specialization: "Cardiologia",              research_center_id: ObjectId("6a46b8b575cc1762fccd1dd6") },
  { _id: ObjectId("6a46b6ea75cc1762fccd1dce"), first_name: "Michael", last_name: "Brown",    specialization: "Inmunologia",              research_center_id: ObjectId("6a46b8b575cc1762fccd1dd7") },
  { _id: ObjectId("6a46b6ea75cc1762fccd1dcf"), first_name: "Sarah",   last_name: "Davis",    specialization: "Enfermedades Infecciosas", research_center_id: ObjectId("6a46b8b575cc1762fccd1dd7") }
]);

// ClinicalTrial — Patrón de Subconjunto (recent_enrolled_patients + total_patients_count)

db.ClinicalTrial.insertMany([
  {
    _id: ObjectId("6a46b3d275cc1762fccd1dc5"),
    title: "Evaluacion de Vacuna contra Influenza",
    status: "Activo",
    description: "Ensayo clinico para evaluar la eficacia de una nueva vacuna estacional",
    start_date: ISODate("2026-07-01T00:00:00Z"),
    // Subconjunto: solo los pacientes reclutados mas recientemente
    recent_enrolled_patients: [
      { patient_id: ObjectId("6a46ae1975cc1762fccd1dbe"), first_name: "Juan",  enrolled_date: ISODate("2026-07-01T10:00:00Z") },
      { patient_id: ObjectId("6a46ae1975cc1762fccd1dbf"), first_name: "Maria", enrolled_date: ISODate("2026-07-09T11:30:00Z") }
    ],
    total_patients_count: 1540
  },
  {
    _id: ObjectId("6a46b3d275cc1762fccd1dc6"),
    title: "Terapia con Empagliflozina en Diabetes Tipo 2",
    status: "Activo",
    description: "Ensayo aleatorizado controlado que evalua el control glucemico",
    start_date: ISODate("2025-01-15T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("6a46ae1975cc1762fccd1dc0"), first_name: "Ana",  enrolled_date: ISODate("2025-01-20T00:00:00Z") },
      { patient_id: ObjectId("6a46ae1975cc1762fccd1dc1"), first_name: "Luis", enrolled_date: ISODate("2025-01-22T00:00:00Z") }
    ],
    total_patients_count: 320
  },
  {
    _id: ObjectId("6a46b3d275cc1762fccd1dc7"),
    title: "Seguridad a Largo Plazo de Adalimumab en Artritis Reumatoide",
    status: "Reclutando",
    description: "Estudio multicentrico de seguimiento de seguridad",
    start_date: ISODate("2025-06-01T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("6a46ae1975cc1762fccd1dc2"), first_name: "Rosa",   enrolled_date: ISODate("2025-06-10T00:00:00Z") },
      { patient_id: ObjectId("6a46ae1975cc1762fccd1dc3"), first_name: "Miguel", enrolled_date: ISODate("2025-06-12T00:00:00Z") }
    ],
    total_patients_count: 12
  },
  {
    _id: ObjectId("6a46b3d275cc1762fccd1dc8"),
    title: "Remdesivir en Pacientes COVID-19 Hospitalizados",
    status: "Completado",
    description: "Estudio de resultados de tratamiento antiviral",
    start_date: ISODate("2023-03-01T00:00:00Z"),
    end_date: ISODate("2024-01-15T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("6a46ae1975cc1762fccd1dc4"), first_name: "Emily", enrolled_date: ISODate("2023-03-05T00:00:00Z") },
      { patient_id: ObjectId("6a46ae1975cc1762fccd1dc5"), first_name: "David", enrolled_date: ISODate("2023-03-10T00:00:00Z") }
    ],
    total_patients_count: 890
  }
]);

// Patient — Patrón Embebido (active_clinical_trials: solo referencia + datos propios
// de la inscripcion, sin clonar title/status del ensayo)

db.Patient.insertMany([
  {
    _id: ObjectId("6a46ae1975cc1762fccd1dbe"),
    first_name: "Juan", last_name: "Perez", blood_type: "O+",
    active_clinical_trials: [
      { trial_id: ObjectId("6a46b3d275cc1762fccd1dc5"), enrollment_status: "Enrolled", enrollment_date: ISODate("2026-07-01T10:00:00Z") }
    ]
  },
  {
    _id: ObjectId("6a46ae1975cc1762fccd1dbf"),
    first_name: "Maria", last_name: "Lopez", blood_type: "A+",
    active_clinical_trials: [
      { trial_id: ObjectId("6a46b3d275cc1762fccd1dc5"), enrollment_status: "Enrolled", enrollment_date: ISODate("2026-07-09T11:30:00Z") }
    ]
  },
  {
    _id: ObjectId("6a46ae1975cc1762fccd1dc0"),
    first_name: "Ana", last_name: "Torres", blood_type: "O+",
    active_clinical_trials: [
      { trial_id: ObjectId("6a46b3d275cc1762fccd1dc6"), enrollment_status: "Active", enrollment_date: ISODate("2025-01-20T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("6a46ae1975cc1762fccd1dc1"),
    first_name: "Luis", last_name: "Gonzales", blood_type: "A+",
    active_clinical_trials: [
      { trial_id: ObjectId("6a46b3d275cc1762fccd1dc6"), enrollment_status: "Active", enrollment_date: ISODate("2025-01-22T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("6a46ae1975cc1762fccd1dc2"),
    first_name: "Rosa", last_name: "Diaz", blood_type: "B-",
    active_clinical_trials: [
      { trial_id: ObjectId("6a46b3d275cc1762fccd1dc7"), enrollment_status: "Screening", enrollment_date: ISODate("2025-06-10T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("6a46ae1975cc1762fccd1dc3"),
    first_name: "Miguel", last_name: "Castro", blood_type: "O+",
    active_clinical_trials: [
      { trial_id: ObjectId("6a46b3d275cc1762fccd1dc7"), enrollment_status: "Screening", enrollment_date: ISODate("2025-06-12T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("6a46ae1975cc1762fccd1dc4"),
    first_name: "Emily", last_name: "Clark", blood_type: "O+",
    active_clinical_trials: [
      { trial_id: ObjectId("6a46b3d275cc1762fccd1dc8"), enrollment_status: "Completed", enrollment_date: ISODate("2023-03-05T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("6a46ae1975cc1762fccd1dc5"),
    first_name: "David", last_name: "Lee", blood_type: "B+",
    active_clinical_trials: [
      { trial_id: ObjectId("6a46b3d275cc1762fccd1dc8"), enrollment_status: "Completed", enrollment_date: ISODate("2023-03-10T00:00:00Z") }
    ]
  }
]);
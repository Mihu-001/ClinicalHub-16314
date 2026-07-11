// Miguel
// Pacientes inscritos después de una fecha específica
db.patient.find(
  { "active_clinical_trials.enrollment_date": { $gte: ISODate("2025-06-01T00:00:00Z") } },
  { first_name: 1, last_name: 1, active_clinical_trials: 1 }
)
// Estados de inscripción distintos que existen en los ensayos activos de los pacientes
db.patient.distinct("active_clinical_trials.enrollment_status")

// Drago
// Ensayos activos con más de 300 pacientes totales
db.ClinicalTrial.find(
  { status: "Activo", total_patients_count: { $gt: 300 } },
  { title: 1, status: 1, total_patients_count: 1 }
)
// Todos los estados distintos que existen en la colección de ensayos
db.ClinicalTrial.distinct("status")

// Sebastian
// Investigadores de un centro específico
db.researcher.find(
  { research_center_id: ObjectId("REEMPLAZAR_CON_ID") },
  { first_name: 1, last_name: 1, specialization: 1, research_center_id: 1 }
)
// Especializaciones distintas registradas entre todos los investigadores
db.researcher.distinct("specialization")

// Yamil
// Pacientes con estado de inscripción "Withdrawn"
db.patient.find(
  { "active_clinical_trials.enrollment_status": "Withdrawn" },
  { first_name: 1, last_name: 1, active_clinical_trials: 1 }
)
// Primer paciente encontrado con estado "Withdrawn" (un solo registro)
db.patient.findOne(
  { "active_clinical_trials.enrollment_status": "Withdrawn" },
  { first_name: 1, last_name: 1 }
)

// Denis
// Ensayos que aún no han reclutado pacientes
db.ClinicalTrial.find(
  { recent_enrolled_patients: { $size: 0 } },
  { title: 1, status: 1 }
)
// Cantidad de ensayos que aún no han reclutado pacientes
db.ClinicalTrial.countDocuments(
  { recent_enrolled_patients: { $size: 0 } }
)
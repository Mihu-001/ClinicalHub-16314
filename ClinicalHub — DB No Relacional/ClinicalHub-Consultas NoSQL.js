// Miguel
// Pacientes inscritos después de una fecha específica
db.patient.find(
  { "active_clinical_trials.enrollment_date": { $gte: ISODate("2025-06-01T00:00:00Z") } },
  { first_name: 1, last_name: 1, active_clinical_trials: 1 }
)
// Cantidad de ensayos activos por paciente
db.patient.aggregate([
  { $project: { first_name: 1, last_name: 1, trial_count: { $size: "$active_clinical_trials" } } },
  { $sort: { trial_count: -1 } }
])

// Drago
// Ensayos activos con más de 300 pacientes totales
db.ClinicalTrial.find(
  { status: "Activo", total_patients_count: { $gt: 300 } },
  { title: 1, status: 1, total_patients_count: 1 }
)
// Cantidad de ensayos agrupados por estado
db.ClinicalTrial.aggregate([
  { $group: { _id: "$status", total: { $sum: 1 } } },
  { $sort: { total: -1 } }
])

//Sebastian
// Cantidad de investigadores por centro
db.researcher.aggregate([
  { $group: { _id: "$research_center_id", total: { $sum: 1 } } }
])
// Investigadores con el nombre de su centro (lookup)
db.researcher.aggregate([
  { $lookup: { from: "researchCenter", localField: "research_center_id", foreignField: "_id", as: "center_info" } },
  { $unwind: "$center_info" },
  { $project: { first_name: 1, last_name: 1, specialization: 1, "center_info.name": 1 } }
])

// Yamil
// Pacientes con estado de inscripción "Withdrawn"
db.patient.find(
  { "active_clinical_trials.enrollment_status": "Withdrawn" },
  { first_name: 1, last_name: 1, active_clinical_trials: 1 }
)
// Cantidad de pacientes agrupados por estado de inscripción
db.patient.aggregate([
  { $unwind: "$active_clinical_trials" },
  { $group: { _id: "$active_clinical_trials.enrollment_status", total: { $sum: 1 } } }
])

// Denis
// Ensayos que aún no han reclutado pacientes
db.ClinicalTrial.find(
  { recent_enrolled_patients: { $size: 0 } },
  { title: 1, status: 1 }
)
//Total de pacientes acumulados por estado de ensayo
db.ClinicalTrial.aggregate([
  { $group: { _id: "$status", total_patients: { $sum: "$total_patients_count" } } },
  { $sort: { total_patients: -1 } }
])
// ClinicalHub - Datos de prueba MongoDB (esquema con validacion $jsonSchema)

use ClinicalHub;

// researchCenter
db.researchCenter.insertMany([
  { _id: ObjectId("650000000000000000000301"), name: "Hospital Nacional Cayetano Heredia", location: "Lima, Peru", facility_type: "Hospital", contactEmail: "contacto@cayetano.pe" },
  { _id: ObjectId("650000000000000000000302"), name: "Instituto Nacional de Salud", location: "Lima, Peru", facility_type: "Instituto", contactEmail: "contacto@ins.gob.pe" },
  { _id: ObjectId("650000000000000000000303"), name: "Clinica Ricardo Palma", location: "Lima, Peru", facility_type: "Clinic", contactEmail: "contacto@ricardopalma.pe" },
  { _id: ObjectId("650000000000000000000304"), name: "Mayo Clinic", location: "Rochester MN, USA", facility_type: "Hospital", contactEmail: "info@mayoclinic.org" },
  { _id: ObjectId("650000000000000000000305"), name: "Cleveland Clinic", location: "Cleveland OH, USA", facility_type: "Hospital", contactEmail: "info@clevelandclinic.org" },
  { _id: ObjectId("650000000000000000000306"), name: "Hospital Clinic de Barcelona", location: "Barcelona, Spain", facility_type: "Hospital", contactEmail: "info@hospitalclinic.cat" },
  { _id: ObjectId("650000000000000000000307"), name: "Instituto Nacional de Cancerologia", location: "Bogota, Colombia", facility_type: "Research Institute", contactEmail: "info@incancerologia.co" },
  { _id: ObjectId("650000000000000000000308"), name: "Charite Universitaetsmedizin", location: "Berlin, Germany", facility_type: "University Hospital", contactEmail: "info@charite.de" },
  { _id: ObjectId("650000000000000000000309"), name: "Hospital Italiano", location: "Buenos Aires, Argentina", facility_type: "Hospital", contactEmail: "info@hospitalitaliano.org.ar" },
  { _id: ObjectId("65000000000000000000030a"), name: "Johns Hopkins Hospital", location: "Baltimore MD, USA", facility_type: "Hospital", contactEmail: "info@jhmi.edu" }
]);

// researcher Patron References -> researchCenter
db.researcher.insertMany([
  { _id: ObjectId("650000000000000000000401"), first_name: "Carlos", last_name: "Ramirez", specialization: "Cardiology", research_center_id: ObjectId("650000000000000000000301"), email: "carlos.ramirez@cayetano.pe", role: "Principal Investigator" },
  { _id: ObjectId("650000000000000000000402"), first_name: "Maria", last_name: "Fernandez", specialization: "Endocrinology", research_center_id: ObjectId("650000000000000000000301"), email: "maria.fernandez@cayetano.pe", role: "Sub-Investigator" },
  { _id: ObjectId("650000000000000000000403"), first_name: "Andrea", last_name: "Salazar", specialization: "Cardiology", research_center_id: ObjectId("650000000000000000000302"), email: "andrea.salazar@ins.gob.pe", role: "Principal Investigator" },
  { _id: ObjectId("650000000000000000000404"), first_name: "Jorge", last_name: "Salinas", specialization: "Oncology", research_center_id: ObjectId("650000000000000000000303"), email: "jorge.salinas@ricardopalma.pe", role: "Principal Investigator" },
  { _id: ObjectId("650000000000000000000405"), first_name: "John", last_name: "Smith", specialization: "Cardiology", research_center_id: ObjectId("650000000000000000000304"), email: "john.smith@mayoclinic.org", role: "Principal Investigator" },
  { _id: ObjectId("650000000000000000000406"), first_name: "Emily", last_name: "Johnson", specialization: "Oncology", research_center_id: ObjectId("650000000000000000000304"), email: "emily.johnson@mayoclinic.org", role: "Sub-Investigator" },
  { _id: ObjectId("650000000000000000000407"), first_name: "Michael", last_name: "Brown", specialization: "Immunology", research_center_id: ObjectId("650000000000000000000305"), email: "michael.brown@ccf.org", role: "Principal Investigator" },
  { _id: ObjectId("650000000000000000000408"), first_name: "Sarah", last_name: "Davis", specialization: "Infectious Disease", research_center_id: ObjectId("650000000000000000000305"), email: "sarah.davis@ccf.org", role: "Coordinator" },
  { _id: ObjectId("650000000000000000000409"), first_name: "Marc", last_name: "Alonso", specialization: "Endocrinology", research_center_id: ObjectId("650000000000000000000306"), email: "marc.alonso@hospitalclinic.cat", role: "Principal Investigator" },
  { _id: ObjectId("65000000000000000000040a"), first_name: "Hans", last_name: "Muller", specialization: "Infectious Disease", research_center_id: ObjectId("650000000000000000000308"), email: "hans.muller@charite.de", role: "Principal Investigator" }
]);

// ClinicalTrial - Patron Subset (recent_enrolled_patients + total_patients_count)

db.ClinicalTrial.insertMany([
  {
    _id: ObjectId("650000000000000000000501"),
    title: "Evaluacion de Vacuna contra Influenza",
    status: "Activo",
    description: "Ensayo clinico para evaluar la eficacia de una nueva vacuna estacional",
    start_date: ISODate("2026-07-01T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("650000000000000000000601"), first_name: "Juan", enrolled_date: ISODate("2026-07-01T10:00:00Z") },
      { patient_id: ObjectId("650000000000000000000602"), first_name: "Maria", enrolled_date: ISODate("2026-07-09T11:30:00Z") }
    ],
    total_patients_count: NumberInt(1540)
  },
  {
    _id: ObjectId("650000000000000000000502"),
    title: "Terapia con Empagliflozina en Diabetes Tipo 2",
    status: "Activo",
    description: "Ensayo aleatorizado controlado que evalua el control glucemico",
    start_date: ISODate("2025-01-15T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("650000000000000000000603"), first_name: "Ana", enrolled_date: ISODate("2025-01-20T00:00:00Z") },
      { patient_id: ObjectId("650000000000000000000604"), first_name: "Luis", enrolled_date: ISODate("2025-01-22T00:00:00Z") }
    ],
    total_patients_count: NumberInt(320)
  },
  {
    _id: ObjectId("650000000000000000000503"),
    title: "Seguridad a Largo Plazo de Adalimumab en Artritis Reumatoide",
    status: "Reclutando",
    description: "Estudio multicentrico de seguimiento de seguridad",
    start_date: ISODate("2025-06-01T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("650000000000000000000605"), first_name: "Rosa", enrolled_date: ISODate("2025-06-10T00:00:00Z") },
      { patient_id: ObjectId("650000000000000000000606"), first_name: "Miguel", enrolled_date: ISODate("2025-06-12T00:00:00Z") }
    ],
    total_patients_count: NumberInt(12)
  },
  {
    _id: ObjectId("650000000000000000000504"),
    title: "Remdesivir en Pacientes COVID-19 Hospitalizados",
    status: "Completado",
    description: "Estudio de resultados de tratamiento antiviral",
    start_date: ISODate("2023-03-01T00:00:00Z"),
    end_date: ISODate("2024-01-15T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("650000000000000000000607"), first_name: "Emily", enrolled_date: ISODate("2023-03-05T00:00:00Z") },
      { patient_id: ObjectId("650000000000000000000608"), first_name: "David", enrolled_date: ISODate("2023-03-10T00:00:00Z") }
    ],
    total_patients_count: NumberInt(890)
  },
  {
    _id: ObjectId("650000000000000000000505"),
    title: "Pembrolizumab en Cancer de Pulmon Avanzado",
    status: "Activo",
    description: "Inmunoterapia en cancer de pulmon de celulas no pequenas estadio IV",
    start_date: ISODate("2024-09-10T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("650000000000000000000609"), first_name: "Patricia", enrolled_date: ISODate("2024-09-15T00:00:00Z") },
      { patient_id: ObjectId("65000000000000000000060a"), first_name: "Ricardo", enrolled_date: ISODate("2024-09-20T00:00:00Z") }
    ],
    total_patients_count: NumberInt(450)
  },
  {
    _id: ObjectId("650000000000000000000506"),
    title: "Vigilancia Post-Comercializacion de Atorvastatina",
    status: "Activo",
    description: "Monitoreo de resultados cardiovasculares a largo plazo",
    start_date: ISODate("2025-02-01T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("65000000000000000000060b"), first_name: "Isabel", enrolled_date: ISODate("2025-02-05T00:00:00Z") },
      { patient_id: ObjectId("65000000000000000000060c"), first_name: "Fernando", enrolled_date: ISODate("2025-02-10T00:00:00Z") }
    ],
    total_patients_count: NumberInt(610)
  },
  {
    _id: ObjectId("650000000000000000000507"),
    title: "Estudio de Dosis de Insulina Glargina",
    status: "Reclutando",
    description: "Estudio de escalamiento de dosis fase I",
    start_date: ISODate("2026-01-10T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("65000000000000000000060d"), first_name: "Gabriela", enrolled_date: ISODate("2026-01-15T00:00:00Z") },
      { patient_id: ObjectId("65000000000000000000060e"), first_name: "John", enrolled_date: ISODate("2026-01-20T00:00:00Z") }
    ],
    total_patients_count: NumberInt(8)
  },
  {
    _id: ObjectId("650000000000000000000508"),
    title: "Losartan vs Placebo en Hipertension",
    status: "Suspendido",
    description: "Ensayo comparativo de eficacia antihipertensiva",
    start_date: ISODate("2024-05-01T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("65000000000000000000060f"), first_name: "Sophia", enrolled_date: ISODate("2024-05-05T00:00:00Z") },
      { patient_id: ObjectId("650000000000000000000610"), first_name: "James", enrolled_date: ISODate("2024-05-10T00:00:00Z") }
    ],
    total_patients_count: NumberInt(45)
  },
  {
    _id: ObjectId("650000000000000000000509"),
    title: "Sertralina para Depresion en Pacientes Oncologicos",
    status: "Planificado",
    description: "Estudio de eficacia de antidepresivo en pacientes de oncologia",
    recent_enrolled_patients: [],
    total_patients_count: NumberInt(0)
  },
  {
    _id: ObjectId("65000000000000000000050a"),
    title: "Terapia Genica para Fibrosis Quistica",
    status: "Activo",
    description: "Estudio de terapia genica dirigida en fibrosis quistica",
    start_date: ISODate("2025-11-01T00:00:00Z"),
    recent_enrolled_patients: [
      { patient_id: ObjectId("650000000000000000000611"), first_name: "Laura", enrolled_date: ISODate("2025-11-05T00:00:00Z") },
      { patient_id: ObjectId("650000000000000000000612"), first_name: "Thomas", enrolled_date: ISODate("2025-11-10T00:00:00Z") }
    ],
    total_patients_count: NumberInt(27)
  }
]);

// patient - Patron Embedded (active_clinical_trials)
db.patient.insertMany([
  {
    _id: ObjectId("650000000000000000000601"),
    first_name: "Juan",
    last_name: "Perez",
    gender: "Male",
    date_birth: ISODate("1996-04-18T00:00:00Z"),
    blood_type: "O+",
    contactEmail: "juan.perez@clinicalhub.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000501"), enrollment_status: "Enrolled", enrollment_date: ISODate("2026-07-01T10:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000602"),
    first_name: "Maria",
    last_name: "Lopez",
    gender: "Female",
    date_birth: ISODate("1994-08-22T00:00:00Z"),
    blood_type: "A+",
    contactEmail: "maria.lopez@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000501"), enrollment_status: "Enrolled", enrollment_date: ISODate("2026-07-09T11:30:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000603"),
    first_name: "Ana",
    last_name: "Torres",
    gender: "Female",
    date_birth: ISODate("1985-03-12T00:00:00Z"),
    blood_type: "O+",
    contactEmail: "ana.torres@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000502"), enrollment_status: "Active", enrollment_date: ISODate("2025-01-20T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000604"),
    first_name: "Luis",
    last_name: "Gonzales",
    gender: "Male",
    date_birth: ISODate("1978-07-22T00:00:00Z"),
    blood_type: "A+",
    contactEmail: "luis.gonzales@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000502"), enrollment_status: "Active", enrollment_date: ISODate("2025-01-22T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000605"),
    first_name: "Rosa",
    last_name: "Diaz",
    gender: "Female",
    date_birth: ISODate("1995-12-01T00:00:00Z"),
    blood_type: "B-",
    contactEmail: "rosa.diaz@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000503"), enrollment_status: "Screening", enrollment_date: ISODate("2025-06-10T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000606"),
    first_name: "Miguel",
    last_name: "Castro",
    gender: "Male",
    date_birth: ISODate("1988-04-25T00:00:00Z"),
    blood_type: "O+",
    contactEmail: "miguel.castro@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000503"), enrollment_status: "Screening", enrollment_date: ISODate("2025-06-12T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000607"),
    first_name: "Emily",
    last_name: "Clark",
    gender: "Female",
    date_birth: ISODate("1987-09-22T00:00:00Z"),
    blood_type: "O+",
    contactEmail: "emily.clark@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000504"), enrollment_status: "Completed", enrollment_date: ISODate("2023-03-05T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000608"),
    first_name: "David",
    last_name: "Lee",
    gender: "Male",
    date_birth: ISODate("1973-12-03T00:00:00Z"),
    blood_type: "B+",
    contactEmail: "david.lee@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000504"), enrollment_status: "Completed", enrollment_date: ISODate("2023-03-10T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000609"),
    first_name: "Patricia",
    last_name: "Mora",
    gender: "Female",
    date_birth: ISODate("1992-06-30T00:00:00Z"),
    blood_type: "O+",
    contactEmail: "patricia.mora@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000505"), enrollment_status: "Active", enrollment_date: ISODate("2024-09-15T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("65000000000000000000060a"),
    first_name: "Ricardo",
    last_name: "Silva",
    gender: "Male",
    date_birth: ISODate("1983-10-11T00:00:00Z"),
    blood_type: "B+",
    contactEmail: "ricardo.silva@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000505"), enrollment_status: "Active", enrollment_date: ISODate("2024-09-20T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("65000000000000000000060b"),
    first_name: "Isabel",
    last_name: "Nunez",
    gender: "Female",
    date_birth: ISODate("1977-03-27T00:00:00Z"),
    blood_type: "A+",
    contactEmail: "isabel.nunez@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000506"), enrollment_status: "Active", enrollment_date: ISODate("2025-02-05T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("65000000000000000000060c"),
    first_name: "Fernando",
    last_name: "Ortiz",
    gender: "Male",
    date_birth: ISODate("1968-11-19T00:00:00Z"),
    blood_type: "O-",
    contactEmail: "fernando.ortiz@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000506"), enrollment_status: "Active", enrollment_date: ISODate("2025-02-10T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("65000000000000000000060d"),
    first_name: "Gabriela",
    last_name: "Paredes",
    gender: "Female",
    date_birth: ISODate("1991-01-08T00:00:00Z"),
    blood_type: "AB+",
    contactEmail: "gabriela.paredes@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000507"), enrollment_status: "Screening", enrollment_date: ISODate("2026-01-15T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("65000000000000000000060e"),
    first_name: "John",
    last_name: "Anderson",
    gender: "Male",
    date_birth: ISODate("1980-06-15T00:00:00Z"),
    blood_type: "A+",
    contactEmail: "john.anderson@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000507"), enrollment_status: "Screening", enrollment_date: ISODate("2026-01-20T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("65000000000000000000060f"),
    first_name: "Sophia",
    last_name: "Turner",
    gender: "Female",
    date_birth: ISODate("1994-04-17T00:00:00Z"),
    blood_type: "A-",
    contactEmail: "sophia.turner@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000508"), enrollment_status: "Withdrawn", enrollment_date: ISODate("2024-05-05T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000610"),
    first_name: "James",
    last_name: "Walker",
    gender: "Male",
    date_birth: ISODate("1966-08-29T00:00:00Z"),
    blood_type: "O+",
    contactEmail: "james.walker@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("650000000000000000000508"), enrollment_status: "Withdrawn", enrollment_date: ISODate("2024-05-10T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000611"),
    first_name: "Laura",
    last_name: "Martin",
    gender: "Female",
    date_birth: ISODate("1989-02-14T00:00:00Z"),
    blood_type: "AB-",
    contactEmail: "laura.martin@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("65000000000000000000050a"), enrollment_status: "Active", enrollment_date: ISODate("2025-11-05T00:00:00Z") }
    ]
  },
  {
    _id: ObjectId("650000000000000000000612"),
    first_name: "Thomas",
    last_name: "Hall",
    gender: "Male",
    date_birth: ISODate("1979-10-05T00:00:00Z"),
    blood_type: "B-",
    contactEmail: "thomas.hall@mail.com",
    active_clinical_trials: [
      { trial_id: ObjectId("65000000000000000000050a"), enrollment_status: "Active", enrollment_date: ISODate("2025-11-10T00:00:00Z") }
    ]
  }
]);

db.researcher.createIndex({ email: 1 }, { unique: true });
db.researchCenter.createIndex({ contactEmail: 1 }, { unique: true });
db.patient.createIndex({ contactEmail: 1 }, { unique: true });
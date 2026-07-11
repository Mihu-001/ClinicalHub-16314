use ClinicalHub;

db.createCollection("ClinicalTrial", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "ClinicalTrial",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "title": {
                    "bsonType": "string"
                },
                "status": {
                    "bsonType": "string"
                },
                "end_date": {
                    "bsonType": "date"
                },
                "start_date": {
                    "bsonType": "date"
                },
                "description": {
                    "bsonType": "string"
                },
                "recent_enrolled_patients": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "patient_id": {
                                "bsonType": "objectId"
                            },
                            "first_name": {
                                "bsonType": "string"
                            },
                            "enrolled_date": {
                                "bsonType": "date"
                            }
                        },
                        "additionalProperties": false,
                        "required": [
                            "first_name"
                        ]
                    }
                },
                "total_patients_count": {
                    "bsonType": "int"
                }
            },
            "additionalProperties": false,
            "required": [
                "title",
                "status",
                "recent_enrolled_patients",
                "total_patients_count"
            ]
        }
    },
    "validationLevel": "strict"
});




db.createCollection("patient", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "patient",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "first_name": {
                    "bsonType": "string"
                },
                "last_name": {
                    "bsonType": "string"
                },
                "gender": {
                    "bsonType": "string"
                },
                "date_birth": {
                    "bsonType": "date"
                },
                "blood_type": {
                    "bsonType": "string"
                },
                "active_clinical_trials": {
                    "bsonType": "array",
                    "additionalItems": true,
                    "items": {
                        "bsonType": "object",
                        "properties": {
                            "trial_id": {
                                "bsonType": "objectId"
                            },
                            "enrollment_status": {
                                "bsonType": "string"
                            },
                            "enrollment_date": {
                                "bsonType": "date"
                            }
                        },
                        "additionalProperties": false,
                        "required": [
                            "enrollment_status"
                        ]
                    }
                },
                "contactEmail": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false,
            "required": [
                "first_name",
                "last_name",
                "gender",
                "date_birth",
                "blood_type",
                "active_clinical_trials",
                "contactEmail"
            ]
        }
    },
    "validationLevel": "strict",
    "validationAction": "error"
});




db.createCollection("researcher", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "researcher",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "first_name": {
                    "bsonType": "string"
                },
                "last_name": {
                    "bsonType": "string"
                },
                "specialization": {
                    "bsonType": "string"
                },
                "research_center_id": {
                    "bsonType": "objectId"
                },
                "email": {
                    "bsonType": "string"
                },
                "role": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false,
            "required": [
                "first_name",
                "last_name",
                "specialization",
                "research_center_id",
                "email"
            ]
        }
    },
    "validationLevel": "strict"
});




db.createCollection("researchCenter", {
    "capped": false,
    "validator": {
        "$jsonSchema": {
            "bsonType": "object",
            "title": "researchCenter",
            "properties": {
                "_id": {
                    "bsonType": "objectId"
                },
                "name": {
                    "bsonType": "string"
                },
                "location": {
                    "bsonType": "string"
                },
                "facility_type": {
                    "bsonType": "string"
                },
                "contactEmail": {
                    "bsonType": "string"
                }
            },
            "additionalProperties": false,
            "required": [
                "name",
                "location",
                "facility_type",
                "contactEmail"
            ]
        }
    },
    "validationLevel": "strict",
    "validationAction": "error"
});
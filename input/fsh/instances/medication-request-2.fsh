Instance: medication-request-2
InstanceOf: NcrEhrMedicationAgreement
Usage: #inline
* status = #completed
* intent = #order
* medicationReference.reference = "https://fhir.example.org/Medication/medication-2"
* reasonReference.reference = "https://fhir.example.org/Condition/encounter-diagnosis-2"
* subject.reference = "https://fhir.example.org/Patient/patient-2"
Instance: medication-request-1
InstanceOf: MpMedicationAgreement
Usage: #inline
* status = #completed
* intent = #order
* medicationReference.reference = "https://fhir.example.org/Medication/medication-1"
* reasonReference.reference = "https://fhir.example.org/Condition/encounter-diagnosis-2"
* subject.reference = "https://fhir.example.org/Patient/patient-2"
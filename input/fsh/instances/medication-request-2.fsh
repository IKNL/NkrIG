Instance: medication-request-2
InstanceOf: NcrEhrMedicationAgreement
Usage: #inline
* status = #completed
* intent = #order
* medicationReference = Reference(https://fhir.example.org/Medication/medication-2)
* reasonReference = Reference(https://fhir.example.org/Condition/encounter-diagnosis-2)
* subject = Reference(https://fhir.example.org/Patient/patient-2)
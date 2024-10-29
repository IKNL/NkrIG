Instance: medication-request-2
InstanceOf: NcrEhrMedicationAgreement
Usage: #inline
* status = #completed
* intent = #order
* medicationReference = Reference(medication-2)
* reasonReference = Reference(encounter-diagnosis-2)
* subject = Reference(patient-2)
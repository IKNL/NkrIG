Instance: medication-request-1
InstanceOf: NcrEhrMedicationAgreement
Usage: #inline
* status = #completed
* intent = #order
* medicationReference = Reference(medication-1)
* reasonReference = Reference(encounter-diagnosis-2)
* subject = Reference(patient-2)

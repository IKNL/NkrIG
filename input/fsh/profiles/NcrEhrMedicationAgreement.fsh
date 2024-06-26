Profile: NcrEhrMedicationAgreement
Parent: MpMedicationAgreement
Id: ncr-ehr-medication-agreement
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* status = #completed
* intent = #order
* medicationReference MS
* medicationReference only Reference(NcrEhrMedication)
* reasonReference MS
* reasonReference only Reference(NcrEhrCondition)
* subject MS
* subject only Reference(NcrEhrPatient)

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
// [TODO] Wat te doen met: 'MedicatieAfspraak::RedenVanVoorschrijven::Probleem. En dan alleen medicijnen die voor een kankerdiagnose zijn voorgeschreven (in specifieke query’s/gevallen voor andere diagnoses, zoals bijv. complicaties, bijwerkingen, etc.).'
* subject MS
* subject only Reference(NcrEhrPatient)

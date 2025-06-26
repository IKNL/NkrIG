Profile: NcrEhrMedicationAgreement
Parent: MpMedicationAgreement
Id: ncr-ehr-medication-agreement
* ^version = "1.2.2"
* ^status = #active
* ^date = "2025-02-10"
* status = #completed
* intent = #order
* medicationReference 1..1 MS
* medicationReference only Reference(NcrEhrMedication)
* reasonReference 1..1 MS
* reasonReference only Reference(NcrEhrCondition)
* subject MS
* subject only Reference(NcrEhrPatient)

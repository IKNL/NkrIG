Profile: NcrEhrMedicationAgreement
Parent: MpMedicationAgreement
Id: ncr-ehr-medication-agreement
* insert MetaRules
* status = #completed
* intent = #order
* medicationReference 1..1 MS
* medicationReference only Reference(NcrEhrMedication)
* reasonReference 1..1 MS
* reasonReference only Reference(NcrEhrCondition)
* subject MS
* subject only Reference(NcrEhrPatient)

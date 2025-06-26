Profile: NcrEhrMedicationAdministration
Parent: MpMedicationAdministration2
Id: ncr-ehr-medication-administration
* ^version = "1.2.2"
* ^status = #active
* ^date = "2025-02-10"
* status = #completed
* medicationReference MS
* medicationReference only Reference(NcrEhrMedication)
* subject MS 
* subject only Reference(NcrEhrPatient)
* effectiveDateTime 1..1 MS
* request 1..1 MS
* request only Reference(NcrEhrMedicationAgreement) 

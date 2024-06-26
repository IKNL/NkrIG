Profile: NcrEhrMedicationAdministration
Parent: MpMedicationAdministration2
Id: ncr-ehr-medication-administration
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* status = #completed
* medicationReference MS 
* medicationReference only Reference(NcrEhrMedication)
* subject MS 
* subject only Reference(NcrEhrPatient)
* context 1.. MS 
* context only Reference(NcrEhrEpisodeOfCare)
* effectiveDateTime MS
* request MS
* request only Reference(NcrEhrMedicationAgreement) 

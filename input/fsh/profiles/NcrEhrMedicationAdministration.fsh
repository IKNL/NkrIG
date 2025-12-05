Profile: NcrEhrMedicationAdministration
Parent: http://nictiz.nl/fhir/StructureDefinition/mp-MedicationAdministration2
Id: ncr-ehr-medication-administration
* insert MetaRules
* status = #completed
* medicationReference MS
* medicationReference only Reference(NcrEhrMedication)
* subject MS 
* subject only Reference(NcrEhrPatient)
* effectiveDateTime 1..1 MS
* request 1..1 MS
* request only Reference(NcrEhrMedicationAgreement) 

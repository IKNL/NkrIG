Profile: NcrEhrCondition
Parent: NlcoreProblem
Id: ncr-ehr-condition
* ^version = "1.0.0"
* ^status = #active
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* clinicalStatus 1.. MS
* clinicalStatus = $condition-clinical#active
* category contains ncr-ehr-category 1..1 MS
* category[ncr-ehr-category] from $condition-category-vs (required)
* code 1.. MS
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains icd10coding 1..1
* code.coding[icd10coding].system = "http://hl7.org/fhir/sid/icd-10-nl" (exactly)
* code.coding[icd10coding].code 1..
* bodySite.extension[laterality] ^sliceName = "laterality"
* bodySite.extension[laterality] MS
* subject only Reference(NcrEhrPatient)
* subject MS
* recordedDate 1.. MS
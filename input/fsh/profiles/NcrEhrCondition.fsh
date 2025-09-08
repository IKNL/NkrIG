Profile: NcrEhrCondition
Parent: $nl-core-Problem
Id: ncr-ehr-condition
* ^version = "1.3.0"
* ^status = #active
* ^date = "2025-02-10"
* clinicalStatus 1.. MS
* clinicalStatus = $condition-clinical#active
* category 1..
* category ^mustSupport = false
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
* bodySite.extension[laterality] ^mustSupport = true
* subject only Reference(NcrEhrPatient)
* subject MS
* recordedDate 1.. MS
* stage ^short = "Cancer stage"
* stage ..1
* stage.summary 1..
* stage.summary ^comment = "Only summary.text is used." 
* stage.summary.text 1..1 MS

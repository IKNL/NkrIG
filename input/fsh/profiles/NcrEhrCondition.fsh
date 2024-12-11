Alias: $condition-clinical = http://terminology.hl7.org/CodeSystem/condition-clinical
Alias: $nl-core-Problem = http://nictiz.nl/fhir/StructureDefinition/nl-core-Problem
Alias: $ncr-ehr-patient = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-patient

Profile: NcrEhrCondition
Parent: $nl-core-Problem
Id: ncr-ehr-condition
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* clinicalStatus 1.. MS
* clinicalStatus = $condition-clinical#active
* category 1..
* category ^mustSupport = false
* category ^binding.strength = #required
* category contains ncr-ehr-category 1..1 MS
* category[ncr-ehr-category] ^binding.strength = #required
* code 1.. MS
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains icd10coding 1..1
* code.coding[icd10coding].system = "http://hl7.org/fhir/sid/icd-10-nl" (exactly)
* code.coding[icd10coding].code 1..
* bodySite.extension[laterality] ^sliceName = "laterality"
* bodySite.extension[laterality] ^mustSupport = true
* subject only Reference($ncr-ehr-patient)
* subject MS
* recordedDate 1.. MS
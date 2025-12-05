Profile: NcrEhrLaboratoryResult
Parent: http://nictiz.nl/fhir/StructureDefinition/nl-core-LaboratoryTestResult
Id: ncr-ehr-laboratory-result
Title: "Ncr Ehr Laboratory Test Results"
Description: "A laboratory result describes the result of a laboratory analysis"
* status = #final //pattern
* code MS
* code ^binding.strength = #required
* code ^binding.valueSet = $test-code-loinc-codelijst
* effective[x] 1..1
* effectiveDateTime MS
* subject MS
* subject only Reference(NcrEhrPatient)
* value[x] MS
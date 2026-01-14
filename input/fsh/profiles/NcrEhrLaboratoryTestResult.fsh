Profile: NcrEhrLaboratoryResult
Parent: http://nictiz.nl/fhir/StructureDefinition/nl-core-LaboratoryTestResult
Id: ncr-ehr-laboratory-result
Title: "Ncr Ehr Laboratory Test Results"
Description: "A laboratory result describes the result of a laboratory analysis"
* status = #final
* basedOn only Reference(NcrEhrServiceRequest)
* basedOn ^type.aggregation = #bundled
* code MS
* code ^binding.strength = #required
* code ^binding.valueSet = $test-code-loinc-codelijst //nl-core sipp
* effective[x] 1..1
* effective[x] only dateTime 
* subject MS
* subject only Reference(NcrEhrPatient)
* subject ^type.aggregation = #bundled
* value[x] MS
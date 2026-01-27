Profile: NcrEhrLaboratoryTestResult
Parent: http://nictiz.nl/fhir/StructureDefinition/nl-core-LaboratoryTestResult
Id: ncr-ehr-laboratory-test-result
Title: "Ncr Ehr Laboratory Test Result"
Description: "A nl-core derived Laboratory Test Result profile that specifies the linkage to a tumor condition through the `ServiceRequest.reasonReference` on which the Lab Test Result is based. Also refines the code to be from a required value set of LOINC codes."
* insert MetaRules
* status = #final
* basedOn only Reference(NcrEhrLabServiceRequest)
* basedOn ^type.aggregation = #bundled
* code MS
* code from $test-code-loinc-codelijst (required) //nl-core valueset
* effective[x] 1..1
* effective[x] only dateTime 
* subject MS
* subject only Reference(NcrEhrPatient)
* subject ^type.aggregation = #bundled
* value[x] MS
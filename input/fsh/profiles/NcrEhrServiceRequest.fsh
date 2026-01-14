Profile: NcrEhrServiceRequest
Parent: http://hl7.org/fhir/StructureDefinition/ServiceRequest
Id: ncr-ehr-service-request
Title: "Service request"
Description: "A service request describes a request for a laboratory test. This to be performed."
* status = #final //extend with additional status values
* basedOn only Reference(ServiceRequest)
* basedOn ^type.aggregation = #bundled
* code MS
* code ^binding.strength = #required
* code ^binding.valueSet = $test-code-loinc-codelijst
* effective[x] 1..1
* effective[x] only dateTime 
* subject MS
* subject only Reference(NcrEhrPatient)
* subject ^type.aggregation = #bundled
* value[x] MS
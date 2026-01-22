Profile: NcrEhrLabServiceRequest
Parent: http://hl7.org/fhir/StructureDefinition/ServiceRequest
Id: ncr-ehr-lab-service-request
Title: "Service request"
Description: "A FHIR-core derived service request profile that specifies the linkage of Laboratory test result to a tumour through the `reasonReference`

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier contains 
    ordernumber 0..1
* identifier[ordernumber].type = $v2-0203#PLAC
* status = #final //extend with additional status values
* intent = #order
* category = $sct#108252007 // Laboratory procedure
* code MS
* code from $test-code-loinc-codelijst (required)
* subject MS
* subject only Reference(NcrEhrPatient)
* subject ^type.aggregation = #bundled
* reasonReference only Reference(NcrEhrCondition)
* reasonReference MS
* reasonReference ^type.aggregation = #bundled

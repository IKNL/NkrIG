Instance: lab-service-request-example
InstanceOf: NcrEhrLabServiceRequest
Usage: #example
Title: "Lab Service Request Example"
Description: "Example of a laboratory service request with NCR EHR profile"
* identifier[ordernumber].value = "SR-2024-0001"
* identifier[ordernumber].system = "http://acme.org/fhir/NamingSystem/ordernumber"
* status = #completed
* intent = #order
* category = $sct#108252007
* code = $loinc#2857-1 "Prostate specific Ag [Mass/volume] in Serum or Plasma"
* subject = Reference(https://fhir.example.org/Patient/patient-example)
* reasonReference = Reference(https://fhir.example.org/Condition/condition-example)

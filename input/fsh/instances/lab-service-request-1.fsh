Instance: lab-service-request-1
InstanceOf: NcrEhrLabServiceRequest
Usage: #inline
* identifier[ordernumber].value = "SR-2024-0001"
* identifier[ordernumber].system = "http://acme.org/fhir/NamingSystem/ordernumber"
* status = #completed
* intent = #order
* category = $sct#108252007
* code = $loinc#718-7 // Hemoglobin [Mass/volume] in Blood
* subject = Reference(https://fhir.example.org/patient-2)
* reasonReference = Reference(https://fhir.example.org/problem-list-condition-1)  

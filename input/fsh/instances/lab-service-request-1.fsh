Instance: lab-service-request-1
InstanceOf: NcrEhrLabServiceRequest
Usage: #inline
* identifier[ordernumber].value = "SR-2024-0001"
* identifier[ordernumber].system = "http://acme.org/fhir/NamingSystem/ordernumber"
* status = #final
* intent = #order
* category = $sct#108252007
* code = $loinc#718-7 // Hemoglobin [Mass/volume] in Blood
* subject = Reference(patient-2)
* reasonReference = Reference(problem-list-condition-1)  

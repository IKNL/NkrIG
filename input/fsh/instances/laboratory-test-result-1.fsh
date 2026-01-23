Instance: laboratory-test-result-1
InstanceOf: NcrEhrLaboratoryTestResult
Usage: #inline
* status = #final
* basedOn = Reference(https://fhir.example.org/lab-service-request-1)
* code = $loinc#718-7 // Hemoglobin [Mass/volume] in Blood
* subject = Reference(https://fhir.example.org/patient-2)
* effectiveDateTime = "2024-06-01T10:00:00Z"            
* valueQuantity = 13.5 'g/dL' "g/dl"
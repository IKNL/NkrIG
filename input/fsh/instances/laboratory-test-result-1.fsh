Instance: laboratory-test-result-1
InstanceOf: NcrEhrLaboratoryTestResult
Usage: #inline
* status = #final
* basedOn = Reference(https://fhir.example.org/lab-service-request-1)
* code = $loinc#2857-1 //Prostate specific Ag [Mass/volume] in Serum or Plasma
* subject = Reference(https://fhir.example.org/patient-2)
* effectiveDateTime = "2024-06-01T10:00:00Z"            
* valueQuantity = 3.2 'ng/mL' "ng/mL"
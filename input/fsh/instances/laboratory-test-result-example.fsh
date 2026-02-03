Instance: laboratory-test-result-example
InstanceOf: NcrEhrLaboratoryTestResult
Usage: #example
Title: "Laboratory Test Result Example"
Description: "Example of a laboratory test result with NCR EHR profile"
* status = #final
* basedOn = Reference(https://fhir.example.org/ServiceRequest/lab-service-request-example)
* code = $loinc#2857-1 "Prostate specific Ag [Mass/volume] in Serum or Plasma"
* subject = Reference(https://fhir.example.org/Patient/patient-example)
* effectiveDateTime = "2024-06-01T10:00:00Z"            
* valueQuantity = 3.2 'ng/mL' "ng/mL"

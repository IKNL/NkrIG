Instance: problem-list-condition-4
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#problem-list-item
* clinicalStatus = $condition-clinical#active
* code.coding[icd10coding] = #C77.3
* subject = Reference(https://fhir.example.org/Patient/patient-1)
* recordedDate = "2015-12-27"
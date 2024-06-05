Instance: problem-list-condition-3
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#problem-list-item
* clinicalStatus = $condition-clinical#active
* code.coding[icd10coding] = #M8140/3
* subject.reference = "https://fhir.example.org/Patient/patient-1"
* recordedDate = "2015-12-27"
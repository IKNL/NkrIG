Instance: problem-list-condition-2
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#problem-list-item
* clinicalStatus = $condition-clinical#active
* code.coding[icd10coding] = #C78.0
* subject.reference = "https://fhir.example.org/Patient/patient-1"
* recordedDate = "2015-12-27"
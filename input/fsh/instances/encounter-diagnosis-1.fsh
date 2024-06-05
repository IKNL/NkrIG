Instance: encounter-diagnosis-1
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#encounter-diagnosis
* clinicalStatus = $condition-clinical#active
* code.coding[icd10coding] = #C61
* subject.reference = "https://fhir.example.org/Patient/patient-1"
* recordedDate = "2018-03-20"
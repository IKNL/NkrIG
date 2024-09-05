Instance: encounter-diagnosis-2
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#encounter-diagnosis
* clinicalStatus = $condition-clinical#active
* code.coding[icd10coding] = #C85.9
* subject = Reference(https://fhir.example.org/Patient/patient-2)
* recordedDate = "2019-12-19"
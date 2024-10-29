Instance: encounter-diagnosis-2
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#encounter-diagnosis
* clinicalStatus = $condition-clinical#active
* code = $icd-10-nl#C85.9
* subject = Reference(patient-2)
* recordedDate = "2019-12-19"
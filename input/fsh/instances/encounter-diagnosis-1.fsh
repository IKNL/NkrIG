Instance: encounter-diagnosis-1
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#encounter-diagnosis
* clinicalStatus = $condition-clinical#active
* code = $icd-10-nl#C61
* subject = Reference(patient-1)
* recordedDate = "2018-03-20"
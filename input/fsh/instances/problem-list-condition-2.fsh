Instance: problem-list-condition-2
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#problem-list-item
* clinicalStatus = $condition-clinical#active
* code = $icd-10-nl#C78.0
* subject = Reference(patient-1)
* recordedDate = "2015-12-27"
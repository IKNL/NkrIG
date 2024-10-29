Instance: episode-of-care-1
InstanceOf: NcrEhrEpisodeOfCare
Usage: #inline
* status = #active
* diagnosis[0].condition = Reference(encounter-diagnosis-1)
* diagnosis[=].role = $diagnosis-role#billing
* diagnosis[+].condition = Reference(problem-list-condition-1)
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 1
* diagnosis[+].condition = Reference(problem-list-condition-2)
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 1
* diagnosis[+].condition = Reference(problem-list-condition-3)
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 1
* diagnosis[+].condition = Reference(problem-list-condition-4)
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 2
* diagnosis[+].condition = Reference(problem-list-condition-5)
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 2
* diagnosis[+].condition = Reference(problem-list-condition-6)
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 2
* patient = Reference(patient-1)
* managingOrganization = Reference(organization-1)
* period.start = "2018-03-20"
* period.end = "2023-11-08"
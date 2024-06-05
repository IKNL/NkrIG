Instance: episode-of-care-1
InstanceOf: NcrEhrEpisodeOfCare
Usage: #inline
* status = #active
* diagnosis[0].condition.reference = "https://fhir.example.org/Condition/encounter-diagnosis-1"
* diagnosis[=].role = $diagnosis-role#billing
* diagnosis[+].condition.reference = "https://fhir.example.org/Condition/problem-list-condition-1"
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 1
* diagnosis[+].condition.reference = "https://fhir.example.org/Condition/problem-list-condition-2"
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 1
* diagnosis[+].condition.reference = "https://fhir.example.org/Condition/problem-list-condition-3"
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 1
* diagnosis[+].condition.reference = "https://fhir.example.org/Condition/problem-list-condition-4"
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 2
* diagnosis[+].condition.reference = "https://fhir.example.org/Condition/problem-list-condition-5"
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 2
* diagnosis[+].condition.reference = "https://fhir.example.org/Condition/problem-list-condition-6"
* diagnosis[=].role = $diagnosis-role#AD
* diagnosis[=].extension[ncrEhrDiagnosisGroup].valueInteger = 2
* patient.reference = "https://fhir.example.org/Patient/patient-1"
* managingOrganization.reference = "https://fhir.example.org/Organization/organization-1"
* period.start = "2018-03-20"
* period.end = "2023-11-08"
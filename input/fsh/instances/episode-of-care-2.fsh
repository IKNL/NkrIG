Instance: episode-of-care-2
InstanceOf: NcrEhrEpisodeOfCare
Usage: #inline
* status = #active
* diagnosis.condition.reference = "https://fhir.example.org/Condition/encounter-diagnosis-2"
* diagnosis.role = $diagnosis-role#billing
* patient.reference = "https://fhir.example.org/Patient/patient-2"
* managingOrganization.reference = "https://fhir.example.org/Organization/organization-1"
* period.start = "2019-12-19"
Instance: episode-of-care-example
InstanceOf: NcrEhrEpisodeOfCare
Usage: #example
Title: "Episode of Care Example"
Description: "Example of an episode of care with NCR EHR profile"
* status = #active
* patient = Reference(https://fhir.example.org/Patient/patient-example)
* managingOrganization = Reference(https://fhir.example.org/Organization/organization-example)
* diagnosis.condition = Reference(https://fhir.example.org/Condition/condition-example)

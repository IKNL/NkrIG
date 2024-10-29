Instance: episode-of-care-2
InstanceOf: NcrEhrEpisodeOfCare
Usage: #inline
* status = #active
* diagnosis.condition = Reference(encounter-diagnosis-2)
* diagnosis.role = $diagnosis-role#billing
* patient = Reference(patient-2)
* managingOrganization = Reference(organization-1)
* period.start = "2019-12-19"
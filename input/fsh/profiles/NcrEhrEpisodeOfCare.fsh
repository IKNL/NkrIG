Profile: NcrEhrEpisodeOfCare
Parent: EpisodeOfCare
Id: ncr-ehr-episode-of-care
* ^version = "1.2.2"
* ^status = #active
* ^date = "2025-02-10"
* diagnosis.extension contains NcrEhrDiagnosisGroup named ncrEhrDiagnosisGroup 0..1
* diagnosis.extension[ncrEhrDiagnosisGroup].value[x] MS
* diagnosis.condition only Reference(NcrEhrCondition)
* diagnosis.condition ^type.aggregation = #bundled
* patient only Reference(NcrEhrPatient)
* patient MS
* patient ^type.aggregation = #bundled
* managingOrganization only Reference(NcrEhrHealthcareProvider)
* managingOrganization MS
* managingOrganization ^type.aggregation = #bundled
* period MS
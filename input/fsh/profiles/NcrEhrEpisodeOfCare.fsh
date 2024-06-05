Profile: NcrEhrEpisodeOfCare
Parent: EpisodeOfCare
Id: ncr-ehr-episode-of-care
* ^version = "1.0.0"
* ^status = #active
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* diagnosis.extension contains NcrEhrDiagnosisGroup named ncrEhrDiagnosisGroup 0..1
* diagnosis.extension[ncrEhrDiagnosisGroup] ^isModifier = false
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
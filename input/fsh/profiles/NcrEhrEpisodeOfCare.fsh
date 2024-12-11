Alias: $ncr-ehr-diagnosis-group = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-diagnosis-group
Alias: $ncr-ehr-condition = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-condition
Alias: $ncr-ehr-patient = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-patient
Alias: $ncr-ehr-healthcare-provider = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-healthcare-provider

Profile: NcrEhrEpisodeOfCare
Parent: EpisodeOfCare
Id: ncr-ehr-episode-of-care
* ^version = "1.0.0"
* ^status = #active
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* diagnosis.extension contains $ncr-ehr-diagnosis-group named ncrEhrDiagnosisGroup 0..1
* diagnosis.extension[ncrEhrDiagnosisGroup] ^isModifier = false
* diagnosis.extension[ncrEhrDiagnosisGroup].value[x] MS
* diagnosis.condition only Reference($ncr-ehr-condition)
* diagnosis.condition ^type.aggregation = #bundled
* patient only Reference($ncr-ehr-patient)
* patient MS
* patient ^type.aggregation = #bundled
* managingOrganization only Reference($ncr-ehr-healthcare-provider)
* managingOrganization MS
* managingOrganization ^type.aggregation = #bundled
* period MS
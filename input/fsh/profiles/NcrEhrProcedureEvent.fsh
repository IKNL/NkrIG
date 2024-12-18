Profile: NcrEhrProcedureEvent
Parent: $nl-core-Procedure-event
Id: ncr-ehr-procedure-event
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* extension 1..
* extension contains $workflow-episodeOfCare named episodeOfCare 1..1
* extension[episodeOfCare] ^isModifier = false
* extension[episodeOfCare].value[x] only Reference(NcrEhrEpisodeOfCare)
* extension[episodeOfCare].value[x] ^type.aggregation = #bundled
* code 1.. MS
* subject only Reference(NcrEhrPatient)
* subject MS
* performedPeriod MS
* performedPeriod ^sliceName = "performedPeriod"
* performedDateTime ..0
* performedDateTime ^sliceName = "performedDateTime"
* reasonReference 1..1 MS
* reasonReference only Reference(NcrEhrCondition)
* bodySite.extension[laterality] ^sliceName = "laterality"
* bodySite.extension[laterality] ^mustSupport = true
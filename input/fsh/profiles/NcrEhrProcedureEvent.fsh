Profile: NcrEhrProcedureEvent
Parent: $nl-core-Procedure-event
Id: ncr-ehr-procedure-event
* ^version = "1.2.2"
* ^status = #active
* ^date = "2025-02-10"
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
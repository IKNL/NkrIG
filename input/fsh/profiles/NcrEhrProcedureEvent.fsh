Profile: NcrEhrProcedureEvent
Parent: NlcoreProcedureevent
Id: ncr-ehr-procedure-event
* ^status = #draft
* ^date = "2024-03-05T10:28:11.9260361+00:00"
* extension contains $workflow-episodeOfCare named episodeOfCare 1..1
* extension[episodeOfCare] ^isModifier = false
* extension[episodeOfCare].value[x] only Reference(NcrEhrEpisodeOfCare)
* extension[episodeOfCare].value[x] ^type.aggregation = #bundled
* code 1.. MS
* code from NcrEhrProcedureVS
* subject only Reference(NcrEhrPatient)
* subject MS
* performedPeriod MS
* performedDateTime ..0
* reasonReference 1..1 MS
* reasonReference only Reference(NcrEhrCondition)
* bodySite.extension[laterality] ^sliceName = "laterality"
* bodySite.extension[laterality] ^mustSupport = true
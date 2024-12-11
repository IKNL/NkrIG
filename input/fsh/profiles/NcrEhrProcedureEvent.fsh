Alias: $nl-core-Procedure-event = http://nictiz.nl/fhir/StructureDefinition/nl-core-Procedure-event
Alias: $workflow-episodeOfCare = http://hl7.org/fhir/StructureDefinition/workflow-episodeOfCare
Alias: $ncr-ehr-episode-of-care = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-episode-of-care
Alias: $ncr-ehr-patient = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-patient
Alias: $ncr-ehr-condition = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-condition

Profile: NcrEhrProcedureEvent
Parent: $nl-core-Procedure-event
Id: ncr-ehr-procedure-event
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* extension 1..
* extension contains $workflow-episodeOfCare named episodeOfCare 1..1
* extension[episodeOfCare] ^isModifier = false
* extension[episodeOfCare].value[x] only Reference($ncr-ehr-episode-of-care)
* extension[episodeOfCare].value[x] ^type.aggregation = #bundled
* code 1.. MS
* subject only Reference($ncr-ehr-patient)
* subject MS
* performedPeriod MS
* performedPeriod ^sliceName = "performedPeriod"
* performedDateTime ..0
* performedDateTime ^sliceName = "performedDateTime"
* reasonReference 1..1 MS
* reasonReference only Reference($ncr-ehr-condition)
* bodySite.extension[laterality] ^sliceName = "laterality"
* bodySite.extension[laterality] ^mustSupport = true
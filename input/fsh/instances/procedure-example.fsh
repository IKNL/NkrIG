Instance: procedure-example
InstanceOf: NcrEhrProcedureEvent
Usage: #example
Title: "Procedure Event Example"
Description: "Example of a procedure event with NCR EHR profile"
* extension[episodeOfCare].valueReference = Reference(https://fhir.example.org/EpisodeOfCare/episode-of-care-example)
* status = #completed
* code = urn:oid:2.16.840.1.113883.2.4.3.27.15.5#034739
* performedPeriod.start = "2020-05-07"
* performedPeriod.end = "2020-05-07"
* subject = Reference(https://fhir.example.org/Patient/patient-example)
* reasonReference = Reference(https://fhir.example.org/Condition/condition-example)
* bodySite.extension[laterality].valueCodeableConcept = $sct#7771000
* bodySite = $v3-NullFlavor#UNK

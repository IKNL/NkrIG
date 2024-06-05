Instance: procedure-1
InstanceOf: NcrEhrProcedureEvent
Usage: #inline
* extension[episodeOfCare].valueReference.reference = "https://fhir.example.org/EpisodeOfCare/episode-of-care-2"
* status = #completed
* code = urn:oid:2.16.840.1.113883.2.4.3.27.15.5#034739
* performedPeriod.start = "2020-05-07"
* performedPeriod.end = "2020-05-07"
* subject.reference = "https://fhir.example.org/Patient/patient-2"
* reasonReference.reference = "https://fhir.example.org/Condition/encounter-diagnosis-2"
* bodySite.extension[laterality].valueCodeableConcept = $sct#7771000
* bodySite = $v3-NullFlavor#UNK
Extension: NcrEhrDiagnosisGroup
Id: ncr-ehr-diagnosis-group
Description: "An extension that indicates a grouping for Conditions in EpisodeOfCare.diagnosis. Two Conditions with the same value for this extension belong to the same group. Conditions for which this extension is not used do not belong to a group."
Context: EpisodeOfCare.diagnosis
* ^version = "1.0.0"
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* . ^definition = "The value of this extension is an integer that indicates the grouping."
* value[x] only integer
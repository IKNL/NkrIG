Instance: medication-administration-1
InstanceOf: MpMedicationAdministration2
Usage: #inline
* status = #completed
* category = http://snomed.info/sct#18629005 "Medication administration"
* medicationReference.reference = "https://fhir.example.org/Medication/medication-1"
* subject.reference = "https://fhir.example.org/Patient/patient-2"
* context.reference = "https://fhir.example.org/EpisodeOfCare/episode-of-care-2"
* effectiveDateTime = "2015-01-15T04:30:00+01:00"
* request.reference = "https://fhir.example.org/MedicationRequest/medication-request-1"

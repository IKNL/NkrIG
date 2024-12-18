Instance: medication-administration-1
InstanceOf: NcrEhrMedicationAdministration
Usage: #inline
* status = #completed
* category = http://snomed.info/sct#18629005 "Medication administration"
* medicationReference = Reference(https://fhir.example.org/Medication/medication-1)
* subject = Reference(https://fhir.example.org/Patient/patient-2)
* context = Reference(https://fhir.example.org/EpisodeOfCare/episode-of-care-2)
* effectiveDateTime = "2015-01-15T04:30:00+01:00"
* request = Reference(https://fhir.example.org/MedicationRequest/medication-request-1)

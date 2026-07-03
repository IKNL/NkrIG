Instance: medication-administration-example
InstanceOf: NcrEhrMedicationAdministration
Usage: #example
Title: "Medication Administration Example"
Description: "Example of a medication administration with NCR EHR profile"
* status = #completed
* category = http://snomed.info/sct#18629005 "Medication administration"
* medicationReference = Reference(https://fhir.example.org/Medication/medication-example)
* subject = Reference(https://fhir.example.org/Patient/patient-example)
* context = Reference(https://fhir.example.org/EpisodeOfCare/episode-of-care-example)
* effectiveDateTime = "2015-01-15T04:30:00+01:00"
* request = Reference(https://fhir.example.org/MedicationRequest/medication-agreement-example)

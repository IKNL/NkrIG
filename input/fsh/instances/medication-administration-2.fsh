Instance: medication-administration-2
InstanceOf: NcrEhrMedicationAdministration
Usage: #inline
* status = #completed
* category = http://snomed.info/sct#18629005 "Medication administration"
* medicationReference = Reference(medication-2)
* subject = Reference(patient-2)
* context = Reference(episode-of-care-2)
* effectiveDateTime = "2015-01-15T04:30:00+01:00"
* request = Reference(medication-request-2)

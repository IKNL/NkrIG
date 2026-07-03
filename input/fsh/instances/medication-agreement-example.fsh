Instance: medication-agreement-example
InstanceOf: NcrEhrMedicationAgreement
Usage: #example
Title: "Medication Agreement Example"
Description: "Example of a medication agreement (medication request) with NCR EHR profile"
* status = #active
* intent = #order
* medicationReference = Reference(https://fhir.example.org/Medication/medication-example)
* subject = Reference(https://fhir.example.org/Patient/patient-example)
* authoredOn = "2018-06-16"

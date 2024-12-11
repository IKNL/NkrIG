Alias: $nl-core-HealthcareProvider-Organization = http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization

Profile: NcrEhrHealthcareProvider
Parent: $nl-core-HealthcareProvider-Organization
Id: ncr-ehr-healthcare-provider
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* identifier contains agb 1..1 MS
Alias: $nl-core-HealthcareProvider-Organization = http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization

Profile: NcrEhrHealthcareProvider
Parent: $nl-core-HealthcareProvider-Organization
Id: ncr-ehr-healthcare-provider
* ^version = "1.0.0"
* ^contact.name = "IKNL" //Moet dit niet de aanleverende partij zijn?
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* identifier[agb] 1..1 MS
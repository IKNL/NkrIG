Alias: $nl-core-HealthcareProvider-Organization = http://nictiz.nl/fhir/StructureDefinition/nl-core-HealthcareProvider-Organization
Alias: $ncr-ehr-schema-document = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-schema-document

Profile: NcrEhrDataDocument
Parent: DocumentReference
Id: ncr-ehr-data-document
* ^version = "1.0.0"
* ^status = #active
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* status = #current (exactly)
* date 1..
* author 1..1
* author only Reference($nl-core-HealthcareProvider-Organization)
* description 1..
* content.attachment.contentType 1..
* content.attachment.contentType = #application/json (exactly)
* content.attachment.data 1..
* context 1..
* context.related ^slicing.discriminator.type = #profile
* context.related ^slicing.discriminator.path = "resolve()"
* context.related ^slicing.rules = #open
* context.related contains schema 1..*
* context.related[schema] only Reference($ncr-ehr-schema-document)
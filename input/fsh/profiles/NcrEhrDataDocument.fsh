Profile: NcrEhrDataDocument
Parent: DocumentReference
Id: ncr-ehr-data-document
* ^version = "1.2.2"
* ^status = #active
* ^date = "2025-02-10"
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
* context.related[schema] only Reference(NcrEhrSchemaDocument)
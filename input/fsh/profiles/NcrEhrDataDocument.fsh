Profile: NcrEhrDataDocument
Parent: DocumentReference
Id: ncr-ehr-data-document
* ^status = #draft
* ^date = "2024-03-12T09:37:49.3339123+00:00"
* status = #current (exactly)
* date 1..
* author 1..1
* author only Reference(NlcoreHealthcareProviderOrganization)
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
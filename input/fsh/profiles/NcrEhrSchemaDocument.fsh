Profile: NcrEhrSchemaDocument
Parent: DocumentReference
Id: ncr-ehr-schema-document
* ^version = "1.2.2"
* ^status = #active
* status = #current (exactly)
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains schema 1..1
* category[schema] = $document-type#schema
* content.attachment.contentType 1..
* content.attachment.contentType = #application/schema-instance+json (exactly)
* content.attachment.data 1..
Profile: NcrEhrSchemaDocument
Parent: DocumentReference
Id: ncr-ehr-schema-document
* ^version = "1.0.0"
* ^status = #active
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* status = #current (exactly)
* category = $document-type#schema
* content.attachment.contentType 1..
* content.attachment.contentType = #application/schema-instance+json (exactly)
* content.attachment.data 1..
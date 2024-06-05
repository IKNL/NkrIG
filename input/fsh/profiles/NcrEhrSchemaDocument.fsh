Profile: NcrEhrSchemaDocument
Parent: DocumentReference
Id: ncr-ehr-schema-document
* ^status = #draft
* ^date = "2024-03-06T11:29:18.8243435+00:00"
* status = #current (exactly)
* category = $document-type#schema
* content.attachment.contentType 1..
* content.attachment.contentType = #application/schema-instance+json (exactly)
* content.attachment.data 1..
Profile: NcrEhrMedication
Parent: MpPharmaceuticalProduct
Id: ncr-ehr-medication
* ^version = "1.0.0"
* ^status = #draft
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "$this"
* code.coding ^slicing.rules = #open
* code.coding contains ziCoding 1..1
    and atcCoding 1..1
* code.coding[ziCoding].system = "urn:oid:2.16.840.1.113883.2.4.4.8" (exactly)
* code.coding[ziCoding].code 1..
* code.coding[atcCoding].system = "http://www.whocc.no/atc" (exactly)
* code.coding[atcCoding].code 1..
* code.coding[ziCoding] ^sliceIsConstraining = true
* code.coding[ziCoding].display 1..
* code.coding[atcCoding].display 1..
* form 1..1 MS
* form.coding ^slicing.discriminator.type = #value
* form.coding ^slicing.discriminator.path = "$this"
* form.coding ^slicing.rules = #open
* form.coding contains pharmaceuticalForm 0..1
* form.coding[pharmaceuticalForm] ^sliceIsConstraining = true
* form.coding[pharmaceuticalForm] from $pharmaceutical-form-vs (required)
* form.coding[pharmaceuticalForm].display 1..
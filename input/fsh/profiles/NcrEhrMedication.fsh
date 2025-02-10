Profile: NcrEhrMedication
Parent: MpPharmaceuticalProduct
Id: ncr-ehr-medication
* ^version = "1.2.0"
* ^status = #draft
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains ziCoding 0..1
    and atcCoding 1..1 MS
* code.coding[ziCoding].system = "urn:oid:2.16.840.1.113883.2.4.4.8" (exactly)
* code.coding[ziCoding].code 1..1
* code.coding[ziCoding].display 1..
* code.coding[atcCoding].system = "http://www.whocc.no/atc" (exactly)
* code.coding[atcCoding].code 1..
* code.coding[atcCoding].display 1..
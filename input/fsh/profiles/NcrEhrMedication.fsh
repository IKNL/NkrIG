Profile: NcrEhrMedication
Parent: MpPharmaceuticalProduct
Id: ncr-ehr-medication
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* code.coding ^slicing.discriminator.type = #pattern
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains atc 1..1 MS 
    and zi-number 1..1 MS
* code.coding[atc].system = $atc
* code.coding[atc].code 1..
* code.coding[zi-number].system = $zi-number-cs 
* code.coding[zi-number].code 1.. 
* form MS

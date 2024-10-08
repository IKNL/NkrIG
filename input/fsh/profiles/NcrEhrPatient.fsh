Profile: NcrEhrPatient
Parent: NlcorePatient
Id: ncr-ehr-patient
* ^version = "1.0.0"
* ^status = #active
* ^contact.name = "IKNL"
* ^contact.telecom.system = #email
* ^contact.telecom.value = "fhir@iknl.nl"
* identifier[bsn] ..0
* identifier contains patientnummer 1..1 MS
* identifier[patientnummer] ^short = "Patientnummer van de instelling"
* identifier[patientnummer] ^definition = "Patientnummer van de Instelling"
* identifier[patientnummer] ^patternIdentifier.type = $v2-0203#MR
* identifier[patientnummer].value 1..
* identifier[patientnummer].value ^short = "Patientnummer"
* identifier[patientnummer].value ^definition = "Patientnummer"
* identifier[patientnummer].assigner 1..
* identifier[patientnummer].assigner only Reference(NcrEhrHealthcareProvider)
* identifier[patientnummer].assigner ^short = "Instelling die patientnummer heeft toegekend"
* identifier[patientnummer].assigner ^definition = "Instelling die patientnummer heeft toegekend"
* identifier[patientnummer].assigner ^type.aggregation = #bundled
* name[nameInformation] ..1
* name[nameInformation].family MS
* name[nameInformation].family.extension[prefix] ^mustSupport = true
* name[nameInformation].family.extension[lastName] ^mustSupport = true
* name[nameInformation].given ^slicing.discriminator.type = #pattern
* name[nameInformation].given ^slicing.discriminator.path = "extension('http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier').value"
* name[nameInformation].given ^slicing.rules = #open
* name[nameInformation].given contains initials 1..* MS
* name[nameInformation].given[initials] ^short = "Initialen"
* name[nameInformation].given[initials] ^definition = "Initialen"
* name[nameInformation].given[initials].extension ^mustSupport = false
* name[nameInformation].given[initials].extension[givenOrInitial] ^sliceName = "givenOrInitial"
* name[nameInformation].given[initials].extension[givenOrInitial].value[x] = #IN (exactly)
* gender MS
* gender.extension[genderCodelist].value[x] MS
* gender.extension[genderCodelist].value[x] ^short = "Administratief geslacht"
* gender.extension[genderCodelist].value[x] ^definition = "Administratief geslacht"
* birthDate MS
* birthDate ^short = "Geboortedatum van de patient"
* birthDate ^definition = "Geboortedatum van de patient"
* deceasedDateTime MS
* deceasedDateTime ^short = "Datum van overlijden"
* deceasedDateTime ^definition = "Datum van overlijden"
* address.postalCode MS
* address.postalCode ^definition = "Postcode van adres."
* address.country.extension 1..
* address.country.extension[countryCode].value[x].coding ^slicing.discriminator.type = #value
* address.country.extension[countryCode].value[x].coding ^slicing.discriminator.path = "$this"
* address.country.extension[countryCode].value[x].coding ^slicing.rules = #open
* address.country.extension[countryCode].value[x].coding contains isoCoding 1..1 MS
* address.country.extension[countryCode].value[x].coding[isoCoding] ^short = "ISO 3166 2 or 3 letter code"
* address.country.extension[countryCode].value[x].coding[isoCoding] ^patternCoding.system = "urn:iso:std:iso:3166"
* address.country.extension[countryCode].value[x].coding[isoCoding].code 1..
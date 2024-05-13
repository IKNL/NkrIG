Alias: $v2-0203 = http://terminology.hl7.org/CodeSystem/v2-0203
// Alias: $nl-core-Patient = http://nictiz.nl/fhir/StructureDefinition/nl-core-Patient
// Alias: $ncr-ehr-healthcare-provider = http://fhir.iknl.nl/fhir/iknl-ncr-ehr-r4/StructureDefinition/ncr-ehr-healthcare-provider

Profile: NcrEhrPatient
Parent: nl-core-Patient
Id: ncr-ehr-patient
* ^status = #draft
* identifier 1..
* identifier contains patientnummer 1..1 MS
* identifier[patientnummer] ^short = "Patientnummer van de instelling"
* identifier[patientnummer] ^definition = "Patientnummer van de Instelling"
* identifier[patientnummer] ^patternIdentifier.type = $v2-0203#MR
* identifier[patientnummer].value 1..
* identifier[patientnummer].value ^short = "Patientnummer"
* identifier[patientnummer].value ^definition = "Patientnummer"
* identifier[patientnummer].assigner 1..
// * identifier[patientnummer].assigner only Reference($ncr-ehr-healthcare-provider)
* identifier[patientnummer].assigner ^short = "Instelling die patientnummer heeft toegekend"
* identifier[patientnummer].assigner ^definition = "Instelling die patientnummer heeft toegekend"
* identifier[patientnummer].assigner ^type.aggregation = #bundled
// * name contains nameInformation 0..1
// * name[nameInformation].family MS
// * name[nameInformation].family.extension[prefix] ^sliceName = "prefix"
// * name[nameInformation].family.extension[prefix] ^short = "Voorvoegsel van geboortenaam"
// * name[nameInformation].family.extension[prefix] ^definition = "Voorvoegsel van geboortenaam"
// * name[nameInformation].family.extension[prefix] ^mustSupport = true
// * name[nameInformation].family.extension[lastName] ^sliceName = "lastName"
// * name[nameInformation].family.extension[lastName] ^short = "Achternaam"
// * name[nameInformation].family.extension[lastName] ^definition = "Achternaam (geboortenaam)"
// * name[nameInformation].family.extension[lastName] ^mustSupport = true
// * name[nameInformation].given ^slicing.discriminator.type = #pattern
// * name[nameInformation].given ^slicing.discriminator.path = "extension('http://hl7.org/fhir/StructureDefinition/iso21090-EN-qualifier').value"
// * name[nameInformation].given ^slicing.rules = #open
// * name[nameInformation].given[initials] ^sliceName = "initials"
// * name[nameInformation].given[initials] ^short = "Initialen"
// * name[nameInformation].given[initials] ^definition = "Initialen"
// * name[nameInformation].given[initials] ^mustSupport = true
// * name[nameInformation].given[initials].extension ^mustSupport = false
// * name[nameInformation].given[initials].extension[givenOrInitial] ^sliceName = "givenOrInitial"
// * name[nameInformation].given[initials].extension[givenOrInitial].value[x] = #IN (exactly)
* gender MS
// * gender.extension[genderCodelist] ^sliceName = "genderCodelist"
// * gender.extension[genderCodelist].value[x] MS
// * gender.extension[genderCodelist].value[x] ^short = "Administratief geslacht"
// * gender.extension[genderCodelist].value[x] ^definition = "Administratief geslacht"
* birthDate MS
// * birthDate ^short = "Geboortedatum van de patient"
// * birthDate ^definition = "Geboortedatum van de patient"
* deceasedDateTime MS
// * deceasedDateTime ^sliceName = "deceasedDateTime"
// * deceasedDateTime ^short = "Datum van overlijden"
// * deceasedDateTime ^definition = "Datum van overlijden"
* address.postalCode MS
// * address.postalCode ^definition = "Postcode van adres."
* address.country.extension 1..
* address.country.extension[countryCode] ^sliceName = "countryCode"
* address.country.extension[countryCode].value[x].coding ^slicing.discriminator.type = #value
* address.country.extension[countryCode].value[x].coding ^slicing.discriminator.path = "$this"
* address.country.extension[countryCode].value[x].coding ^slicing.rules = #open
* address.country.extension[countryCode].value[x].coding contains isoCoding 1..1 MS
* address.country.extension[countryCode].value[x].coding[isoCoding] ^short = "ISO 3166 2 or 3 letter code"
* address.country.extension[countryCode].value[x].coding[isoCoding] ^patternCoding.system = "urn:iso:std:iso:3166"
* address.country.extension[countryCode].value[x].coding[isoCoding].code 1..


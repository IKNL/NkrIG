Profile: NcrEhrPatient
Parent: $nl-core-Patient
Id: ncr-ehr-patient
* ^version = "1.2.3"
* ^status = #active
* ^date = "2025-07-04"
* identifier contains
    patientnummer 1..1 MS
* identifier[bsn] 0..0   
* identifier[patientnummer] ^short = "Patientnummer van de instelling"
* identifier[patientnummer] ^definition = "Patientnummer van de Instelling"
* identifier[patientnummer] ^patternIdentifier.type = $v2-0203#MR
* identifier[patientnummer].value 1..
* identifier[patientnummer].value ^short = "Patientnummer"
* identifier[patientnummer].value ^definition = "Patientnummer"
* identifier[patientnummer].assigner 1..
* identifier[patientnummer].assigner only Reference(ncr-ehr-healthcare-provider)
* identifier[patientnummer].assigner ^short = "Instelling die patientnummer heeft toegekend"
* identifier[patientnummer].assigner ^definition = "Instelling die patientnummer heeft toegekend"
* identifier[patientnummer].assigner ^type.aggregation = #bundled
* name[nameInformation] ..1
* name[nameInformation].family MS
* name[nameInformation].family.extension[prefix] ^short = "Voorvoegsel van geboortenaam"
* name[nameInformation].family.extension[prefix] ^definition = "Voorvoegsel van geboortenaam"
* name[nameInformation].family.extension[prefix] MS
* name[nameInformation].family.extension[lastName] ^short = "Achternaam"
* name[nameInformation].family.extension[lastName] ^definition = "Achternaam (geboortenaam)"
* name[nameInformation].family.extension[lastName] MS
* name[nameInformation].given MS
* name[nameInformation].given ^short = "Initialen"
* name[nameInformation].given ^definition = "Initialen"
* name[nameInformation].given ^comment = "Vanwege dataminimalisatie, mogen alleen de initialen worden verstrekt."
* name[nameInformation].given.extension[givenOrInitial].value[x] = #IN (exactly)
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
* address.postalCode ^definition = "Postcode van adres"
* address.country.extension[countryCode] 1..
* address.country.extension[countryCode].value[x].coding ^slicing.discriminator.type = #value
* address.country.extension[countryCode].value[x].coding ^slicing.discriminator.path = "$this"
* address.country.extension[countryCode].value[x].coding ^slicing.rules = #open
* address.country.extension[countryCode].value[x].coding contains isoCoding 1..1 MS
* address.country.extension[countryCode].value[x].coding[isoCoding] ^short = "ISO 3166 2 or 3 letter code"
* address.country.extension[countryCode].value[x].coding[isoCoding] ^patternCoding.system = "urn:iso:std:iso:3166"
* address.country.extension[countryCode].value[x].coding[isoCoding].code 1..

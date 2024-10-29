Instance: patient-3
InstanceOf: NcrEhrPatient
Usage: #inline
* identifier[patientnummer].assigner = Reference(organization-1)
* identifier[patientnummer].value = "009991118"
* name[nameInformation].extension[nameUsage].valueCode = #NL1
* name[nameInformation].family = "Hartlief"
* name[nameInformation].family.extension[lastName].valueString = "Hartlief"
* name[nameInformation].given[initials][0] = "K"
* name[nameInformation].given[initials][+] = "S"
* gender = #female
* gender.extension[genderCodelist].valueCodeableConcept = $v3-AdministrativeGender#M
* birthDate = "1968-06-09"
* address.postalCode = "9472 RS"
* address.country = "NL"
* address.country.extension[countryCode].valueCodeableConcept.coding[isoCoding].code = #NL

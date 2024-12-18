Instance: patient-2
InstanceOf: NcrEhrPatient
Usage: #inline
* identifier[patientnummer].assigner = Reference(https://fhir.example.org/Organization/organization-1)
* identifier[patientnummer].value = "009999117"
* name[nameInformation].extension[nameUsage].valueCode = #NL1
* name[nameInformation].family = "van Agtmaal"
* name[nameInformation].family.extension[prefix].valueString = "van"
* name[nameInformation].family.extension[lastName].valueString = "Agtmaal"
* name[nameInformation].given[initials] = "L"
* gender = #female
* gender.extension[genderCodelist].valueCodeableConcept = $v3-AdministrativeGender#F
* birthDate = "1995-10-26"
* address.postalCode = "9202JR"
* address.country = "NL"
* address.country.extension[countryCode].valueCodeableConcept.coding[isoCoding].code = #NL

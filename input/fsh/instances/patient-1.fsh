Instance: patient-1
InstanceOf: NcrEhrPatient
Usage: #inline
* identifier[patientnummer].assigner = Reference(https://fhir.example.org/Organization/organization-1)
* identifier[patientnummer].value = "009999115"
* name[nameInformation].extension[nameUsage].valueCode = #NL1
* name[nameInformation].family = "van Asch"
* name[nameInformation].family.extension[prefix].valueString = "van"
* name[nameInformation].family.extension[lastName].valueString = "Asch"
* name[nameInformation].given[0] = "T"
* name[nameInformation].given[+] = "H"
* gender = #male
* gender.extension[genderCodelist].valueCodeableConcept = $v3-AdministrativeGender#M
* birthDate = "1941-10-06"
* deceasedDateTime = "2023-09-18"
* address.postalCode = "2612VT"
* address.country = "NL"
* address.country.extension[countryCode].valueCodeableConcept.coding[isoCoding].code = #NL

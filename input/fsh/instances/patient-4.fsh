Instance: patient-4
InstanceOf: NcrEhrPatient
Usage: #inline
* identifier[patientnummer].assigner = Reference(organization-1)
* identifier[patientnummer].value = "009999115"
* name[nameInformation].extension[nameUsage].valueCode = #NL1
* name[nameInformation].family = "Kamminga"
* name[nameInformation].family.extension[lastName].valueString = "Kamminga"
* name[nameInformation].given[initials][0] = "M"
* gender = #male
* gender.extension[genderCodelist].valueCodeableConcept = $v3-AdministrativeGender#M
* birthDate = "1959-10-02"
* address.postalCode = "6431 EV"
* address.country = "NL"
* address.country.extension[countryCode].valueCodeableConcept.coding[isoCoding].code = #NL

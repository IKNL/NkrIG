Instance: patient-comparator
InstanceOf: NcrEhrPatient
Usage: #inline
* identifier[patientnummer].assigner = Reference(https://fhir.example.org/Organization/organization-1)
* identifier[patientnummer].value = "009999121"
* name[nameInformation].extension[nameUsage].valueCode = #NL1
* name[nameInformation].family = "Test-User"
* name[nameInformation].family.extension[lastName].valueString = "Test-User"
* name[nameInformation].given = "Y"
* gender = #male
* gender.extension[genderCodelist].valueCodeableConcept = $v3-AdministrativeGender#M
* birthDate = "1968-04-14"
* address.postalCode = "4812XX"
* address.country = "NL"
* address.country.extension[countryCode].valueCodeableConcept.coding[isoCoding].code = #NL

Instance: condition-comparator
InstanceOf: NcrEhrCondition
Usage: #inline
* category[ncr-ehr-category] = $condition-category#encounter-diagnosis
* clinicalStatus = $condition-clinical#active
* code.coding[icd10coding] = #C61
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* recordedDate = "2024-11-21"

Instance: lab-service-request-comparator-lt
InstanceOf: NcrEhrLabServiceRequest
Usage: #inline
* identifier[ordernumber].value = "1608223"
* identifier[ordernumber].system = "http://acme.org/fhir/NamingSystem/ordernumber"
* status = #completed
* intent = #order
* category = $sct#108252007
* code = $loinc#2857-1
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* reasonReference = Reference(https://fhir.example.org/Condition/condition-comparator)

Instance: lab-service-request-comparator-le
InstanceOf: NcrEhrLabServiceRequest
Usage: #inline
* identifier[ordernumber].value = "1608224"
* identifier[ordernumber].system = "http://acme.org/fhir/NamingSystem/ordernumber"
* status = #completed
* intent = #order
* category = $sct#108252007
* code = $loinc#2857-1
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* reasonReference = Reference(https://fhir.example.org/Condition/condition-comparator)

Instance: lab-service-request-comparator-ge
InstanceOf: NcrEhrLabServiceRequest
Usage: #inline
* identifier[ordernumber].value = "1608225"
* identifier[ordernumber].system = "http://acme.org/fhir/NamingSystem/ordernumber"
* status = #completed
* intent = #order
* category = $sct#108252007
* code = $loinc#2857-1
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* reasonReference = Reference(https://fhir.example.org/Condition/condition-comparator)

Instance: lab-service-request-comparator-gt
InstanceOf: NcrEhrLabServiceRequest
Usage: #inline
* identifier[ordernumber].value = "1608226"
* identifier[ordernumber].system = "http://acme.org/fhir/NamingSystem/ordernumber"
* status = #completed
* intent = #order
* category = $sct#108252007
* code = $loinc#2857-1
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* reasonReference = Reference(https://fhir.example.org/Condition/condition-comparator)

Instance: observation-comparator-lt
InstanceOf: NcrEhrLaboratoryTestResult
Usage: #inline
* status = #final
* basedOn = Reference(https://fhir.example.org/ServiceRequest/lab-service-request-comparator-lt)
* code = $loinc#2857-1
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* effectiveDateTime = "2024-11-23"
* valueQuantity = 7.0 'ng/mL' "ng/mL"
* valueQuantity.comparator = #<

Instance: observation-comparator-le
InstanceOf: NcrEhrLaboratoryTestResult
Usage: #inline
* status = #final
* basedOn = Reference(https://fhir.example.org/ServiceRequest/lab-service-request-comparator-le)
* code = $loinc#2857-1
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* effectiveDateTime = "2024-12-14"
* valueQuantity = 4.0 'ng/mL' "ng/mL"
* valueQuantity.comparator = #<=

Instance: observation-comparator-ge
InstanceOf: NcrEhrLaboratoryTestResult
Usage: #inline
* status = #final
* basedOn = Reference(https://fhir.example.org/ServiceRequest/lab-service-request-comparator-ge)
* code = $loinc#2857-1
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* effectiveDateTime = "2025-01-15"
* valueQuantity = 0.1 'ng/mL' "ng/mL"
* valueQuantity.comparator = #>=

Instance: observation-comparator-gt
InstanceOf: NcrEhrLaboratoryTestResult
Usage: #inline
* status = #final
* basedOn = Reference(https://fhir.example.org/ServiceRequest/lab-service-request-comparator-gt)
* code = $loinc#2857-1
* subject = Reference(https://fhir.example.org/Patient/patient-comparator)
* effectiveDateTime = "2025-05-31"
* valueQuantity = 10.0 'ng/mL' "ng/mL"
* valueQuantity.comparator = #>

Instance: observation-with-comparator
InstanceOf: Bundle
Title: "Observation met quantity comparator"
* type = #collection
* timestamp = "2023-01-01T14:49:45.6439747Z"
* meta.tag = $processing-target#NKR_GBS
* entry[0].fullUrl = "https://fhir.example.org/Organization/organization-1"
* entry[=].resource = organization-1
* entry[+].fullUrl = "https://fhir.example.org/Patient/patient-comparator"
* entry[=].resource = patient-comparator
* entry[+].fullUrl = "https://fhir.example.org/Condition/condition-comparator"
* entry[=].resource = condition-comparator
* entry[+].fullUrl = "https://fhir.example.org/ServiceRequest/lab-service-request-comparator-lt"
* entry[=].resource = lab-service-request-comparator-lt
* entry[+].fullUrl = "https://fhir.example.org/ServiceRequest/lab-service-request-comparator-le"
* entry[=].resource = lab-service-request-comparator-le
* entry[+].fullUrl = "https://fhir.example.org/ServiceRequest/lab-service-request-comparator-ge"
* entry[=].resource = lab-service-request-comparator-ge
* entry[+].fullUrl = "https://fhir.example.org/ServiceRequest/lab-service-request-comparator-gt"
* entry[=].resource = lab-service-request-comparator-gt
* entry[+].fullUrl = "https://fhir.example.org/Observation/observation-comparator-lt"
* entry[=].resource = observation-comparator-lt
* entry[+].fullUrl = "https://fhir.example.org/Observation/observation-comparator-le"
* entry[=].resource = observation-comparator-le
* entry[+].fullUrl = "https://fhir.example.org/Observation/observation-comparator-ge"
* entry[=].resource = observation-comparator-ge
* entry[+].fullUrl = "https://fhir.example.org/Observation/observation-comparator-gt"
* entry[=].resource = observation-comparator-gt

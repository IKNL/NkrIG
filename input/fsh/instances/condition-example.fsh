Instance: condition-example
InstanceOf: NcrEhrCondition
Usage: #example
Title: "Condition Example"
Description: "Example of a condition (diagnosis) with NCR EHR profile"
* category[ncr-ehr-category] = $condition-category#encounter-diagnosis
* clinicalStatus = $condition-clinical#active
* code.coding[icd10coding] = #C61
* subject = Reference(https://fhir.example.org/Patient/patient-example)
* recordedDate = "2018-03-20"

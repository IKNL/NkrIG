Profile: NcrEhrMedication
Parent: http://nictiz.nl/fhir/StructureDefinition/mp-PharmaceuticalProduct
Id: ncr-ehr-medication
* insert MetaRules
* code.coding ^slicing.discriminator.type = #value
* code.coding ^slicing.discriminator.path = "system"
* code.coding ^slicing.rules = #open
* code.coding contains ziCoding 0..1
    and atcCoding 1..1 MS
* code.coding[ziCoding].system = "urn:oid:2.16.840.1.113883.2.4.4.8" (exactly)
* code.coding[ziCoding].code 1..1
* code.coding[atcCoding].system = "http://www.whocc.no/atc" (exactly)
* code.coding[atcCoding].code 1..
* obeys med-display-value-or-text

Invariant: med-display-value-or-text
Description: "The code element SHALL contain either a display value or a text value."
Severity: #error
Expression: "code.coding.display.exists() or code.text.exists()"


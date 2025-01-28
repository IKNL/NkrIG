
## Profielen en Conformance
Deze sectie beschrijft welke profielen beschikbaar zijn en aan welke profielen minimaal voldaan moet worden om gegevens aan te kunnen leveren aan de NKR. Zonder een **Patient**-profiel en een **Condition**-profiel met een **encounter diagnosis** is het bijvoorbeeld niet mogelijk om vast te stellen in hoeverre de specifieke patiënt en tumor al bekend zijn in de NKR. Deze profielen zijn essentieel om een juiste identificatie en koppeling van de gegevens te waarborgen.

### Overzicht van Profielen

| NCR-EHR profile        | FHIR Base Profile            | Conformance  |
| --------------- | ----------------------------------- | ------------ |
| `NcrEhrPatient`         | `NL-Core-Patient`                   | Required     |
| `NcrEhrEpisodeOfCare`         | `EpisodeOfCare`               | Required     |
| `NcrEhrProcedureEvent`         | `NL-Core-Procedure-event`    |Required     |
| `NcrEhrHealthcareProvider` |`NL-Core-HealthcareProvider-Organization`    | Required     |
| `NcrEhrCondition`         | `NL-Core-Problem`          | Required     |
{: .grid }


### Conformance Statement
Ziekenhuizen moeten minimaal voldoen aan de specificaties van de hierboven genoemde profielen om succesvol gegevens aan te leveren aan de NKR.

### Bundeling en Aggregatie
Van elke patiënt worden de gegevens verzameld en verstuurd in een **bundle**, waarbij alle relevante informatie in één pakket wordt samengevoegd voor verzending.



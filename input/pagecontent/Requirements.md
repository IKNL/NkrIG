### De technische vereisten; 

Voor de geautomatiseerde gegevensverzameling, of dit nu via het ziekenhuis zelf of via een digitale applicatie van een externe partij gebeurt, is het noodzakelijk dat de (persoons)gegevens (dataset) binnen de omgeving van het ziekenhuis op een gestandaardiseerde manier worden klaargezet. Dit gebeurt op basis van zorginformatiebouwstenen (zibs2020) en via de FHIR-standaard (versie 4 of een andere versie die op dat moment door IKNL wordt voorgeschreven). Het ziekenhuis draagt de verantwoordelijkheid voor deze voorbereiding.
 
Het ziekenhuis verstuurt de FHIR berichten via de VPN-verbinding naar de VPN-Gateway van IKNL in de vorm van FHIR-resources, conform de `NCR-EHR profielen`. De samenstelling van deze FHIR-resources zijn gepubliceerd op <!-- toevoegen website --> en het package is te vinden op <!-- Simplifier.net. goede link -->. Om hier gebruik van te maken neemt het ziekenhuis contact op met fhir@iknl.nl zodat de VPN tunnel geïnstalleerd kan worden en IKNL het desbetreffende ziekenhuis als bron kan aanmerken in de private IKNL FHIR server.


### Inhoudelijke vereisten; 
De geautomatiseerde datastroom vanuit het EPD is gericht op de NKR-itemset zoals gepubliceerd op de website.

Wanneer de NKR-itemset wordt aangepast, dient de patiëntselectie hierop te worden aangepast. De historische gegevens hoeven daarbij niet te worden gewijzigd.

NKR-gegevens worden dagelijks verstuurd met een vertraging van vier weken na het eerste contactmoment van de diagnose, om te voorkomen dat vals-positieve gevallen in de registratie terechtkomen.

IKNL houdt de (meta)gegevens bij met betrekking tot de bron, het verwerkingsdoeleinde, en de herkomst van de data.


### Functionele Vereisten


 **Gegevensformaat**: De gegevens moeten worden aangeleverd in FHIR R4 JSON formaat.

**Gegevensvalidatie**: Alle aangeleverde gegevens moeten voldoen aan de validatieregels zoals gespecificeerd in de bijlage.


### Specifieke vereisten per profiel
#### NcrEhrEpisodeOfCare
- EpisodeOfCare dient altijd een diagnosegroep extensie te bevatten (max 1)
- Verplicht gebruik van de zorgverlenersinstantie en gekoppelde patiënt
- Episodestatus moet een geldige waarde bevatten (planned, active, finished, etc.)
#### NcrEhrPatient
- Identifier "patientnummer" is verplicht
- BSN niet toegestaan
- Naamstructuur met `family`, `given name` en `initials` is vereist
- Geslacht en geboortedatum zijn verplicht
#### NcrEhrProcedureEvent
- EpisodeOfCare extensie is verplicht
- Procedures moeten gekoppeld zijn aan een NcrEhrPatient en refereren naar een NcrEhrCondition
- Procedure codes moeten voldoen aan Nederlandse DBC standaard of SNOMED CT
#### NcrEhrHealthcareProvider
- Iedere zorgverlener (ziekenhuisniveau) moet een unieke AGB-code hebben
- Organisatiegegevens moeten up-to-date zijn en voorzien van geldige contactinformatie
#### NcrEhrCondition
- Diagnosescodes moeten voldoen aan de ICD-10-NL specificatie
- Lateralisatie moet worden vastgelegd indien van toepassing

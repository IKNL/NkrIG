## FHIR Implementatiegids voor de Nederlandse Kankerregistratie

### Doel implementatiegids:  

Deze implementatiegids beschrijft hoe ziekenhuizen, epd-leveranciers en andere partijen die bevoegd zijn om data uit elektronische patiëntendossiers (epd's) of andere relevante databronnen te halen,  verbinding kunnen maken met de Nederlandse Kankerregistratie (NKR). 


De gids specificeert de standaarden en vereisten voor het aanleveren van NKR-gegevens en biedt technische en inhoudelijke richtlijnen voor het verzamelen en aanleveren van gegevens aan de NKR. Met als doel: ondersteuning bij een correcte en efficiënte implementatie.


De basis van deze implementatiegids is **FHIR R4**, met profielen gebaseerd op de **Nederlandse Core (NL-core)** en de **Zorginformatiebouwstenen (zibs) versie 2020**.



### Doel Uitwisseling naar de NKR 
Door ziekenhuizen en (EPD-)leveranciers automatisch gegevens te laten koppelen met IKNL, dragen zij bij aan de doelstellingen van IKNL om meer inzicht te krijgen in oncologische zorg en de registratielast te verminderen. Projecten zoals RHONDA spelen een belangrijke rol door ziekenhuizen te ondersteunen bij deze transitie. 

Het hoofddoel is om de NKR te verbinden met andere betrouwbare databronnen. IKNL probeert dit te bereiken via geautomatiseerde koppelingen met EPD’s, waarbij data zoveel mogelijk aan de bron blijft en alleen relevante gegevens worde gedeeld. Door meer actuele gegevens te gebruiken, kunnen IKNL en onderzoekers de effectiviteit van oncologische zorg beter monitoren en evalueren.Het doel van de geautomatiseerde aanlevering aan de NKR is tweeledig: enerzijds het automatisch registreren van gestructureerde gegevens om de registratielast te verminderen, en anderzijds het versnellen van het aanleverproces.




### Achtergrond

Deze implementatiegids is specifiek gericht op de koppeling tussen zorginstellingen en de NKR. De gebruikte profielen zijn gebaseerd op zibs 2020, maar er is nog geen onderliggend informatiemodel ontwikkeld. In de toekomst kan de in ontwikkeling zijnde **informatiestandaard oncologie** als basis dienen voor een algemeen informatiemodel voor deze uitwisseling.

### Leeswijzer 
De implementatiegids is bedoeld voor zorginstellingen en leveranciers met basiskennis over de NKR en zibs-2020.

### Scope  

Deze implementatiegids beschrijft de technische en inhoudelijke vereisten voor het verzamelen en versturen van patiëntgegevens. Het doel is om dit proces op een haalbare, betrouwbare en veilige manier te laten plaatsvinden. De richtlijnen in deze gids zijn van toepassing op de elektronische aanlevering van registratiegegevens door ziekenhuizen in Nederland. De aan te leveren gegevens omvatten patiëntgerelateerde informatie <!-- hier moeten we nog wat mee, ik vind patient gerelateerde informatie zoals vastgelegd in de zibs 2020 te sterk met wat het is. Voorstel: waarbij zoveel mogelijk zibs 2020 wordt gevolgd meer richting de werkelijkheid -->


### Taal 

De implementatiegids beschrijft de technische en inhoudelijke vereisten voor het verzamelen en versturen van patiëntgegevens binnen Nederland, en is niet bedoeld voor buitenlandse partijen. Wij verwachten geen aansluiting van internationale partijen op onze FHIR-server. Mocht er desondanks behoefte zijn om deze informatie in het Engels beschikbaar te hebben, dan vernemen wij dit graag. 


### Overzicht profielen
Op dit moment zijn de volgende profielen ontwikkeld:
- `NcrEhrEpisodeOfCare`
- `NcrEhrPatient` 
- `NcrEhrProcedureEvent`
- `NcrEhrHealthcareProvider`
- `NcrEhrCondition`

 

### Must Support

De **Must Support**-markering in deze gids geeft aan welke elementen in de NKR kunnen worden verwerkt. Elementen zonder deze markering kunnen niet in de  verwerking worden meegenomen.

### Proces na Binnenkomend Bericht

Gegevens die via geautomatiseerde berichten bij de NKR worden aangeleverd, worden eerst gevalideerd en, indien nodig, gemapt op NKR-specifieke waardenlijsten. Na de validatie verrijken datamanagers de gegevens door missende gestructureerde en ongestructureerde data toe te voegen, waarmee het NKR dossier compleet wordt gemaakt.


### Gebruikte Standaarden
- FHIR R4 (https://hl7.org/FHIR/)
- NLCore Profielen op basis van zibs 2020
 


### Toekomstige uitbreidingen en aanpassingen
Dit is de eerste versie met een beperkt aantal profielen. In de toekomst zullen er meer uitbreidingen volgen om meer gegevens geautomatiseerd naar de NKR te kunnen versturen. 

### Support 

Voor meldingen over fouten bij het geautomatiseerd aanleveren van FHIR berichten op de IKNL FHIR server kan contact opgenomen worden met: meldingen.fhir@iknl.nl	 

Voor inhoudelijke opmerkingen en vragen over de profielen kan contact opgenomen worden met: FHIR@IKNL.nl 

### Referenties

- [HL7 FHIR documentatie](https://hl7.org/fhir/r4/)
- [ZIBs 2020 documentatie](https://zibs.nl/wiki/ZIB_Publicatie_2020(NL))
- [Links naar IKNL en Nederlandse Kankerregistratie](https://iknl.nl/)


 
 






## Versiebeheer 

De IG en bijbehorende packages worden gepubliceerd op https://api.iknl/nl/docs/nkr Hierbij verwijst https://api.iknl.nl/docs/nkr naar de laatste (minor versie van de laatste) major release.  

Daaronder zijn de volgende subdirectories te vinden: 

/ci-build: Laatste build van de main branch. 

/{major}: Major versie major, de laatste release van major.minor.patch 

/{major}.{minor}: Versie major.minor; verwijst naar de laatste release van major.minor.patch 

/{major}.{minor}.{patch}: Versie major.minor.patch 

Op de pagina https://api.iknl.nl/docs/nkr/history is een overzicht te vinden van gepubliceerde versies. 

 

Hierbij wordt semantic versioning op de volgende manier toegepast:  

#### MAJOR releases:  

Een nieuwe MAJOR versie wordt uitgegeven wanneer er ingrijpende wijzigingen zijn die de backward compatibility doorbreken. Daarnaast wordt een nieuwe MAJOR versie ook gebruikt in de volgende situatie:  
- Grote uitbreidingen: Wanneer er een significante hoeveelheid nieuwe profielen, use cases of functionaliteiten worden toegevoegd die substantieel genoeg zijn om een nieuwe MAJOR release te rechtvaardigen, zelfs zonder het verbreken van de backwards compatibility
- Wanneer er een strategische wijziging is, zelfs zonder het verbreken van de backwards compatibility

#### MINOR releases:  

Een nieuwe MINOR versie wordt uitgegeven wanneer er nieuwe functionaliteiten of profielen worden toegevoegd die backwards compatible zijn met de vorige versie. 

#### PATCH releases:  

PATCH versies worden uitgegeven voor kleinere, backwards compatible wijzigingen zoals: 

- Bugfixes in profielen of resources

- Correcties van fouten in de documentatie of tekstuele wijzigingen 

 
### Principes: 
- We maken maximaal twee keer per jaar een major release uit te brengen

- We verwachten van ziekenhuizen dat deze maximaal twee versies achterlopen

- We zoeken naar een manier om een testversie uit te rollen ter consultatie voor dat een nieuwe majorrelease wordt uitgebracht.  

 

### Ontwikkeling 

De broncode van deze IG wordt gepubliceerd op GitHub. Ontwikkeling vindt plaats in de main branch. Na iedere push wordt de code (via GitHub Actions) geautomatiseerd gecompileerd en gepubliceerd op /ci-build. 

Het gebruik van feature branches wordt aangemoedigd waar van toepassing. Wat een feature behelst, is ruim interpreteerbaar. Er kan, bijvoorbeeld, gedacht worden aan een branch waarin de use-case verder wordt uitgeschreven (e.g. feature/implementatiegids) of aan een branch waarin specifiek aan medicatieprofielen wordt gewerkt (feature/Medication). Feature branches worden (nog) niet automatisch gepubliceerd na commit. 

Voorafgaand aan een release van de IG/package, wordt een branch gemaakt met naam release/{version}. Bijvoorbeeld release/1.1. Hierin kan getest worden en worden eventuele (laatste) ontwikkelingen gedaan. Het kan, bijvoorbeeld, zijn dat eerst een (of meer) release candidate(s) wordt/worden uitgebracht (1.1-alpha, 1.1rc2, …) voordat de definitieve versie van 1.1 wordt gepubliceerd. Tussen deze versies kunnen meerdere commits zitten. 

Bij release/publicatie wordt een of meerdere tags gekoppeld aan de commit van de release: version/{version}. Bijvoorbeeld version/1.1 of version/2.3.1rc2. Dit genereert automatisch een nieuwe build (via GitHub Actions) voor iedere tag. Deze builds worden eveneens automatisch geüpload. Hierbij wordt het versienummer van de tag de naam van de subdirectory met de versie. Met andere woorden: de tag version/x.y.z wordt geüpload naar https://api.iknl.nl/docs/nkr/x.y.z. Er dient handmatig voor gezorgd worden dat een versie-tag op een hoger niveau wordt verplaatst. Bijvoorbeeld, als version/1.2.3 wordt uitgebracht, moeten de tags version/1 en version/1.2 worden verplaatst. 

 
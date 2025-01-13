# Films en Entertainment

## Algemene Beschrijving

De database zal dienen als de backend voor een online filmcatalogus.  Deze catalogus bevat data over films, acteurs, regisseurs, genres en ratings van gebruikers.

Het doel is om een uitgebreide database te bouwen waarmee gebruikers informatie kunnen opzoeken over films, cast- en crewleden kunnen verbinden met films en gebruikers beoordelingen en recensies kunnen
toevoegen.

## Vragen & Antwoorden

1. Voor wat gaat de database worden gebruikt?
    - Voor een online platform dat filmfans toegang biedt tot een uitgebreide filmcatalogus, met informatie zoals:
        - Titels, samenvattingen, genres, releasedata, duur, …
        - Cast en crew, inclusief acteurs en regisseurs.
        - Gebruikersbeoordelingen en recensies.
    - Gebruik wordt gemaakt van de database voor het genereren van overzichten, zoals:
        - Topfilms per genre.
        - Films met de hoogste gebruikersscores.
2. Wie zal toegang hebben tot de database?
    - Applicaties: De web- en mobiele applicaties maken directe queries om gegevens op te halen.
    - Beheerders: Kunnen data invoeren en bijwerken, zoals het toevoegen van nieuwe films of acteurs.
    - Externe API's: Voor het importeren van filminformatie van derde partijen, zoals IMDb.

## Structuur van de database

- **Movies**: Bevat details zoals titel, releasedatum, duur, samenvatting.
- **Genres**: Een film kan meerdere genres hebben.
- **Crew**: Met informatie zoals naam, geboortedatum, biografie.
- **Roles**: Verbindt crew met hun specifieke rollen (zowel voor acteurs als voor crew, denk aan componist, regisseur, custume design, …) in films.
- **UserReviews**: Beoordelingen en recensies van gebruikers.

## Features
1. Sequences
    - ID-generatoren: Sequences voor unieke ID's van films, gebruikers, en recensies. Een ID bestaat minstens uit 6  getallen, dus de eerst mogelijke ID is 100000
2. Triggers
    - Validatie: Een trigger controleert of een beoordelingsscore binnen een geldig bereik (1-10) valt.
    - Auditlog: Een trigger slaat wijzigingen in filminformatie op in een auditlogtabel.
3. Procedures
    - Toevoegen van een nieuwe film: Een procedure voor het invoeren van een film, inclusief validaties voor genres en betrokkenen. Indien een film een genre meekrijgt dat nog niet bestaat zal dit genre moeten aangemaakt worden.
4. Views
    - Topfilms per genre.
    - Films met de hoogste gebruikersscores.

## Veiligheid
1. Toegangsniveaus
    - Admin-gebruikers: Volledige toegang tot alle tabellen.
    - Contributors: Toegang om informatie toe te voegen of up te daten in de films, crew, …
    - Externe API's: Alleen-lezen toegang tot specifieke tabellen zoals films en genres.
2. Gegevenstoegang
    - Rollen en rechten: Toegang wordt gecontroleerd met specifieke rollen (API_ACCESS, CONTRIBUTOR, ADMIN).
3. Encryptie
    - Gevoelige gegevens zoals gebruikerswachtwoorden worden gehashed opgeslagen.

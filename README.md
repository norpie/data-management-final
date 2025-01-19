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

## Bronnen

### Copilot

Er werd gebruik gemaakt van Github Copilot tijdens het schrijven van de SQL-code.

### ChatGPT

- https://chatgpt.com/share/678cf0c7-5b78-8002-b3bc-65f5e0c3c005
- https://chatgpt.com/share/678cf0d8-9a68-8002-99cb-e33f06286160
- https://chatgpt.com/share/678cf0ea-bad0-8002-a769-8a538f23ee0d
- https://chatgpt.com/share/678cf0f6-2fb4-8002-b467-d5d516337c19
- https://chatgpt.com/share/678cf104-8514-8002-b03a-5bdeddb72142
- https://chatgpt.com/share/678cf112-c630-8002-9399-7efe0d934e96
- https://chatgpt.com/share/678cf122-08f0-8002-95fe-db027d6655e9
- https://chatgpt.com/share/678cf129-930c-8002-8a9d-f1b8d7ec95c8
- https://chatgpt.com/share/678cf130-37d8-8002-82d5-0d23b1796399
- https://chatgpt.com/share/678cf136-e8ec-8002-b443-087e7c7827e6
- https://chatgpt.com/share/678cf13f-efd0-8002-bf5d-c08d79b3a912

### Claude

Claude voorziet geen deelbare link, dus een JSON-export is beschikbaar in de `sources` directory als `claude.json`.

[claude.json](sources/claude.json)

### Websites

- [http://dev.mysql.com/doc/refman/5.5/en/password-logging.html](http://dev.mysql.com/doc/refman/5.5/en/password-logging.html)
- [http://dev.mysql.com/doc/refman/5.6/en/password-logging.html](http://dev.mysql.com/doc/refman/5.6/en/password-logging.html)
- [https://dba.stackexchange.com/questions/76788/create-a-mysql-database-with-charset-utf-8](https://dba.stackexchange.com/questions/76788/create-a-mysql-database-with-charset-utf-8)
- [https://dev.mysql.com/doc/en/create-database.html](https://dev.mysql.com/doc/en/create-database.html)
- [https://dev.mysql.com/doc/en/encryption-functions.html](https://dev.mysql.com/doc/en/encryption-functions.html)
- [https://dev.mysql.com/doc/en/grant.html](https://dev.mysql.com/doc/en/grant.html)
- [https://dev.mysql.com/doc/en/mysql.html](https://dev.mysql.com/doc/en/mysql.html)
- [https://dev.mysql.com/doc/en/set.html](https://dev.mysql.com/doc/en/set.html)
- [https://dev.mysql.com/doc/mysql-security-excerpt/5.7/en/password-hashing.html](https://dev.mysql.com/doc/mysql-security-excerpt/5.7/en/password-hashing.html)
- [https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-extension-objects-create.html](https://dev.mysql.com/doc/mysql-shell/8.0/en/mysql-shell-extension-objects-create.html)
- [https://dev.mysql.com/doc/refman/5.5/en/password-logging.html](https://dev.mysql.com/doc/refman/5.5/en/password-logging.html)
- [https://dev.mysql.com/doc/refman/5.6/en/password-logging.html](https://dev.mysql.com/doc/refman/5.6/en/password-logging.html)
- [https://dev.mysql.com/doc/refman/8.0/en/charset-server.html](https://dev.mysql.com/doc/refman/8.0/en/charset-server.html)
- [https://dev.mysql.com/doc/refman/8.2/en/set-default-role.html](https://dev.mysql.com/doc/refman/8.2/en/set-default-role.html)
- [https://dev.mysql.com/doc/refman/8.4/en/connecting.html](https://dev.mysql.com/doc/refman/8.4/en/connecting.html)
- [https://dev.mysql.com/doc/refman/8.4/en/create-database.html](https://dev.mysql.com/doc/refman/8.4/en/create-database.html)
- [https://dev.mysql.com/doc/refman/8.4/en/create-role.html](https://dev.mysql.com/doc/refman/8.4/en/create-role.html)
- [https://dev.mysql.com/doc/refman/8.4/en/encryption-functions.html](https://dev.mysql.com/doc/refman/8.4/en/encryption-functions.html)
- [https://dev.mysql.com/doc/refman/8.4/en/grant.html](https://dev.mysql.com/doc/refman/8.4/en/grant.html)
- [https://dev.mysql.com/doc/refman/8.4/en/mysql.html](https://dev.mysql.com/doc/refman/8.4/en/mysql.html)
- [https://dev.mysql.com/doc/refman/8.4/en/password-logging.html](https://dev.mysql.com/doc/refman/8.4/en/password-logging.html)
- [https://dev.mysql.com/doc/refman/8.4/en/password-management.html](https://dev.mysql.com/doc/refman/8.4/en/password-management.html)
- [https://dev.mysql.com/doc/refman/8.4/en/roles.html](https://dev.mysql.com/doc/refman/8.4/en/roles.html)
- [https://dev.mysql.com/doc/refman/8.4/en/set-default-role.html](https://dev.mysql.com/doc/refman/8.4/en/set-default-role.html)
- [https://dev.mysql.com/doc/refman/8.4/en/set.html](https://dev.mysql.com/doc/refman/8.4/en/set.html)
- [https://dev.mysql.com/doc/refman/8.4/en/set-variable.html](https://dev.mysql.com/doc/refman/8.4/en/set-variable.html)
- [https://dev.mysql.com/doc/refman/en/set-variable.html](https://dev.mysql.com/doc/refman/en/set-variable.html)
- [https://dev.mysql.com/doc/search/?d=371&p=1&q=hash](https://dev.mysql.com/doc/search/?d=371&p=1&q=hash)
- [https://dev.mysql.com/doc/search/?d=371&p=1&q=hash+salt](https://dev.mysql.com/doc/search/?d=371&p=1&q=hash+salt)
- [https://dev.mysql.com/doc/search/?d=371&p=1&q=password](https://dev.mysql.com/doc/search/?d=371&p=1&q=password)
- [https://dev.mysql.com/doc/search/?d=371&p=1&q=salt+hash](https://dev.mysql.com/doc/search/?d=371&p=1&q=salt+hash)
- [https://dev.mysql.com/doc/search/?q=salt+hash&d=371&p=2](https://dev.mysql.com/doc/search/?q=salt+hash&d=371&p=2)
- [https://gist.github.com/miratcan/4276757](https://gist.github.com/miratcan/4276757)
- [https://gist.github.com/spalladino/6d981f7b33f6e0afe6bb](https://gist.github.com/spalladino/6d981f7b33f6e0afe6bb)
- [https://hub.docker.com/_/mysql](https://hub.docker.com/_/mysql)
- [https://medium.com/@elaurichetoho/unlock-the-power-of-docker-effortlessly-run-mysql-and-phpmyadmin-containers-for-seamless-database-3d56fd496c4d](https://medium.com/@elaurichetoho/unlock-the-power-of-docker-effortlessly-run-mysql-and-phpmyadmin-containers-for-seamless-database-3d56fd496c4d)
- [https://stackoverflow.com/questions/14148880/how-do-i-reference-a-foreign-key-to-serial-datatype](https://stackoverflow.com/questions/14148880/how-do-i-reference-a-foreign-key-to-serial-datatype)
- [https://stackoverflow.com/questions/16165423/declare-and-set-not-recognized-syntax-for-my-sql-server](https://stackoverflow.com/questions/16165423/declare-and-set-not-recognized-syntax-for-my-sql-server)
- [https://stackoverflow.com/questions/16287559/mysql-adding-user-for-remote-access](https://stackoverflow.com/questions/16287559/mysql-adding-user-for-remote-access)
- [https://stackoverflow.com/questions/16969060/mysql-error-1215-cannot-add-foreign-key-constraint](https://stackoverflow.com/questions/16969060/mysql-error-1215-cannot-add-foreign-key-constraint)
- [https://stackoverflow.com/questions/18930084/mysql-error-1215-hy000-cannot-add-foreign-key-constraint](https://stackoverflow.com/questions/18930084/mysql-error-1215-hy000-cannot-add-foreign-key-constraint)
- [https://stackoverflow.com/questions/20295778/how-to-use-bcrypt-algorithm-within-encrypt-function-in-mysql-for-verifying-p](https://stackoverflow.com/questions/20295778/how-to-use-bcrypt-algorithm-within-encrypt-function-in-mysql-for-verifying-p)
- [https://stackoverflow.com/questions/23278565/salting-and-hashing-passwords-in-mysql](https://stackoverflow.com/questions/23278565/salting-and-hashing-passwords-in-mysql)
- [https://stackoverflow.com/questions/25852239/collation-utf8-general-ci-is-not-valid-for-character-set-latin1](https://stackoverflow.com/questions/25852239/collation-utf8-general-ci-is-not-valid-for-character-set-latin1)
- [https://stackoverflow.com/questions/26578313/how-do-i-create-a-sequence-in-mysql](https://stackoverflow.com/questions/26578313/how-do-i-create-a-sequence-in-mysql)
- [https://stackoverflow.com/questions/28389458/how-to-execute-mysql-command-from-the-host-to-container-running-mysql-server](https://stackoverflow.com/questions/28389458/how-to-execute-mysql-command-from-the-host-to-container-running-mysql-server)
- [https://stackoverflow.com/questions/3029321/troubleshooting-illegal-mix-of-collations-error-in-mysql](https://stackoverflow.com/questions/3029321/troubleshooting-illegal-mix-of-collations-error-in-mysql)
- [https://stackoverflow.com/questions/3544322/how-to-use-an-auto-incremented-primary-key-as-a-foreign-key-as-well](https://stackoverflow.com/questions/3544322/how-to-use-an-auto-incremented-primary-key-as-a-foreign-key-as-well)
- [https://stackoverflow.com/questions/36617682/docker-compose-mysql-import-sql](https://stackoverflow.com/questions/36617682/docker-compose-mysql-import-sql)
- [https://stackoverflow.com/questions/37667064/boolean-type-on-mysql](https://stackoverflow.com/questions/37667064/boolean-type-on-mysql)
- [https://stackoverflow.com/questions/45729326/how-to-change-the-default-character-set-of-mysql-using-docker-compose](https://stackoverflow.com/questions/45729326/how-to-change-the-default-character-set-of-mysql-using-docker-compose)
- [https://stackoverflow.com/questions/47007179/bcrypt-password-compare-function-always-return-false](https://stackoverflow.com/questions/47007179/bcrypt-password-compare-function-always-return-false)
- [https://stackoverflow.com/questions/5016505/mysql-grant-all-privileges-on-database](https://stackoverflow.com/questions/5016505/mysql-grant-all-privileges-on-database)
- [https://stackoverflow.com/questions/9596652/how-to-escape-apostrophe-a-single-quote-in-mysql](https://stackoverflow.com/questions/9596652/how-to-escape-apostrophe-a-single-quote-in-mysql)
- [https://www.atlassian.com/data/admin/how-to-grant-all-privileges-on-a-database-in-mysql](https://www.atlassian.com/data/admin/how-to-grant-all-privileges-on-a-database-in-mysql)

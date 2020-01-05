# CentoDiciotto

Managing an Health Service has never been easier.

Meet CentoDiciotto, a full-fledged platform that puts you in control of your health and your healthcare services.

[Please read the PDF assignment for project information](docs/ProgettoWeb.pdf).

## Description

CentoDiciotto lets *Patient*s, *General Practitioner*s, *Specialized Doctor*s, *Chemist*s, and *Local Health Service*s to sign up and interact with the system.

Each account role has a predefined set of permissions that are listed below. The only common feature to all roles is password management (changing and resetting passwords).

All roles upon creation beside *Specialized Doctor*s are mapped to a specific Province (please visit [this page](https://it.wikipedia.org/wiki/Province_d%27Italia) for information about Italian Provinces) that may not be changed, and restricts their operations (e.g. choosing a different *General Practitioner*, reading a *Patient*'s information) to the Province itself.

All notifications are delivered as emails to all roles.

* **Patient**
    * Upload and change profile photo
    * Change one's own *General Practitioner*
    * Book a visit from his *General Practitioner*
    * Read visit reports and history from his *General Practitioner*
    * See pending drug prescriptions with an option of downloading a PDF version to be shown at a *Chemist*'s
    * Book exams from *Specialized Doctor*s or *Health Service*s (only for prescripted ones)
    * Read exam results and history from *Specialized Doctor*s
    * Pay pending tickets for drug prescriptions and exams and browse the history of previously paid tickets
* **General Practitioner**
    * Browse one's current patient list
    * Choose a date and time and confirm a booking for a visit
    * Insert a report for a visit
    * Submit a drug prescription or exam prescription to a *Patient*
* **Specialized Doctor**
    * Browse all patients in the system
    * Choose a date and time and confirm a booking for an exam
    * Insert a result for an exam
* **Chemist's**
    * Browse all patients in the Province
    * Supply drugs by browsing active prescriptions by patient or scanning a PDF prescription
* **Local Health Service**
    * Browse all patients in the Province
    * Generate reports by day listing visits, exams, and drug prescriptions with paid and unpaid tickets
    * Generate recalls, automatically inserting an exam prescription into *Patient*s meeting a certain criteria
      
## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

- ### Preparation

  1. **Clone** this repo on your host using [Git](https://git-scm.com)

     ```console
     $ git clone https://github.com/mfranzil/centodiciotto.git
     ```

  2. **Change** current working **directory**

     ```console
     $ cd CentoDiciotto
     ```

  3. Create the war file

     ```console
     $ mvn clean install package
     ```

  4. Change current directory

     ```console
     $ cd target
     ```

  5. Copy the war file **CentoDiciotto.war** into the folder **CATALINA_HOME/webapps**

     ```console
     $ cp CentoDiciotto.war CATALINA_HOME/webapps
     ```

  6. Change current directory
  
     ```console
     $ cd CATALINA_HOME/bin
     ```
     
  7. Start Tomcat server

     ```console
     $ startup.sh
     ```

- ### Restore the database backup

  > Please change **database.properties** before you start the database

- Create the database

  1. Open the SQL Shell
  2. Provide the data requested
  3. Enter the command

     ```console
     $ CREATE DATABASE [name]
     ```

     > Where [name] is the database name provided in **database.properties**

  4. Open command line window
  5. Go to PostgreSQL bin folder

     ```console
     $ PG_HOME/bin
     ```

  6. Restore the database
     ```console
        $ psql -U [username] -d [name] -f backup.sql
     ```

## Resource files

Two resource files are required for this project. Please place them into `src/main/resources` and update them appropriately.

### database.properties

> A PostgresSQL database is required in this current version. Please change the JDBC driver accordingly if you wish to use a different service.
```
HostName=
UserName=
DefaultDatabase=
Password=
```

### email.properties

> A Gmail account is currently used in this version. Other email providers should work without extra modifcations.
```
smtp-hostname=
smtp-port=
smtp-username=
smtp-password=
```

## Requirements

The following is a list of requirements for the project.

### Environments

- [Java](https://www.java.com) `version == 11`
- [Maven](https://maven.apache.org/) `version == 3.6.0`
- [Tomcat](https://tomcat.apache.org) `version == 9.0.27`

### Maven Dependencies

- Apache Commons Text `org.apache.commons:commons-text:1.8`
- JavaX Mail `com.sun.mail:javax.mail:1.6.2`
- JSTL `jstl:jstl:1.2`
- JavaEE Web Api `javax:javaee-web-api:7.0`
- Apache PDFBox `org.apache.pdfbox:pdfbox:2.0.16`
- Boxable `com.github.dhorions:boxable:1.5`
- JXLS `org.jxls:jxls:2.7.0`
- JXLS POI `org.jxls:jxls-poi:1.3.0`
- Postgres JDBC Driver `org.postgresql:postgresql:42.2.8.jre7`
- GLXN QRCode Generator `net.glxn:qrgen:1.4`
- Google Gson `com.google.code.gson:gson:2.8.5`
- SLF4J `org.slf4j:slf4j-api:1.7.10`

## Authors

- **Matteo Franzil** - _Initial work_ - 192198
- **Simone Nascivera** - _Initial work_ - 193246
- **Francesca Annibaletti** - _Initial work_ - 192735
- **Alessia Marcolini** - _Initial work_ - 194274

## License

This project is licensed under the MIT License - see the [LICENCE](LICENCE) file for details

© CentoDiciotto 2020

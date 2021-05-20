# CentoDiciotto

Managing an Health Service has never been easier.

Meet CentoDiciotto, a full-fledged platform that puts you in control of your health and your healthcare services.

[Please read the PDF assignment for project information](project-spec.pdf).

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

These instructions will get you a copy of the project up and running on your local machine for development and testing
purposes. First, clone this repo on your host using [Git](https://git-scm.com).

## Adding properties files

The following resource files are required for this project. Please place them into `src/main/resources`.

### database.properties

A PostgresSQL database is required. Please change the JDBC driver accordingly if you wish to use a different service.

```text
HostName=
UserName=
DefaultDatabase=
Password=
```

### email.properties

Gmail users should take extra caution due to the "Insecure apps" settings that might interfere with the package. Please log in as the Gmail account and authorize the usage of non secure apps before trying to start up the server. Other email providers should work without extra modifcations.

```text
smtp-hostname=
smtp-port=
smtp-username=
smtp-password=
```

### resource-server.properties

This file defines connections to a RESTful web service (by default: OpenStack Swift) for retrieving content originally
stored in the `/img, /xls, /pdf` folders.

These are the fields for the file:

```text
resource_server=
authentication_server=
name=
password=
project=
```

## Adding resource files

As of version `2.0.0` resource files have been delocalized, removed from the repository, and HTTP requests were added to
the code along with an automated authentication token request. Please add to your resource server, set up in the
previous paragraph, all the following file tree (available in the `rs` folder):

```text
.
├── img
│   ├── avatars
|   |   └── (all the required images for the database. default: blank)
│   ├── classes
│   │   ├── chemist.png
│   │   ├── general_practitioner.png
│   │   ├── health_service.png
│   │   ├── patient.png
│   │   └── specialized_doctor.png
│   ├── landing-page-bg.jpg
│   ├── login_white.png
│   ├── logo_blue.svg
│   ├── logo_white.svg
│   ├── logout_white.png
│   ├── portfolio
│   │   ├── 1.jpg
│   │   ├── 2.jpg
│   │   ├── 3.jpg
│   │   ├── 4.jpg
│   │   ├── 5.jpg
│   │   └── 6.jpg
│   └── prescription.png
├── pdf
│   └── codice_comportamento.pdf
└── xls
    └── report.xlsx
```

## Building the project (`2.0.0`)

Version `2.0.0` and newer have been ported to Docker. Please follow these instructions in order to finalize the
deployment.

### Setting up the database

The `sql` folder contains a Dockerfile and two files, `11_pre.sql` and `13_post.sql`. Two files are excluded from the
repository for confidential purposes:

- `10_init.sql`
- `12_data.sql`

The former MUST contain an initialization string for a Postgres role, such as:

```
CREATE ROLE "sqldiciotto" WITH SUPERUSER CREATEDB CREATEROLE LOGIN ENCRYPTED PASSWORD 'blabla';
```

The latter may be excluded, and it contains preliminary data to be added to tables.

### Building Java/Tomcat files

Finally, build the project using

```console
mvn clean install package
```

Make sure that the obtained `war` file is in the same folder as the Dockerfile for the web server.

### Deploying containers

Once the above steps are done, execute the two Dockerfiles. Once built, set them up in a proper Docker or Kubernetes
environment with networking (e.g. with bridges, Ingress, etc..) and it's all set.

## Requirements

The following is a list of requirements for the project.

### Environments

* [Java](https://www.java.com) `version == 16`
* [Maven](https://maven.apache.org/) `version == 3.8.1`
* [Tomcat](https://tomcat.apache.org) `version == 10.0.6`

### Maven Dependencies

* JakartaEE Web Platform `jakarta.platform:jakarta.jakartaee-api:9.0.0` (provided)
* Jakarta JSTL API `org.glassfish.web:jakarta.servlet.jsp.jstl:2.0.0`
* Jakarta Mail `com.sun.mail:jakarta.mail:2.0.1`
* Apache Commons Text `org.apache.commons:commons-text:1.8`
* Apache HTTPClient `org.apache.httpcomponents:httpclient:4.5.13`
* Apache PDFBox  `org.apache.pdfbox:pdfbox:2.0.16`
* Boxable `com.github.dhorions:boxable:1.5`
* JXLS `org.jxls:jxls:2.7.0`
* JXLS POI `org.jxls:jxls-poi:1.3.0`
* Postgres JDBC Driver `org.postgresql:postgresql:42.2.20`
* GLXN QRCode Generator `net.glxn:qrgen:1.4`
* Google Gson `com.google.code.gson:gson:2.8.5`
* SLF4J `org.slf4j:slf4j-api:1.7.10`

## Authors

* **Matteo Franzil** - _Initial work_ - 192198
* **Simone Nascivera** - _Initial work_ - 193246
* **Francesca Annibaletti** - _Initial work_ - 192735
* **Alessia Marcolini** - _Initial work_ - 194274

## License

This project is licensed under the MIT License - see the [LICENCE](LICENCE) file for details

`© CentoDiciotto 2021`

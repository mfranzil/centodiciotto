In order to dump the database, please create a new database called "centodiciotto" in your postgres psql console:
~~~~ bash
psql

create database centodiciotto;
~~~~

Then exit and insert all the records:

~~~~ bash
psql centodiciotto < dump.sql
~~~~
Where dump.sql is the file located in the same directory as this one.

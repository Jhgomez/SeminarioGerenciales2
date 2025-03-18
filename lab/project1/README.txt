docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=abcdeF1+" \
-p 1433:1433 --name sql1 --hostname sql1 \
-d \
-v 'C:\Users\Juan Enrique\seminario2\lab\project1\ArchivosdeentradaProyecto':/usr:rw \
mcr.microsoft.com/mssql/server:2022-latest
/opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "abcdeF1+" -No

Postgres automatically creates 'postgres' db if the user defines another like in the below commands this default db will be actually have nothing and no privileges 

docker run --name seminario_postrgres \
	-e POSTGRES_USER=edgar \   # if not set default value will be used, "postgres"
	-e POSTGRES_PASSWORD=1234567A \
	-e POSTGRES_DB=edgar \ # if not set value will be the same as "POSTGRES_USER"
	-p 5432:5432 \
	-v 'C:\Users\Juan Enrique\seminario2\lab\project1\ArchivosdeentradaProyecto':/home:rw \
	-d postgres

download postgres odbc(setup.exe)

https://www.postgresql.org/ftp/odbc/releases/REL-17_00_0004-mimalloc/

List databases
```
SELECT datname FROM pg_database
WHERE datistemplate = false;
```

Other option is to start psql in container command line, login to user
```
pslq -U edgar -W 1234567A
```

run this command
```
\l
```

In order to use an specific database from any connection make sure you specify the database you want to work with in that connection, this means you can not swith with SQL commands to another database when running form a db manager like DBeaver, you can only select the db when connecting to postgres


Download PostgreSQL and only install `command line tools`
https://www.postgresql.org/download/windows/

This tool only helped me understand what was wrong with the query, it turns out that when doing this `COPY` command, if you execute it from "dbbeaver" or "pgdmin" it will not complain about enconding but if I execute it from SSIS or using the "psql" command line tool I installed in previous step I will get an error, in SSIS because it is doesn't work great with these type of connections I will get an error and the "result set" won't know how to parse it but if I "debug" trying to execute same command using from command line with this command `export PGPASsWORD=1234567A && psql.exe -h localhost -p 5432 -d edgar -U edgar -c "COPY compras_temp FROM '/home/SGFood02.comp' WITH  (FORMAT text, HEADER true, DELIMITER '|');"` I will then get more info about what went wrong, in this case is some Spanish characters(tilde) which can not be encode/decode because encoding is not configured to work  with these type of characters, so after investigating I found the most easy and simple way to specify a proper encoding standard
```
# works in db managers but not in git bash or command line in windows
COPY compras_temp FROM '/home/SGFood02.comp' WITH  (FORMAT text, HEADER true, DELIMITER '|');

# works everywhere
COPY compras_temp FROM '/home/SGFood02.comp' WITH  (FORMAT text, HEADER true, DELIMITER '|', ENCODING 'UTF8');
```

Funny thing is that if I add this `export PGPASsWORD=1234567A && psql.exe -h localhost -p 5432 -d edgar -U edgar -c "COPY compras_temp FROM '/home/SGFood02.comp' WITH  (FORMAT text, HEADER true, DELIMITER '|');" > error.txt` it will encode the file correctly, and this gives me other option inside my SSIS project, I could store this in a bash script and use a "Execute Process task", the advantage of using this process is that we can get a log more easily

# Inserting Unicode characters to sql server
At first I was using this command
```
BULK INSERT dbo.compras_temp
FROM '/home/SGFood01.comp'
WITH (
  FIELDTERMINATOR = '|', 
  ROWTERMINATOR = '0x0a',
  FIRSTROW = 2,
)
```

But then realized Spanish "tildes" where not being parsed correctly, after some search I found this command
```
BULK INSERT dbo.compras_temp
FROM '/home/SGFood01.comp'
WITH (
  FIELDTERMINATOR = '|', 
  ROWTERMINATOR = '0x0a',
  FIRSTROW = 2,
  CODEPAGE = '65001'
)
```

Code page "65001" is basically "UTF-8" but in linux SQL server doesn't support this feature yet(my docker desktop container is running using linux) so after investigating I found that UTF-16 is supported and that way I can insert Unicode characters. I had to parse the original file but first, using git bash in Windows, I check file info
```
file SGFood01.comp
```

If it is using UTF-8 I can run the following command using the bash utility `iconv` to parse it to UTF-16
```
echo -ne '\xFF\xFE' > SGFood01-16.comp   # this is the EOF character
iconv -f UTF-8 -t UTF-16LE SGFood01.comp >> SGFood01-16.comp
```

And now the insert command will change to
```
BULK INSERT dbo.compras_temp
FROM '/home/SGFood01-16.comp'
WITH (
  DATAFILETYPE = 'widechar',
  FIELDTERMINATOR = '|', 
  ROWTERMINATOR = '\n',
  FIRSTROW = 2
)
```

Repeat same process with sales(ventas) file
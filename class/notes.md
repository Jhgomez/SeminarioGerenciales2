# Class 1(27/1/25)

What is database normalization? Is removing duplicates in a DB. Is a teqnique to avoid redundancy in a DB. You have to apply at least 4 rules to a DB to make sure it is normalized. This help us accomplish data integrity, reduces maintenance costs, but it also implies a cost so you have to decide when it is worth making this effort. If duplicates exists in a DB is most likely an application issue since is the application that is interacting with the DB, the DB is just making what it is told to do, but if we removed duplication we remove inconsistency since deleting, reading, updating data, correctness is not guaranteed, but also we make our operations more efficient. Be aware that when making relational queries, meaning a join in a select, a third table is generated which contains two tables or more info, and the most expensive operation in a DB is "joning" information, but is even more expensive an "inner join" and similar operations and when a third table is created and we want to read from it, it will actually need to get the info from its parent tables, so removing duplication, normalizing data, could make reads way more expensive, that is why we need to evaluate the tradeoffs and see if normalization is worth and/or required. All `where` operations in a select, in most of databases actually implies a join operation. Be aware that the most inefficient key type to use in a DB is a text to indexing a database. To make reads more efficient we'd have to reduce the number of tables it needs to read to get info, so with duplicated information, meaning without normalizing, we could optimize read transactions/operations and this is safe to do if we design our apps to safely do this.

We could say there is two types of applications, **first the one that makes transactional operations**, their purpose or goal is to maximize performance of Create, Update, Delete, Insert operations.  **Second is "Reading" applications(aplicaciones que hacen consultas)** their goal is to optimize readings even if deletes, updates, inserts are slower. It really depends on the focus of your application, for example if a supermarket has SAP system, SAP systems are ERP(enterprise resource planning) systems, and the cashiers need to read prices here we would only read info from one table so normalizing this database makes sense, the selects that it is making to read info are of operative type instead of analytic type which has to get more info from other places. In the same context(a supermarket's system), if we need to make a more analytic analysis like to know what is the most popular item based on how many units are sold in a period of time using cross elasticity of purchase(elasticidad cruzada de la demanda), this refers to calculation index that is produced by analyzing a products combination in a purchase bill/receipt/invoice, for example checking how many toothpaste is sold and drawing a relation between that number to the number of toothbrushes sold, or comparing alternative options like checking how much cocacola was sold vs how much pepsi was sold, and in this type of approach we need to optimize read operations, so we can generate, for example, daily percentage versus comparison as well as a monthly comparison, separate them for storage location and or by client type, etc.

In conclusion it is not recommended to do data analysis using a normalized DB which purpose is to do transactional processing. If we want to create a DB for a "reading" app that is going to do analytics you can stablish and select a DB, DB design and data architecture that optimizes reading queries according to the behavior of the data that is going to be selected. You can have both types of applications living in a system

Analytics use a three phase computing process called ETL(Extraction, transform, load), where data is extracted from an input source, transformed and then loaded into an output container. Analytics also uses "replication" tools, these tools are in charge to replication data from one DB in another DB. Analytics uses virtualization processes also, but most commonly is ETL and replication process.

## Reading Applications/DBs Best Configuration(used to make analytics)
* It should not be normalized

* Use primary keys of integer type(whole numbers) AKA Surrogate or substitute key(llave surrogada/ sustituta). Surrogated keys are created to substitute primary keys that are not of integer(whole number) type such as an alphanumeric key, this surrogated key could be the register key which most traditional relational DBs, like SQL, generate automatically on every entry

## Storage in a DB(DB engine vs Storage)
In a DB the DB engine and the storage are separated, when we refer to a DB when, for example, saying "the DB is great", we are referring to the DB engine. 

In a "personal"/"home" configuration the DB engine and the storage are installed in the same "space", the disk. However in a real world scenario it doesn't work like that, the storage and the engine live in a separated environment. 

In a real world scenario the storage, just as an example, lives in a SAN(storage area network). SAN basically are an array/group of disks that are configured in a network to make sure data is not lost and is available at network level so that the DB engine, which should be installed in its own server(DB server) can interact with the storage. In the past they were considered to be the same(db engine and storage) but it is not the case now. To make the engine very performant we need things like a powerful processor and memory while the storage part is focused on its integrity and to be failure proof, for example if a disk messes up the administrator can take it out in hot(en caliente) and replace it with a new one, so we should aim to make it reliable and the storage component should have a good response time. For example a part of the storage could live in High Performance Ultra Disk(practically RAM) which are very expensive, and some other part of the storage could live in traditional storages like SAN this could be historical information or it could it even live in the cloud in something like AWS S3 buckets or Azure object storage, or IBM object storage, or it could even be mixed/hybrid, some storage is on premise and other is on cloud, the storage could also be living as files such as "parquet files" which are high organized files. 

Note: Hadoop is an apache collection of software used in distributed computing that in the past used HDFS to store files it could be considered the predecessor of "parquet files"

Decoupling the DB engine and the storage is a fairly new approach to placing DB components, this lets us optimize each component even more and more easily. An example of Cloudera is built using tools like Hadoop, Cloudera is a data lake platform for data analytics, data engineering and machine learning, since it uses Hadoop it is capable of processing large datasets across clusters of computers. Hadoop started making this separation and Cloudera also follows this approach as well as pretty much all cloud storage tools does the same nowadays to get more performance, but this approach is more focused on benefiting analytics processing since they process larger datasets and very variable types of data in combination while transactional operations are less variable in the sense of the type of data they work usually is not that wide, analytics can analyze text, video, numbers and a lot of types in the same dataset

## Types of DB's

* Relational

* Multidimensional: They built a cube of information, it has to have three or more dimensions, if we'd only have two dimension is a matrix, if we have three dimensions is a cube or vector. They can have more dimensions and are called cubes even if they have more dimensions

## TODO
Investigate these concepts:

* data federation
* B-tree and Hash indexation, [this](https://peerdh.com/es/blogs/programming-insights/comparing-b-tree-and-hash-indexing-for-performance-optimization-1) is a comparison between these two



 

 
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

# Class 1(3/2/25)

* Appliance: Is a PC or hardware used to host a DB. This "server" has special boards called FPGA that has specialized chips to do databases processing, so this in combination with software is a specialized solution for DB processing. I usually installed on premise. This is really design to handle large amounts of data so be careful when using them as it may be to much power for just a simple task or small DB, they can be specialized in Analytical or transactional databases
 
* Crosstab: In a dashboard context these are dynamic tables that can filter info

## Multidimensional Cubes

* Dimensions: They are analysis points of view. All dimensions are hierarchies for example in a sales history DB it would have, date, month, client name, product name. They ar the element by which we analyze metrics. Dimensions usually are of type text but they can be numerical

* Metrics: Usually they are number or operations like multiplying number of articles sold by price, that would be a calculated metric.

## Analysis Data Models
Data models are used to denormalize any source of data with the purpose of making it more performant for data analytics. 

* Datamart: Is how we identify the dimensions and metrics to create a data model. It's physical structure is a data model(star model, snow flake, )

* Datawarehouse: Is formed by a lot of Datamarts and is where all the info will live, so this component might be the most important in a "business intelligence" solution implementation.

To learn more about "datamart" and "datawarehouse" and how the data warehouse are denormalized see [here](https://www.youtube.com/watch?v=jFsRdTcljeU) and [here](https://www.youtube.com/watch?v=Ko-GKlHMVcU)

### Star Model

At center it has a table called "FACT" table(tabla de hechos) which contains metrics, and is surrounded by dimensions, each represented individually. Dimensions connect to the FACT table using a surrogated key/substitute key that allows us to stablish correlations. For example in a list of sales history I have a dimension/column with the product name, and I want to create a surrogated key for each I would to something like

| Product |
| ------- |
| Shoe |
| Food |
| Drink |
| Toy |

They will be given a surrogated key, so the product dimension will look like

| Surrogated_Key | Product |
| -------------- | ------- |
| 1 | Shoe |
| 2 | Food |
| 3 | Drink |
| 4 | Toy |

As mentioned before at the center of the models there is a FACT table, a FACT is an event that happens in a specific time point and the tables around it are dimension's tables, and the dimensions are all the properties that describe the FACT, we can think of a FACT as an event that happened. Dimension's tables are 'descriptive containers' and the fact and the FACT stores all the keys of the dimensions that give sense to a FACT/event. A dimension can have additional attributes, meaning we can add attributes to dimensions and they can be associated to any of the dimension's levels.

Information is extracted using an ETL tool and then it is inserted to a datawarehouse which is formed by datamarts that uses either the star, snowflake or any other data model. The data then is read using reporting tools like "poweBi", SAP's systems "business logic", "click view", Salesforce's "tableau" and from these tools some of them has the purpose of making dashboards easy and other has the purpose of doing enterprise analysis like  

### Snowflake Model(Copo de Nieve)
In the star model we usually denormalize data we get from a normalize source like a transactional DB in the operational side of an architecture but in the snowflake model the data is usually kept in its normalized form. 

Sometimes a Datawarehouse can have datamarts that implement both models, some datamarts will implement a star model while other will implement snowflake model. It can happen that some levels of the hierarchy are denomalized and other levels are kept normalized and that would be a starflake model


# Class (10 feb 2025)

## Tools to make graphs and reports or Dashboards

PowerBi, Cognos Analytics, Business objects, Tableu, ClickView or Quickview

Tools like PowerBi depend on the data mart(snowflake or star model) and multidimensional cubes to create the dashboard that means those components have to be some way designed to be able to create a dashboard but tools like Cogno Analytics and Business Objects are more flexible because you have to create some "adapter" layer, this means it might require more work and time to set up a dashboar using those tools but they are more flexible, this way you can connect to your data marts and dimensional cubes without have to modify them. Cognos make some intelligent analysis so you can ask it to create a graphic from a data source in just natural language, it is very intelligent which is something powerBi doesn't do

## Descriptive Analytics

### Data Models
There is always one or more fact tables, and each fact table is surrounded by dimension tables

### Fact Tables
They contain all the dimension tables primary keys and all metrics

### Dimension Tables
In a three level dimension "products" model context, Levels are: Product : 1) category, 2) line 3) SKU, we would need at least the following fields/columns. 

This would be just one level dimension, maybe we would use it if we wanted a star model

SK(primary surrogated key, this is referred in the fact table), SKU_code, SKU_description, line_code, line_desc, category_code, category_description

But if we want to have a three level dimension model because we are maybe wanting to create a snowflake model we would do arrange the three levels like the following

Level one(SKU)

SK, SKU_code, SKU_description, SKL(key to be able to connect line table)

Level two(Line)
SKL, line_code, line_desc, SKC(key to be able to connect code table)

Level Three(Code)
SKC, code_category, code_description

## Analysis cycles
There is different analytics types/phases in an analytics lifecycle. See "analytics lifecycle" picture to see picture to get more info

## Tools to make ETL
IBM InfoSphere DataStage, Oracle Integration Cloud Service

## CDC(Change Data Capture)
Is making a copy of some part of the info in the transactional DBs to another area and then take it to the analytical side. Sometimes it can substitute the ETL process

### Tools to make CDC copies
Almost all DBs has a tool to make CDC replicas, advantage of making these replicas instead an ETL is that they are executed in real time. In the transaction data bases(our data source) an agent is added, this agent is monitoring activity in the DB, then you can ask the agent to make a copy of a table in the DB, it is monitoring all updates and inserts and deletes and when it captures any of these actions and when that happens it copies it into the repica that lives in another server which is on the "side" of the data warehouse(this assumes our architecture separates between the transactional servers and applications and the data warehouse components), this allows to have a replica of a table in real time, to avoid these agents having a performance overhead on the database performance is just monitoring database logs, it monitors all audit logs which can tell what has changed. The copy of the table usually is part of our stage area or it is part of the ODS(operational data storage), an ODS is also a copy of a model from the transactional side that lives in the data warehouse side. Some benefits of this is that if some transformation fails we don't need to query the database and instead we can retrieve the info from the ODS, however ODS is volatile in the sense it is temporally storage.

### Data Fabric
Refers to the tools we need to automate the analysis process. basically is just a name for the whole process that tries to make this process as efficient as possible, this implicates the virtualization of the information meaning we move physical information using virtualization and this is basically the same as the federation of a database which is a concept that was previously used which is a database that exists physically in different instances, like a distributed database, but they have logic version in common, so this what the virtualization does, it can distribute the database across different databases(oracle, MySQL, etc) across different platforms(gcp, aws, etc) but that can interact with all the databases it needs in a single query this done by using some servers that handles both the physical and logical version of data so we interact with this servers as normal query but in the background it is interacting with the distributed nodes to answer the request logically

### Master Data Management(MDM)
It is closely related with data governance. Is a catalog of information or a source of truth, the data inserted here has to be standardized, for example to identify a client profile in the sales department and a client profile in the warehouse department(department that fulfills orders), this enable us to unify the information in a single source, this means the data has to go through a quality assurance process defined by the data owner to make sure this way we can make sure the data being inserted complies to the defined standard, the data owner is the "stakeholder" that uses it the most for example the clients info belongs to sales dept, if some data does not fully comply to the standard we still need to keep it but we have to inform the user the quality of the data using an index

Class (17 feb 2025)

## Fact and dimension tables
There can be more than one fact table in a model and the dimensions can be related to more than one fact table, it may be preferred to stay with the star model

### Dimension Table
Primary key aka Surrogated Key. For each hierarchy of the dimension each level would have at least a description and a code for example in a retail shop when creating products dimensions. THey have three types of fields, surrogated key, hierarchy level and attributes. Attributes are complementary info like in a customer dimension you would have the client full name, phone number, or in a product dimension we could have the product's color, attributes should not be part of search querys


USE master
GO

DROP DATABASE IF EXISTS seminario
GO

CREATE DATABASE seminario
GO

USE seminario
GO

DROP SCHEMA IF EXISTS project1
GO

CREATE SCHEMA project1
GO

IF OBJECT_ID('project1.fact_compras', 'U') IS NOT NULL
    DROP TABLE project1.fact_compras;
GO

IF OBJECT_ID('project1.dim_proveedor', 'U') IS NOT NULL
    DROP TABLE project1.dim_proveedor;
GO

IF OBJECT_ID('project1.dim_fecha', 'U') IS NOT NULL
    DROP TABLE project1.dim_fecha;
GO

IF OBJECT_ID('project1.dim_sucursal', 'U') IS NOT NULL
    DROP TABLE project1.dim_sucursal;
GO

IF OBJECT_ID('project1.dim_producto', 'U') IS NOT NULL
    DROP TABLE project1.dim_producto;
GO

IF OBJECT_ID('project1.dim_marca', 'U') IS NOT NULL
    DROP TABLE project1.dim_marca;
GO

IF OBJECT_ID('project1.dim_categoria', 'U') IS NOT NULL
    DROP TABLE project1.dim_categoria;
GO

IF OBJECT_ID('project1.fact_ventas', 'U') IS NOT NULL
    DROP TABLE project1.fact_ventas;
GO

IF OBJECT_ID('project1.dim_cliente', 'U') IS NOT NULL
    DROP TABLE project1.dim_flight_status;
GO

IF OBJECT_ID('project1.dim_tipo_cliente', 'U') IS NOT NULL
    DROP TABLE project1.dim_tipo_cliente;
GO

IF OBJECT_ID('project1.dim_vendedor', 'U') IS NOT NULL
    DROP TABLE project1.dim_vendedor;
GO

CREATE TABLE project1.[fact_compras] (
	[id] INTEGER NOT NULL UNIQUE,
	[sk_proveedor] INTEGER NOT NULL,
	[sk_categoria_prod] INTEGER NOT NULL,
	[sk_marca_prod] INTEGER NOT NULL,
	[sk_fecha] INTEGER NOT NULL,
	[sk_sucursal] INTEGER NOT NULL,
	[sk_producto] INTEGER NOT NULL,
	[costo_unitario] DECIMAL(18, 2) NOT NULL,
	[unidades] INTEGER NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE project1.[dim_proveedor] (
	[id_codigo] INTEGER NOT NULL UNIQUE,
	[nombre] NCHAR NOT NULL,
	[direccion] NVARCHAR NOT NULL,
	[numero] INTEGER NOT NULL,
	[web] CHAR NOT NULL,
	PRIMARY KEY([id_codigo])
);
GO

CREATE TABLE project1.[dim_fecha] (
	[id] INTEGER NOT NULL UNIQUE,
	[dia] SMALLINT NOT NULL,
	[mes] TINYINT NOT NULL,
	[anio] SMALLINT NOT NULL,
	[fecha] DATE NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE INDEX [dim_fecha_index_0]
ON project1.[dim_fecha] ([anio]);
GO

CREATE TABLE project1.[dim_sucursal] (
	[id_codigo] INTEGER NOT NULL UNIQUE,
	[nombre] VARCHAR NOT NULL,
	[direccion] NVARCHAR NOT NULL,
	[region] VARCHAR NOT NULL,
	[departamento] VARCHAR NOT NULL,
	PRIMARY KEY([id_codigo])
);
GO

CREATE TABLE project1.[dim_producto] (
	[id] INTEGER NOT NULL,
	[codigo] VARCHAR NOT NULL UNIQUE,
	[nombre] NVARCHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE project1.[dim_marca] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[nombre] VARCHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE project1.[dim_categoria] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[nombre] NVARCHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE project1.[fact_ventas] (
	[id] INTEGER NOT NULL UNIQUE,
	[sk_categoria_prod] INTEGER NOT NULL,
	[sk_marca_prod] INTEGER NOT NULL,
	[sk_producto] INTEGER NOT NULL,
	[sk_sucursal] INTEGER NOT NULL,
	[sk_fecha] INTEGER NOT NULL,
	[sk_vendedor] INTEGER NOT NULL,
	[sk_cliente] INTEGER NOT NULL,
	[sk_tipo_cliente] INTEGER NOT NULL,
	[precio_unitario] DECIMAL(18, 2) NOT NULL,
	[unidades] INTEGER NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE project1.[dim_cliente] (
	[id_codigo] INTEGER NOT NULL UNIQUE,
	[nombre] NVARCHAR NOT NULL,
	[direccion] NVARCHAR NOT NULL,
	[numero] INTEGER NOT NULL,
	PRIMARY KEY([id_codigo])
);
GO

CREATE TABLE project1.[dim_tipo_cliente] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[tipo] CHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE project1.[dim_vendedor] (
	[id_codigo] INTEGER NOT NULL UNIQUE,
	[Nombre] NVARCHAR NOT NULL,
	[tipo] VARCHAR NOT NULL,
	PRIMARY KEY([id_codigo])
);
GO

ALTER TABLE project1.[fact_compras]
ADD FOREIGN KEY([sk_proveedor]) REFERENCES project1.[dim_proveedor]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_compras]
ADD FOREIGN KEY([sk_categoria_prod]) REFERENCES project1.[dim_categoria]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_compras]
ADD FOREIGN KEY([sk_marca_prod]) REFERENCES project1.[dim_marca]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_compras]
ADD FOREIGN KEY([sk_producto]) REFERENCES project1.[dim_producto]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_compras]
ADD FOREIGN KEY([sk_sucursal]) REFERENCES project1.[dim_sucursal]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_compras]
ADD FOREIGN KEY([sk_fecha]) REFERENCES project1.[dim_fecha]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_ventas]
ADD FOREIGN KEY([sk_categoria_prod]) REFERENCES project1.[dim_categoria]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_ventas]
ADD FOREIGN KEY([sk_marca_prod]) REFERENCES project1.[dim_marca]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_ventas]
ADD FOREIGN KEY([sk_producto]) REFERENCES project1.[dim_producto]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_ventas]
ADD FOREIGN KEY([sk_sucursal]) REFERENCES project1.[dim_sucursal]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_ventas]
ADD FOREIGN KEY([sk_fecha]) REFERENCES project1.[dim_fecha]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_ventas]
ADD FOREIGN KEY([sk_vendedor]) REFERENCES project1.[dim_vendedor]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_ventas]
ADD FOREIGN KEY([sk_tipo_cliente]) REFERENCES project1.[dim_tipo_cliente]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO

ALTER TABLE project1.[fact_ventas]
ADD FOREIGN KEY([sk_cliente]) REFERENCES project1.[dim_cliente]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
CREATE TABLE [fact_compras] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
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

CREATE TABLE [dim_proveedor] (
	[id_codigo] INTEGER NOT NULL UNIQUE,
	[nombre] NCHAR NOT NULL,
	[direccion] NVARCHAR NOT NULL,
	[numero] INTEGER NOT NULL,
	[web] CHAR NOT NULL,
	PRIMARY KEY([id_codigo])
);
GO

CREATE TABLE [dim_fecha] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[dia] SMALLINT NOT NULL,
	[mes] TINYINT NOT NULL,
	[anio] SMALLINT NOT NULL,
	[fecha] DATE NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE INDEX [dim_fecha_index_0]
ON [dim_fecha] ([anio]);
GO

CREATE TABLE [dim_sucursal] (
	[id_codigo] INTEGER NOT NULL IDENTITY UNIQUE,
	[nombre] VARCHAR NOT NULL,
	[direccion] NVARCHAR NOT NULL,
	[region] VARCHAR NOT NULL,
	[departamento] VARCHAR NOT NULL,
	PRIMARY KEY([id_codigo])
);
GO

CREATE TABLE [dim_producto] (
	[id] INTEGER NOT NULL,
	[codigo] VARCHAR NOT NULL UNIQUE,
	[nombre] NVARCHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE [dim_marca] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[nombre] VARCHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE [dim_categoria] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[nombre] NVARCHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE [fact_ventas] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
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

CREATE TABLE [dim_cliente] (
	[id_codigo] INTEGER NOT NULL IDENTITY UNIQUE,
	[nombre] NVARCHAR NOT NULL,
	[direccion] NVARCHAR NOT NULL,
	PRIMARY KEY([id_codigo])
);
GO

CREATE TABLE [dim_tipo_cliente] (
	[id] INTEGER NOT NULL IDENTITY UNIQUE,
	[tipo] CHAR NOT NULL,
	PRIMARY KEY([id])
);
GO

CREATE TABLE [dim_vendedor] (
	[id_codigo] INTEGER NOT NULL IDENTITY UNIQUE,
	[Nombre] NVARCHAR NOT NULL,
	[tipo] VARCHAR NOT NULL,
	PRIMARY KEY([id_codigo])
);
GO

ALTER TABLE [fact_compras]
ADD FOREIGN KEY([sk_proveedor]) REFERENCES [dim_proveedor]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_compras]
ADD FOREIGN KEY([sk_categoria_prod]) REFERENCES [dim_categoria]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_compras]
ADD FOREIGN KEY([sk_marca_prod]) REFERENCES [dim_marca]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_compras]
ADD FOREIGN KEY([sk_producto]) REFERENCES [dim_producto]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_compras]
ADD FOREIGN KEY([sk_sucursal]) REFERENCES [dim_sucursal]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_compras]
ADD FOREIGN KEY([sk_fecha]) REFERENCES [dim_fecha]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_ventas]
ADD FOREIGN KEY([sk_categoria_prod]) REFERENCES [dim_categoria]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_ventas]
ADD FOREIGN KEY([sk_marca_prod]) REFERENCES [dim_marca]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_ventas]
ADD FOREIGN KEY([sk_producto]) REFERENCES [dim_producto]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_ventas]
ADD FOREIGN KEY([sk_sucursal]) REFERENCES [dim_sucursal]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_ventas]
ADD FOREIGN KEY([sk_fecha]) REFERENCES [dim_fecha]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_ventas]
ADD FOREIGN KEY([sk_vendedor]) REFERENCES [dim_vendedor]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_ventas]
ADD FOREIGN KEY([sk_tipo_cliente]) REFERENCES [dim_tipo_cliente]([id])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
ALTER TABLE [fact_ventas]
ADD FOREIGN KEY([sk_cliente]) REFERENCES [dim_cliente]([id_codigo])
ON UPDATE NO ACTION ON DELETE NO ACTION;
GO
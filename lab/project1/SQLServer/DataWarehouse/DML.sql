USE seminario
GO

-- Compras

SELECT * FROM project1.pivot_fact_compras

SELECT * FROM project1.fact_compras

SELECT * FROM project1.dim_proveedor

SELECT COUNT(*) FROM project1.pivot_fact_compras

SELECT COUNT(*) FROM project1.fact_compras

SELECT COUNT(*) FROM project1.dim_proveedor



DELETE FROM project1.pivot_fact_compras

DELETE FROM project1.fact_compras

DELETE FROM project1.dim_proveedor




-- Ventas

SELECT * FROM project1.pivot_fact_ventas

SELECT * FROM project1.fact_ventas

SELECT * FROM project1.dim_vendedor

SELECT * FROM project1.dim_cliente

SELECT * FROM project1.dim_tipo_cliente

SELECT COUNT(*) FROM project1.pivot_fact_ventas

SELECT COUNT(*) FROM project1.fact_ventas

SELECT COUNT(*) FROM project1.dim_vendedor

SELECT COUNT(*) FROM project1.dim_cliente

SELECT COUNT(*) FROM project1.dim_tipo_cliente




DELETE FROM project1.pivot_fact_ventas

DELETE FROM project1.fact_ventas

DELETE FROM project1.dim_vendedor

DELETE FROM project1.dim_cliente

DELETE FROM project1.dim_tipo_cliente




-- Common

SELECT * FROM project1.dim_categoria    -- categoria producto

SELECT * FROM project1.dim_marca

SELECT * FROM project1.dim_producto

SELECT * FROM project1.dim_sucursal

SELECT * FROM project1.dim_fecha

SELECT COUNT(*) FROM project1.dim_categoria    -- categoria producto

SELECT COUNT(*) FROM project1.dim_marca

SELECT COUNT(*) FROM project1.dim_producto

SELECT COUNT(*) FROM project1.dim_sucursal

SELECT COUNT(*) FROM project1.dim_fecha


DELETE FROM project1.dim_categoria

DELETE FROM project1.dim_marca

DELETE FROM project1.dim_producto

DELETE FROM project1.dim_sucursal

DELETE FROM project1.dim_fecha


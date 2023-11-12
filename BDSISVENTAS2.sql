CREATE DATABASE DBSISTEMA_FACTURACION

GO

USE DBSISTEMA_FACTURACION

go

CREATE TABLE ROL(
IdRol int primary key identity,
Descripcion varchar(150),
FechaRegistro datetime default getdate ()
);
go

CREATE TABLE PERMISO(
IdPermiso int primary key identity,
IdRol int references ROL(IdRol),
NombreMenu varchar(150),
FechaRegistro datetime default getdate ()
);
go

CREATE TABLE PROVEEDOR(
IdProveedor int primary key identity,
Documento varchar(150),
RazonSocial varchar(150),
Correo varchar(150),
Telefono varchar(150),
Estado bit,
FechaRegistro datetime default getdate ()
);

go

CREATE TABLE CLIENTE(
IdCliente int primary key identity,
Documento varchar(150),
NombreCompleto varchar(150),
Correo varchar(150),
Telefono varchar(150),
Estado bit,
FechaRegistro datetime default getdate ()
);

go

CREATE TABLE USUARIO(
IdUsuario int primary key identity,
Documento varchar(150),
NombreCompleto varchar(150),
Correo varchar(150),
Clave varchar(150),
IdRol int references ROL(IdRol),
Estado bit,
FechaRegistro datetime default getdate ()
);

go

CREATE TABLE CATEGORIA(
IdCategoria int primary key identity,
Descripcion varchar(100),
Estado bit,
FechaRegistro datetime default getdate ()
);

go

CREATE TABLE PRODUCTO(
IdProducto int primary key identity,
Codigo varchar(150),
Nombre varchar (150),
Descripcion varchar(150),
IdCategoria int references CATEGORIA(IdCategoria),
Stock int not null default 0,
PrecioCompra decimal (10,2) default 0,
PrecioVenta decimal (10,2) default 0,
Estado bit, 
FechaRegistro datetime default getdate ()
);

 
go

CREATE TABLE COMPRA(
    IdCompra int primary key identity,
    IdUsuario int references USUARIO (IdUsuario),
    IdProveedor int references PROVEEDOR (IdProveedor),
    TipoDocumento varchar(150),
    NumeroDocumento varchar(150),
    MontoTotal decimal (10,2),  -- Corregido aquí
    FechaRegistro datetime default getdate ()
);


go


CREATE TABLE DETALLE_COMPRA(
IdDetalleCompra int primary key identity,
IdCompra int references COMPRA (IdCompra),
IdProducto int references PRODUCTO (IdProducto),
PrecioCompra decimal (10,2) default 0,
PrecioVenta decimal (10,2) default 0,
Cantidad int,
MontoTotal decimal (10,2),
FechaRegistro datetime default getdate ()
);

go

CREATE TABLE VENTA (
IdVenta int primary key identity,
IdUsuario int references USUARIO(IdUsuario),
TipoDocumento varchar (150),
NumeroDocumento varchar (150),
DocumentoCliente varchar (150),
NombreCliente varchar (150),
MontoPago decimal (10,2),
MontoCambio decimal (10,2),
MontoTotal decimal (10,2),
FechaRegistro datetime default getdate ()
);

go

CREATE TABLE DETALLE_VENTA(
IdDetalleVenta int primary key identity,
IdVenta int references VENTA(IdVenta),
IdProducto int references PRODUCTO(IdProducto),
PrecioVenta decimal (10,2),
Cantidad int,
SubTotal decimal (10,2),
FechaRegistro datetime default getdate ()
);
go

CREATE TABLE NEGOCIO(
IdNegocio int primary key,
Nombre varchar(150),
RUC varchar (150),
Direccion varchar (150),
Logo varbinary (MAX) NULL
);

-----------------------------------------------------
--------------------Registros------------------------
-----------------------------------------------------

--------TABLA ROL----------
go
insert into ROL(Descripcion)
values
('Administrador'),
('Empleado');

go 

--------TABLA Permiso----------
insert into PERMISO(IdRol, NombreMenu) values
(1, 'menuusuarios'),
(1, 'menumantenedor'),
(1, 'menuventas'),
(1, 'menucompras'),
(1, 'menuclientes'),
(1, 'menuproveedores'),
(1, 'menureportes'),
(1, 'menuacercade')

go

insert into PERMISO(IdRol, NombreMenu) values
(2, 'menuusuarios'),
(2, 'menucompras'),
(2, 'menuclientes'),
(2, 'menuproveedores'),
(2, 'menuacercade')
;
go
---------TABLA USUARIOS-------------


-- Administrador
INSERT INTO USUARIO (Documento, NombreCompleto, Correo, Clave, IdRol, Estado) VALUES
('DNI00', 'Administrador', 'admin@example.com', 'ADMI123', 1, 1);

-- Cajero
INSERT INTO USUARIO (Documento, NombreCompleto, Correo, Clave, IdRol, Estado) VALUES
('DNI11', 'Cajero', 'cajero@example.com', 'CAJERO123', 2, 1);



----------Proveedor
INSERT INTO PROVEEDOR (Documento, RazonSocial, Correo, Telefono, Estado) VALUES
('RUC123456789', 'Proveedor1 S.A.', 'proveedor1@example.com', '123-456-789', 1),
('RUC987654321', 'Proveedor2 S.A.', 'proveedor2@example.com', '987-654-321', 1);


----------CLIENTE
INSERT INTO CLIENTE (Documento, NombreCompleto, Correo, Telefono, Estado) VALUES
('DNI12345678', 'Cliente Uno', 'cliente1@example.com', '456-789-012', 1),
('DNI87654321', 'Cliente Dos', 'cliente2@example.com', '789-012-345', 1);

---------CATEGORIA
INSERT INTO CATEGORIA (Descripcion, Estado) VALUES
('Electrónicos', 1),
('Ropa', 1);

---------PRODUCTO
INSERT INTO PRODUCTO (Codigo, Nombre, Descripcion, IdCategoria, Stock, PrecioCompra, PrecioVenta, Estado) VALUES
('P001', 'Smartphone', 'Teléfono inteligente', 1, 50, 300, 500, 1),
('P002', 'Camisa', 'Camisa de algodón', 2, 100, 20, 40, 1);

--------COMPRA
INSERT INTO COMPRA (IdUsuario, IdProveedor, TipoDocumento, NumeroDocumento, MontoTotal) VALUES
(1, 1, 'Factura', 'F001-2023', 1200),
(1, 2, 'Factura', 'F002-2023', 800);

--------DETALLE COMPRA
INSERT INTO DETALLE_COMPRA (IdCompra, IdProducto, PrecioCompra, PrecioVenta, Cantidad, MontoTotal) VALUES
(1, 1, 250, 400, 3, 1200),
(2, 2, 10, 20, 40, 800);

-------VENTA
INSERT INTO VENTA (IdUsuario, TipoDocumento, NumeroDocumento, DocumentoCliente, NombreCliente, MontoPago, MontoCambio, MontoTotal) VALUES
(2, 'Boleta', 'B001-2023', 'DNI12345678', 'Cliente Uno', 600, 100, 700);

-------DETALLE VENTA
INSERT INTO DETALLE_VENTA (IdVenta, IdProducto, PrecioVenta, Cantidad, SubTotal)
VALUES
(1, 1, 500, 2, 1000);


-------NEGOCIO
insert into NEGOCIO (IdNegocio, Nombre, RUC, Direccion)
Values
(1,'Tieda Morelia','101010', 'Ahuachapan'); 




---------------------------------------------------------------------
-------------------PROCEDIMIENTOS ALMACENADOS------------------------
---------------------------------------------------------------------

-----------------Registrar-----------------


CREATE PROC SP_REGISTRARUSUARIO(
@documento varchar (150),
@nombreCompleto varchar (150),
@Correo varchar (150),
@Clave varchar (150),
@IdRol int,
@Estado bit,
@IdUsuarioResultado int output,
@Mensaje varchar (500) output
)

as 
begin 
set @IdUsuarioResultado = 0
set @Mensaje = ''

if not exists(select * from USUARIO where Documento = @documento)
begin
insert into USUARIO(Documento, NombreCompleto, Correo, Clave, IdRol, Estado) values
(@documento, @nombreCompleto, @Correo, @Clave, @IdRol, @Estado)

set @IdUsuarioResultado = SCOPE_IDENTITY()

end 
else 
set @Mensaje = 'No se puede repetir el documento para más de un usuario'

end

go 


----------------------Editar----------------

CREATE PROC SP_EDITARUSUARIO(
@IdUsuario int,
@Documento varchar (150),
@nombreCompleto varchar (150),
@Correo varchar (150),
@Clave varchar (150),
@IdRol int,
@Estado bit,
@Respuesta bit output,
@Mensaje varchar (500) output
)

as 
begin 
set @Respuesta = 0
set @Mensaje = ''

if not exists(select * from USUARIO where Documento = @Documento and IdUsuario != @IdUsuario )
begin
update USUARIO set Documento = @documento,
NombreCompleto = @nombreCompleto, Correo = @Correo, Clave = @Clave, IdRol = @IdRol, Estado = @Estado where IdUsuario = @IdUsuario 

set @Respuesta = 1

end 
else 
set @Mensaje = 'No se puede repetir el documento para más de un usuario'

end

go 

--------------------------Eliminar---------------------
 
CREATE PROC SP_ELIMINARUSUARIO(
@IdUsuario int,
@Respuesta bit output,
@Mensaje varchar (500) output
)

as 
begin 
set @Respuesta = 0
set @Mensaje = ''
declare @pasoreglas bit = 1

if exists( select * from COMPRA C inner join USUARIO U on U.IdUsuario = C.IdUsuario
where U.IdUsuario = @IdUsuario
) 

begin
set @pasoreglas = 0
set @Respuesta = 0
set @Mensaje = @Mensaje + 'No se puede eliminar porque	el usuario se encuentra relacionado a una COMPRA\n'

end



if exists( select * from VENTA V inner join USUARIO U on U.IdUsuario = V.IdUsuario
where U.IdUsuario = @IdUsuario
) 

begin
set @pasoreglas = 0
set @Respuesta = 0
set @Mensaje = @Mensaje + 'No se puede eliminar porque	el usuario se encuentra relacionado a una VENTA\n'

end

if (@pasoreglas = 1)
begin 
delete from USUARIO where IdUsuario = @IdUsuario
set @Respuesta = 1

end

end


go






declare @Respuesta bit
declare @mensaje varchar (150)

execute SP_EDITARUSUARIO 11 ,'123', 'pruebas 2', 'prueba@gmail.com', '456', 2, 1,@Respuesta output, @mensaje output 

select @Respuesta

select @mensaje

 


--PROCEDIMIENTOS PARA CATEGORIA
--PARA GUARDAR CATEGORIA

CREATE PROC SP_RegistrarCategoria(
@Descripcion varchar(50),
@Resultado int output,
@Estado bit,
@Mensaje varchar(500) output
)as
begin 
Set @Resultado= 0
If not exists (Select*from CATEGORIA Where Descripcion= @Descripcion)
begin
insert into CATEGORIA(Descripcion, Estado) values (@Descripcion, @Estado)
set @Resultado= SCOPE_IDENTITY()
end
ELSE 
set @Mensaje= 'No se puede repetir la descripcion de una categoria'
end

go

 
--PARA MODIFICAR CATEGORIA

CREATE PROC SP_EditarCategoria(
@IdCategoria int,
@Descripcion varchar(50),
@Resultado bit output,
@Estado bit, 
@Mensaje varchar(500) output
)as
begin 
Set @Resultado= 1
If not exists (Select*from CATEGORIA Where Descripcion= @Descripcion and IdCategoria != @IdCategoria)
update CATEGORIA set
Descripcion = @Descripcion,
Estado= @Estado
where IdCategoria = @IdCategoria
ELSE
begin 
set @Resultado=0
set @Mensaje = 'No se puede repetir la descripcion de la categoria'

  end

end

go
 

---------------ELIMINAR CATEGORIA---------------

create PROC SP_EliminarCategoria(
@IdCategoria int,
@Resultado bit output,
@Mensaje varchar(500) output
)
as
begin 
SET @Resultado=1
If not exists (
select*from CATEGORIA c
inner join PRODUCTO p on p.IdCategoria = c.IdCategoria
where c.IdCategoria = @IdCategoria
)
begin

delete top(1) from CATEGORIA where IdCategoria = @IdCategoria
end
Else
begin
set @Resultado= 0
set @Mensaje= 'La categoria se encuentra relacionada a un producto'

end
end

go

select IdCategoria, Descripcion, Estado from  CATEGORIA;
 


 -----------------Procedimiento de registrar producto------------------
 
 create PROC sp_RegistrarProducto ( 
 @Codigo varchar(20),
 @Nombre varchar (30),
 @Descripcion varchar (30),
 @IdCategoria int, 
 @Estado bit,
 @Resultado bit output,
 @Mensaje varchar (500) output
 )
 as
 begin
 set @Resultado = 0
 if not exists (select * from PRODUCTO where Codigo = @Codigo)
 begin 
 insert into PRODUCTO (Codigo, Nombre, Descripcion, IdCategoria, Estado)
 Values (@Codigo, @Nombre, @Descripcion, @IdCategoria, @Estado)
 set @Resultado = SCOPE_IDENTITY()
 end
 else 
 set @Mensaje = 'Ya existe un producto con el mismo código'
 
 end
 go

 ----------------MODIFICAR PRODUCTO---------------
 
 create PROCEDURE sp_ModificarProducto(
 @IdProducto int,
 @Codigo varchar(20),
 @Nombre varchar (30),
 @Descripcion varchar (30),
 @IdCategoria int, 
 @Estado bit,
 @Resultado bit output,
 @Mensaje varchar (500) output
 )
 as 
 begin 
 set @Resultado = 1
     If not exists (select * from PRODUCTO where Codigo =@Codigo and IdProducto != @IdProducto)
	 update PRODUCTO set
	 Codigo = @Codigo,
	 Nombre = @Nombre,
	 Descripcion = @Descripcion,
	 IdCategoria = @IdCategoria,
	 Estado = @Estado
	 WHERE IdProducto = @IdProducto
	 else
	 begin 
	 set @Resultado = 0
	 SET @Mensaje = 'Ya existe un producto con el mismo código'
	 end 
	 end
	 go

	 
	 select*from USUARIO


-----------------Eliminar producto------------------
 
create Proc SP_EliminarProducto(
@IdProducto int,
@Respuesta bit output,
@Mensaje varchar (500) output
) 
as 
begin 
   set @Respuesta = 0
   set @Mensaje = ''
   declare @pasoreglas bit = 1

   if exists (select * from DETALLE_COMPRA dc
   INNER JOIN PRODUCTO p ON p.IdProducto = dc.IdProducto
   WHERE p.IdProducto = @IdProducto)
   begin 
   set @pasoreglas = 0
   set @Respuesta = 0
   set @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una COMPRA\n'
   end 
   if exists (select * from DETALLE_VENTA dv
   inner join PRODUCTO p On p.IdProducto = dv.IdProducto
   where p.IdProducto = @IdProducto)
   begin 
   set @pasoreglas = 0
   set @Respuesta = 0
   SET @Mensaje = @Mensaje + 'No se puede eliminar porque se encuentra relacionado a una VENTA\n'
   end
   if (@pasoreglas = 1)
   begin
   delete from PRODUCTO where IdProducto = @IdProducto
   set @Respuesta = 1
   end
   end
   go

   ---------PROCEDIMIENTOS ALMACENADOS PARA CLIENTES---------------

   ----------------------REGISTRAR AL CLIENTE--------------------
   
   create proc SP_RegistrarCliente(
   @Documento varchar(50),
   @NombreCompleto varchar(50),
   @Correo varchar(50),
   @Telefono varchar(50),
   @Estado bit,
   @Resultado int output,
   @Mensaje varchar (500) output

   )as 
   begin 
   set @Resultado=0
   declare @IDPERSONA int
   if not exists (select*from CLIENTE where Documento= @Documento)
   begin
   insert into CLIENTE(Documento, NombreCompleto, Correo, Telefono, Estado) values(@Documento, @NombreCompleto, @Correo, @Telefono, @Estado)
   set @Resultado=SCOPE_IDENTITY()
   end 
   else
   set @Mensaje = 'El numero de documento ya existe XD'
   end

   go
   -----------------MODIFICAR AL CLIENTE--------------
 
   create proc SP_ModificarCliente(
   @IdCliente int,
   @Documento varchar(50),
   @NombreCompleto varchar(50),
   @Correo varchar(50),
   @Telefono varchar(50),
   @Estado bit,
   @Resultado int output,
   @Mensaje varchar(500) output

   )as
   begin
   set @Resultado=1
   declare @IDPERSONA int
   if not exists(select*from CLIENTE where Documento= @Documento and IdCliente !=@IdCliente)
   begin
   update CLIENTE set
   Documento = @Documento,
   NombreCompleto= @NombreCompleto,
   Correo = @Correo,
   @Telefono= @Telefono,
   @Estado= @Estado
   where IdCliente= @IdCliente

   end
   else
   begin
   set @Resultado=0
   set @Mensaje='El numero del documento ya existe xD ponga otro'
   
   end 
   end

   go

   ----------------PROCEDIMIENTOS ALMACENADOSA PARA PROVEEDORES-----------------

  -----------------REGISTRAR PROVEEDOR----------------
 
   create proc SP_RegistrarProveedor(
   @Documento varchar(50),
   @RazonSocial varchar(50),
   @Correo varchar(50),
   @Telefono varchar(50),
   @Estado bit,
   @Resultado int output,
   @Mensaje varchar(500) output
   )as 
   begin 
   set @Resultado =0
   declare @IDPERSONA INT
   if not exists (select*from PROVEEDOR where Documento= @Documento)
   begin
   insert into PROVEEDOR(Documento, RazonSocial,Correo, Telefono, Estado) values(@Documento, @RazonSocial, @Correo, @Telefono, @Estado)
   set @Resultado = SCOPE_IDENTITY()
   END

   else 

   set @Mensaje='El numero de documento ya existe, ponga otro'
   end

   go


   -----------------EDITAR PROVEEDOR------------------
 
   create proc SP_ModificarProveedor(
   @IdProveedor int,
   @Documento varchar(50),
   @RazonSocial varchar(50),
   @Correo varchar(50),
   @Telefono varchar(50),
   @Estado bit,
   @Resultado bit output,
   @Mensaje varchar(500) output

   )as
   begin

   set @Resultado =1
   declare @IDPERSONA int
   if not exists (select*from PROVEEDOR WHERE Documento= @Documento and IdProveedor != @IdProveedor)
   begin 
   update PROVEEDOR set
   Documento= @Documento,
   RazonSocial= @RazonSocial,
   Correo= @Correo,
   Telefono = @Telefono,
   Estado= @Estado
   where IdProveedor= @IdProveedor
   END
   else 

   begin
   set @Resultado=0
   set @Mensaje= 'El numero de documento ya existe'
   end
   end
   go

   --------------------PROCEDIMIENTO PARA ELIMINAR-------------------
  
   CREATE PROC SP_EliminarProveedor(
    @IdProveedor int,
	@Resultado bit output,
	@Mensaje varchar(500) output

   )as
   begin
   set @Resultado= 1
   if not exists(select *from PROVEEDOR p
   inner join COMPRA c on p.IdProveedor= c.IdProveedor
   where p.IdProveedor = @IdProveedor
   )

   begin 
   delete top(1) from PROVEEDOR where IdProveedor = @IdProveedor
   end
   else
   begin 
   set @Resultado =0
   set @Mensaje= 'El Proveedor se encuentra relacionado a una compra'

   end
   end

   go


   select IdProveedor, Documento, RazonSocial, Correo, Telefono, Estado from PROVEEDOR
 

   ------------------PROCESOS PARA REGISTRAR COMPRA
   
   CREATE TYPE [dbo].[EDetalle_Compra] as table(
   [IdProducto] int null,
   [PrecioCompra] decimal (18,2)null,
   [PrecioVenta] decimal(18,2)null,
   [Cantidad] int null,
   [MontoTotal] decimal (18,2) null
   );

go

select count(*) +1 from COMPRA

select*from ROL


create procedure SP_RegistrarCompra(
@IdUsuario int,
@IdProveedor int,
@TipoDocumento varchar(500),
@NumeroDocumento varchar(500),
@MontoTotal decimal (18,2),
@DetalleCompra [EDetalle_Compra] READONLY,
@Resultado bit output,
@Mensaje varchar(500) output

)as
begin

begin try
     declare @idcompra int=0
	 set @Resultado = 1
	 set @Mensaje=''

	 begin transaction registro

	 insert into COMPRA(IdUsuario, IdProveedor, TipoDocumento, NumeroDocumento, MontoTotal)
	 values(@IdUsuario, @IdProveedor, @TipoDocumento, @NumeroDocumento, @MontoTotal)

	 set @idcompra= SCOPE_IDENTITY()

	 insert into DETALLE_COMPRA(IdCompra, IdProducto, PrecioCompra, PrecioVenta, Cantidad, MontoTotal)
	 select @idcompra, IdProducto, PrecioCompra, PrecioVenta, Cantidad, MontoTotal from @DetalleCompra


	 update p set p.Stock = p.Stock + dc.Cantidad,
	 p.PrecioCompra = dc.PrecioCompra,
	 p.PrecioVenta = dc.PrecioVenta
	 from PRODUCTO p
	 inner join @DetalleCompra dc on dc.IdProducto = p.IdProducto

	 commit transaction registro

end try

begin catch

   set @Resultado =0
   set @Mensaje = ERROR_MESSAGE()
   rollback transaction registro

end catch

end
 
--DETALLE DE VENTA
 create type [dbo].[EDetalle_Venta] as table(
 [IdProducto] int null,
 [PrecioVenta] decimal (18,2) null,
 [Cantidad] int null,
 [SubTotal] decimal (18,2) null
 )

 go


 
 create proc usp_RegistrarVenta(
 @IdUsuario int,
 @TipoDocumento varchar(500),
 @NumeroDocumento varchar(500),
 @DocumentoCliente varchar(500),
 @NombreCliente varchar(500),
 @MontoPago decimal(18,2),
 @MontoCambio decimal(18,2),
 @MontoTotal decimal(18,2),
 @DetalleVenta [EDetalle_Venta] READONLY,
 @Resultado bit output,
 @Mensaje varchar(500) output
 )
as

begin

begin try
declare @idventa int=0
set @Resultado=1
set @Mensaje =''

begin transaction registro

insert into VENTA(IdUsuario, TipoDocumento, NumeroDocumento, DocumentoCliente, NombreCliente, MontoPago, MontoCambio, MontoTotal)
values(@IdUsuario, @TipoDocumento, @NumeroDocumento, @DocumentoCliente, @NombreCliente, @MontoPago, @MontoCambio, @MontoTotal)

set @idventa= SCOPE_IDENTITY()

INSERT INTO DETALLE_VENTA(IdVenta, IdProducto, PrecioVenta, Cantidad, SubTotal)
select @idventa,  IdProducto, PrecioVenta, Cantidad, SubTotal from @DetalleVenta

commit transaction registro

end try

begin catch
set @Resultado = 0
set @Mensaje= ERROR_MESSAGE()
rollback transaction registro

end catch

end


 ----------------------------------------------------------------------------------

SELECT c.IdCompra, pr.Documento, pr.RazonSocial, c.TipoDocumento, c.NumeroDocumento, c.MontoTotal,
CONVERT(char(10), c.FechaRegistro, 103)[FechaRegistro]
FROM COMPRA c
INNER JOIN USUARIO u on u.IdUsuario = c.IdUsuario
INNER JOIN PROVEEDOR pr on pr.IdProveedor = c.IdProveedor
where c.NumeroDocumento = '00004';

SELECT p.Nombre, dc.PrecioCompra, dc.Cantidad, dc.MontoTotal
From DETALLE_COMPRA dc
INNER JOIN PRODUCTO p on p.IdProducto = dc.IdProducto
where dc.IdCompra = 1;

----Consulta venta


SELECT v.IdVenta, 
u.NombreCompleto, v.DocumentoCliente,
v.NombreCliente, v.TipoDocumento,
v.NumeroDocumento, v.MontoPago, v.MontoCambio, v.MontoTotal,
CONVERT(char(10),v.FechaRegistro, 103)[FechaRegistro]

from VENTA v
INNER JOIN USUARIO u ON U.IdUsuario = V.IdUsuario
WHERE v.NumeroDocumento = 'B001-2023';

SELECT p.Nombre, dv.PrecioVenta,dv.Cantidad, dv.SubTotal

FROM DETALLE_VENTA dv
INNER JOIN PRODUCTO p on p.IdProducto = dv.IdProducto
where dv.IdVenta = 1;


-------------------------------------------------------
select NumeroDocumento from VENTA

go
insert into PRODUCTO (Codigo, Nombre, Descripcion, IdCategoria, Estado) values
('10110', 'gaseosa', '1litro', 2, 1)
go


select * from NEGOCIO

select p.IdRol, NombreMenu from PERMISO p
inner join ROL r on r.IdRol = p.IdRol
inner join USUARIO  u on u.IdRol = r.IdRol
where u.IdUsuario= 2;

select p.IdRol, NombreMenu from PERMISO p
inner join ROL r on r.IdRol = p.IdRol
inner join USUARIO  u on u.IdRol = r.IdRol
where u.IdUsuario= 3;

select u.IdUsuario, u.Documento, u.NombreCompleto, u.correo, u.Clave, u.Estado, r.IdRol, r.Descripcion from usuario u inner join rol r on r.IdRol = u.IdRol

select IdProducto, Codigo, Nombre, p.Descripcion, c.IdCategoria, c.Descripcion[DescripcionCategoria], Stock, PrecioCompra, PrecioVenta, p.Estado from PRODUCTO p
inner join CATEGORIA c on c.IdCategoria = p.IdCategoria

select*from NEGOCIO

select*from USUARIO

select * from COMPRA
select * from USUARIO
select * from PROVEEDOR

--CONSULTAS PARA LOS REPORTES 
select
Convert(char(10), c.FechaRegistro, 103)[FechaRegistro], c.TipoDocumento, c.NumeroDocumento, c.MontoTotal,
u.NombreCompleto[UsuarioRegistro],
pr.Documento[DocumentoProveedor], pr.RazonSocial,
p.Codigo[CodigoProducto], p.Nombre[NombreProducto], ca.Descripcion[Categoria], dc.PrecioCompra, dc.PrecioVenta, dc.Cantidad, dc.MontoTotal[SubTotal]
from COMPRA c
inner join USUARIO u on u.IdUsuario = c.IdUsuario
inner join PROVEEDOR pr on pr.IdProveedor= c.IdProveedor
inner join DETALLE_COMPRA dc on dc.IdCompra= c.IdCompra
inner join PRODUCTO p on p.IdProducto= dc.IdProducto
inner join CATEGORIA ca on ca.IdCategoria= p.IdCategoria
WHERE convert(date, c.FechaRegistro) between '10/11/2023' and '11/11/2023'
and pr.IdProveedor=1;
 
 --PROCEDIMIENTO REPORTE COMPRAS
create proc sp_ReporteCompras(
@fechainicio varchar(10),
@fechafin varchar(10),
@idproveedor int
)
as
begin

set dateformat dmy;

select
Convert(char(10), c.FechaRegistro, 103)[FechaRegistro], c.TipoDocumento, c.NumeroDocumento, c.MontoTotal,
u.NombreCompleto[UsuarioRegistro],
pr.Documento[DocumentoProveedor], pr.RazonSocial,
p.Codigo[CodigoProducto], p.Nombre[NombreProducto], ca.Descripcion[Categoria], dc.PrecioCompra, dc.PrecioVenta, dc.Cantidad, dc.MontoTotal[SubTotal]
from COMPRA c
inner join USUARIO u on u.IdUsuario = c.IdUsuario
inner join PROVEEDOR pr on pr.IdProveedor= c.IdProveedor
inner join DETALLE_COMPRA dc on dc.IdCompra= c.IdCompra
inner join PRODUCTO p on p.IdProducto= dc.IdProducto
inner join CATEGORIA ca on ca.IdCategoria= p.IdCategoria
WHERE convert(date, c.FechaRegistro) between @fechainicio and @fechafin
AND pr.IdProveedor = CASE WHEN @idproveedor = 0 THEN pr.IdProveedor ELSE @idproveedor END
end

--PROCEDIMIENTO REPORTE VENTAS
create proc sp_ReporteVentas(
@fechainicio varchar(10),
@fechafin varchar(10)
 
)
as
begin

set dateformat dmy;

select
Convert(char(10), v.FechaRegistro, 103)[FechaRegistro], v.TipoDocumento, v.NumeroDocumento, v.MontoTotal,
u.NombreCompleto[UsuarioRegistro],
v.DocumentoCliente, v.NombreCliente,
p.Codigo[CodigoProducto], p.Nombre[NombreProducto], ca.Descripcion[Categoria], dv.PrecioVenta, dv.Cantidad, dv.SubTotal
from VENTA v
inner join USUARIO u on u.IdUsuario = v.IdUsuario
inner join DETALLE_VENTA dv on dv.IdVenta= v.IdVenta
inner join PRODUCTO p on p.IdProducto= dv.IdProducto
inner join CATEGORIA ca on ca.IdCategoria= p.IdCategoria
 where CONVERT(date, v.FechaRegistro) between @fechainicio and @fechafin
end

EXEC sp_ReporteVentas '10/11/2023', '11/11/2023'
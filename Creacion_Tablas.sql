create database Hotel_Realeza
go
use Hotel_Realeza
go

--Creacion tablas

--1.
create table Cliente(
Id_Cliente char(5) primary key not null,
NombreCompleto  nvarchar(50) not null,
Gmail nvarchar(50) not null,
Telefono char(8) not null,
Cedula char(15) not null,
Estado bit,
FechaRegistro datetime default getdate ()
)

go
--2.
create table Rol(
Id_Rol char (5) primary key not null,
DescripcionRol nvarchar(30) not null,
FechaCreacion datetime default getdate() 
)
go
--3.
create table Permiso(
Id_Permiso char (5) primary key not null,
Id_Rol char (5) foreign key references Rol(Id_Rol),
NombreMenu nvarchar(80) not null,
FechaRegistro datetime default getdate ()
)
go


--4.
create table Usuario( --Cambie el nombre a usuario, recorda que no deben ir nombres en plural en las tablas
Id_Usuarios char(5) primary key not null,
NombreCompleto  nvarchar(50) not null,
Gmail nvarchar(50) not null,
Telefono char(8) not null,
Cedula char(18) not null,
contraseña nvarchar (10) not null,
Estado bit,
Id_Rol char(5) foreign key references Rol(Id_Rol) not null,
FechaRegistro datetime default getdate ()
)

go
--5.
create table AtencionPersonal( --Busqueda
Id_AtencionPersonal int primary key identity(1,1) not null,
Id_Usuarios char(5) foreign key references Usuarios(Id_Usuarios) not null,
Id_Cliente char(5) foreign key references Cliente(Id_Cliente) not null
)
go
--6.
create table Tipo_Habitacion( --Segun la ocupacion
Id_Tipo_Habitacion int identity(1,1) primary key not null,
Tipo_Habitacion nvarchar(30) not null,
FechaRegistro datetime default getdate () --*PORQUE UNA FECHA DE REGISTRO EN EL TIPO DE HABITACION*?
)
go
--7.
create table Habitacion(
Id_Habitacion char(5) primary key not null,
NumeroHabitacion int identity(1,1) not null,
Precio money not null,
FechaRegistro datetime default getdate (),
Id_Tipo_Habitacion int foreign key references Tipo_Habitacion(Id_Tipo_Habitacion) 
)
go
--8.
create table Reservacion(
Id_Reservacion char(5) primary key not null,
EstadoReservacion  bit  default 0,
TiempoEstancia int not null,
FechaReserva datetime not null,
FechaEntrada datetime default getdate() not null,
FechaSalida datetime not null
)
go
--9.
create table ReservacionHecha(
Id_ReservacionHecha int identity(1,1) primary key not null,
Id_Cliente char(5) foreign key references Cliente(Id_Cliente) not null,
Id_Reservacion char(5) foreign key references Reservacion(Id_Reservacion) not null,
Id_Habitacion char(5) foreign key references Habitacion(Id_Habitacion) not null
)
go
--10.
create table Tipo_Pago(
Id_Tipo_Pago int identity(1,1) primary key not null,
TipoPago nvarchar(30) not null
)
go
--11.
create table PagoContado(
Id_Pago_Contado char(5) primary key not null,
MontoTotal money not null,
FechaPago datetime default getdate() not null,
Id_Cliente char(5) foreign key references Cliente(Id_Cliente) not null, --aca si le agregue las FK para ver si me daba un tipo de error
Id_Tipo_Pago int foreign key references Tipo_Pago(Id_Tipo_Pago) not null
)
go
--12.
create table PagoParcial(
Id_Pago_Parcial char(5) primary key not null,
MontoInicial money not null,
MontoFinal money not null,
FechaPagoInicial datetime not null,
FechaPagoFinal datetime not null,
Id_Cliente char(5) foreign key references Cliente(Id_Cliente) not null,
Id_Tipo_Pago int foreign key references Tipo_Pago(Id_Tipo_Pago) not nulll
)
go
--13.
create table CuentaHotel(
Id_Cuenta_Hotel char(5) primary key not null,
TipoTarjeta nvarchar(20) check(TipoTarjeta in ('Debito', 'Credito')) not null,
NumeroTarjeta nvarchar(16) not null,
Balance money not null
)
go
--14.
create table PagoTarjeta(
Id_Pago_Tarjeta char(5) primary key not null,
TipoTarjeta nvarchar(20) not null check(TipoTarjeta in ('Debito', 'Credito')),
NumeroTarjeta nvarchar(16) not null,
CV char(3) not null,
FehchaPago datetime default getdate() not null,
MontoTotal Money not null,
Id_Cliente char(5) foreign key references Cliente(Id_Cliente) not null, 
Id_Cuenta_Hotel char(5)  foreign key references CuentaHotel(Id_Cuenta_Hotel) not null
)
go				  
--15.
create table PagoCliente(
Id_PagoCliente char(5) primary key not null,
Id_Cliente char(5) foreign key references Cliente(Id_Cliente) not null,
Id_Reservacion char(5) foreign key references Reservacion(Id_Reservacion) not null,
Id_Pago_Contado char(5) foreign key references PagoContado(Id_Pago_Contado) not null,
Id_Pago_Parcial char(5)  foreign key references PagoParcial(Id_Pago_Parcial) not null,
Id_Pago_Tarjeta char(5) foreign key references PagoTarjeta(Id_Pago_Tarjeta) not null
)
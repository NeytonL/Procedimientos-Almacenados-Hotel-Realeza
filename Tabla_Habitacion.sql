/* TABLA HABITACION
	-Insertar
	-Modificar
	-Dar de baja
	-Buscar
*/

create table Habitacion(
Id_Habitacion char(5) primary key not null,
NumeroHabitacion int identity(1,1) not null,
Precio money not null,
FechaRegistro datetime default getdate (),
Id_Tipo_Habitacion int foreign key references Tipo_Habitacion(Id_Tipo_Habitacion) 
)


--Insertar Habitacion
create procedure InsertarHabitacion
    @Id_Habitacion char(5),
	@NumeroHabitacion int, 
    @Precio money,
	@FechaRegistro datetime,
    @Id_Tipo_Habitacion int
as
begin
    if (@precio <= 0)
    begin
        print('El precio debe ser un valor positivo.')
    end
    else if isnumeric(cast(@precio as varchar)) = 0
    begin
        print('El precio no debe contener letras o caracteres especiales. Ingresa valores numericos')
        return;
    end
    else
    begin
        insert into Habitacion (Id_Habitacion, NumeroHabitacion, Precio, FechaRegistro , Id_Tipo_Habitacion)
        values (@Id_Habitacion, @NumeroHabitacion, @Precio, @FechaRegistro, @Id_Tipo_Habitacion)
    end
end

--Modificar Habitacion
create procedure ModificarHabitacion
    @Id_Habitacion char(5),
    @NumeroHabitacion int,
	@Precio money,
	@FechaRegistro datetime,
    @Id_Tipo_Habitacion int
as
begin
    if @precio <= 0
    begin
        print('El precio debe ser un valor positivo.')
    end
    else if isnumeric(cast(@precio as varchar)) = 0
    begin
        print('El precio no debe contener letras o caracteres especiales.');
    end
    else
    begin
        update Habitacion
        set NumeroHabitacion = @NumeroHabitacion,
			Precio = @Precio,
			FechaRegistro = @FechaRegistro,
            Id_Tipo_Habitacion = @Id_Tipo_Habitacion
        where Id_Habitacion = @Id_Habitacion
    end
end

--Buscar Habitacion xd
create procedure BuscarHabitacion
    @Id_Habitacion char(5)
as
begin
    select *
    from Habitacion
    where Id_Habitacion = @Id_Habitacion
end

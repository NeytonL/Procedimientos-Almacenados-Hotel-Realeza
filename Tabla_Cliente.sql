/* TABLA CLIENTE
	-Insertar
	-Modificar
	-Dar de baja
	-Buscar
*/

create table Cliente(
Id_Cliente char(5) primary key not null,
NombreCompleto  nvarchar(50) not null,
Gmail nvarchar(50) not null,
Telefono char(8) not null,
Cedula char(15) not null,
Estado bit,
FechaRegistro datetime default getdate ()
)

--Insertar
/* Validaciones hechas:
-El nombre solamente tenga letras minusculas, sin caracteres especiales y una longitud max de 50 caracteres

-Tenga el formato nombre@gmail.com para el gmail

-Intento de usar el formato de los telefonos de claro y tigo

-Intento de formato de cedula de identidad (123-456789-0123A)

-Que el cliente no se haya registrado (cedula)

*/
create procedure InsertarCliente
    @Id_Cliente char(5),
    @NombreCompleto nvarchar(50),
    @Gmail nvarchar(50),
    @Telefono char(8),
    @Cedula char(15),
	@Estado bit,
	@FechaRegistro datetime 
as
begin
    if @NombreCompleto not like '%[^a-z]%' and len(@NombreCompleto) <= 50
    begin
        if @Gmail like '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$' and len(@Gmail) <= 50
        begin
            if (@Telefono like '8%' or @Telefono like '7%') and len(@Telefono) = 8
            begin
                if @Cedula like '[0-9]{3}-[0-9]{6}-[0-9]{4}[A-Za-z]' and len(@Cedula) = 15
                begin
                    if not exists (select 1 from Cliente where Cedula = @Cedula)
                    begin
                        insert into Cliente(Id_Cliente, NombreCompleto, Gmail, Telefono, Cedula, Estado,FechaRegistro)
                        values (@Id_Cliente, @NombreCompleto, @Gmail, @Telefono, @Cedula, 1, getdate())

                        print 'Cliente insertado exitosamente.'
                    end
                    else
                    begin
                        print 'Ocurrió un error: La cédula ya está registrada en la base de datos.'
                    end
                end
                else
                begin
                    print 'Ocurrió un error: Formato de cédula incorrecto o excede el límite de caracteres.'
                end
            end
            else
            begin
                print 'Ocurrió un error: Formato de teléfono incorrecto o longitud inválida.'
            end
        end
        else
        begin
            print 'Ocurrió un error: Formato de Gmail incorrecto o excede el límite de caracteres.'
        end
    end
    else
    begin
        print 'Ocurrió un error: El Nombre completo contiene caracteres no permitidos o excede el límite de caracteres.'
    end
end



--Modificar cliente
/* Validaciones hechas:
-El nombre solamente tenga letras minusculas, sin caracteres especiales y una longitud max de 50 caracteres

-Tenga el formato nombre@gmail.com para el gmail

-Intento de usar el formato de los telefonos de claro y tigo

*/
create procedure ModificarCliente
    @Id_Cliente char(5),
    @NombreCompleto nvarchar(50),
    @Gmail nvarchar(50),
    @Telefono char(8),
	@Cedula char(15),
	@Estado bit,
	@FechaRegistro datetime

as
begin
    if @NombreCompleto not like '%[^a-z]%' and len(@NombreCompleto) <= 50
    begin
        if @Gmail like '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$' and len(@Gmail) <= 50
        begin
            if (@Telefono like '8%' or @Telefono like '7%') and len(@Telefono) = 8
            begin
                update Cliente
                set NombreCompleto = @NombreCompleto,
                    Gmail = @Gmail,
                    Telefono = @Telefono,
					Cedula = @Cedula,
					Estado = @Estado,
					FechaRegistro = @FechaRegistro --No la actualizo porque es el personal que lo hará (getdate())
                where Id_Cliente = @Id_Cliente

                print 'Cliente modificado exitosamente.'
            end
            else
            begin
                print 'Ocurrió un error: Formato de teléfono incorrecto o longitud inválida.'
            end
        end
        else
        begin
            print 'Ocurrió un error: Formato de Gmail incorrecto o excede el límite de caracteres.'
        end
    end
    else
    begin
        print 'Ocurrió un error: Nombre completo contiene caracteres no permitidos o excede el límite de caracteres.'
    end
end

--Dar de baja xd
create procedure DarDeBajaCliente
    @Id_Cliente char(5)
as
begin
    update Cliente
    set Estado = 0
    where Id_Cliente = @Id_Cliente

    print 'Cliente dado de baja exitosamente.'
end


--Buscar cliente xd
create procedure BuscarCliente
    @Id_Cliente char(5)
as
begin
    select *
    from Cliente
    where Id_Cliente = @Id_Cliente
end

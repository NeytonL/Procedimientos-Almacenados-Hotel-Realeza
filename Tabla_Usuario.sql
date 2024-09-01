/* TABLA USUARIO
	-Insertar
	-Modificar
	-Dar de baja
	-Buscar
*/

create table Usuario( 
Id_Usuarios char(5) primary key not null,
NombreCompleto  nvarchar(50) not null,
Gmail nvarchar(50) not null,
Telefono char(8) not null,
Cedula char(18) not null,
contraseña nvarchar (10) not null,
Estado bit,
FechaRegistro datetime default getdate (),
Id_Rol char(5) foreign key references Rol(Id_Rol) not null
)

--Insertar usuario xd
/*
-El nombre solamente tenga letras minusculas, sin caracteres especiales y una longitud max de 50 caracteres

-Tenga el formato nombre@gmail.com para el gmail

-Intento de usar el formato de los telefonos de claro y tigo

-Intento de formato de cedula de identidad (123-456789-0123A)

-Que el cliente no se haya registrado (cedula)

-La contraseña debe de tener al menos 5 caractres, puede alcanzar un máximo de 10 caractyeres, debe de tener una letra mayuscula y un caracter especial
*/
create procedure InsertarUsuario
    @Id_Usuarios char(5),
    @NombreCompleto nvarchar(50),
    @Gmail nvarchar(50),
    @Telefono char(8),
    @Cedula char(18),
    @contraseña nvarchar(10),
	@Estado bit,
	@FechaRegistro datetime,
    @Id_Rol char(5)
as
begin
    if @NombreCompleto not like '%[^a-z]%' and len(@NombreCompleto) <= 50
    begin
        if @Gmail like '[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$' and len(@Gmail) <= 50
        begin
            if (@Telefono like '8%' or @Telefono like '7%') and len(@Telefono) = 8
            begin
                if @Cedula like '[0-9]{3}-[0-9]{6}-[0-9]{4}[A-Za-z]' and len(@Cedula) = 18
                begin
                    if not exists (select 1 from Usuario where Cedula = @Cedula)
                    begin
                        if @contraseña like '%[!@#$%^&*(),.?":{}|<>]%' and @contraseña like '%[A-Z]%' and len(@contraseña) between 5 and 10
                        begin
                            insert into Usuario(Id_Usuarios, NombreCompleto, Gmail, Telefono, Cedula, contraseña, Estado, FechaRegistro,Id_Rol)
                            values (@Id_Usuarios, @NombreCompleto, @Gmail, @Telefono, @Cedula, @contraseña, 1, getdate(), @Id_Rol)

                            print 'Usuario insertado exitosamente.'
                        end
                        else
                        begin
                            print 'Ocurrió un error: La contraseña debe contener al menos un carácter especial, una letra mayúscula y tener entre 5 y 10 caracteres.'
                        end
                    end
                    else
                    begin
                        print 'Ocurrió un error: La cédula ya está registrada en la base de datos.'
                    end
                end
                else
                begin
                    print 'Ocurrió un error:El Formato de cédula incorrecto o excede el límite de caracteres.'
                end
            end
            else
            begin
                print 'Ocurrió un error:El Formato de teléfono incorrecto o longitud inválida.'
            end
        end
        else
        begin
            print 'Ocurrió un error:El Formato de Gmail incorrecto o excede el límite de caracteres.'
        end
    end
    else
    begin
        print 'Ocurrió un error:El Nombre completo contiene caracteres no permitidos o excede el límite de caracteres.'
    end
end

--Modificar Usuario
/*
-El nombre solamente tenga letras minusculas, sin caracteres especiales y una longitud max de 50 caracteres

-Tenga el formato nombre@gmail.com para el gmail

-Intento de usar el formato de los telefonos de claro y tigo

-Intento de formato de cedula de identidad (123-456789-0123A)

-Que el cliente no se haya registrado (cedula)

-La contraseña debe de tener al menos 5 caractres, puede alcanzar un máximo de 10 caractyeres, debe de tener una letra mayuscula y un caracter especial
*/
create procedure ModificarUsuario
    @Id_Usuarios char(5),
    @NombreCompleto nvarchar(50),
    @Gmail nvarchar(50),
    @Telefono char(8),
    @contraseña nvarchar(10),	
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
                if @contraseña like '%[!@#$%^&*(),.?":{}|<>]%' and @contraseña like '%[A-Z]%' and len(@contraseña) between 5 and 10
                begin
                    update Usuario
                    set NombreCompleto = @NombreCompleto,
                        Gmail = @Gmail,
                        Telefono = @Telefono,
                        contraseña = @contraseña,
						Estado = @Estado,
						FechaRegistro = @FechaRegistro
                    where Id_Usuarios = @Id_Usuarios

                    print 'Usuario modificado exitosamente.'
                end
                else
                begin
                    print 'Ocurrió un error: La contraseña debe contener al menos un carácter especial, una letra mayúscula y tener entre 5 y 10 caracteres.'
                end
            end
            else
            begin
                print 'Ocurrió un error: El Formato de teléfono incorrecto o longitud inválida.'
            end
        end
        else
        begin
            print 'Ocurrió un error: El Formato de Gmail incorrecto o excede el límite de caracteres.'
        end
    end
    else
    begin
        print 'Ocurrió un error: El Nombre completo contiene caracteres no permitidos o excede el límite de caracteres.'
    end
end

--Buscar usuario
create procedure BuscarUsuario
    @Id_Usuarios char(5)
as
begin
    select *
    from Usuario
    where Id_Usuarios = @Id_Usuarios
end



--Dar de baja al usuario xd
create procedure DarDeBajaUsuario
    @Id_Usuarios char(5)
as
begin
    update Usuario
    set Estado = 0
    where Id_Usuarios = @Id_Usuarios

    print 'Usuario dado de baja exitosamente.'
end



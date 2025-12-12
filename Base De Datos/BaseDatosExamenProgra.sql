-- ============================================================
-- CREACIÓN DE LA BASE DE DATOS
-- ============================================================
CREATE DATABASE ExanenFinalProgra
GO
USE ExanenFinalProgra


-- ============================================================
-- SE CREA LA TABLA ESTUDIANTES
-- ============================================================
GO 
CREATE TABLE Estudiantes
(
EstudianteID INT IDENTITY(1,1) PRIMARY KEY,
Identificacion NVARCHAR(50) NOT NULL UNIQUE,
PrimerNombre NVARCHAR(150) NOT NULL,
PrimerApellido NVARCHAR(150) NOT NULL,
SegundoNombre NVARCHAR(150),
SegundoApellido NVARCHAR(150),
FechaNacimiento DATE NOT NULL,
Edad INT,
Direccion NVARCHAR(250),
FechaCreacion DATETIME DEFAULT GETDATE(),
FechaModificacion DATETIME NULL
);



-- ============================================================
-- PROCEDIMIENTO: spCrearEstudiante
-- Recibe los datos, calcula la edad y devuelve el ID creado
-- ============================================================
GO
CREATE PROCEDURE spCrearEstudiante
(
@pIdentificacion NVARCHAR(50),
@pPrimerNombre NVARCHAR(150),
@pPrimerApellido NVARCHAR(150),
@pSegundoNombre NVARCHAR(150),
@pSegundoApellido NVARCHAR(150),
@pFechaNacimiento DATE,
@pDireccion NVARCHAR(250)
)
AS
BEGIN 
BEGIN TRY

-- Variables internas para manejo de errores y cálculos
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;
DECLARE @vEdad INT;
DECLARE @vCreado INT;
SET NOCOUNT ON;

-- Cálculo básico de edad
SET @vEdad = YEAR(GETDATE()) - YEAR(@pFechaNacimiento);

-- Inserción del estudiante
INSERT INTO Estudiantes 
(Identificacion,PrimerNombre,PrimerApellido,SegundoNombre,SegundoApellido,FechaNacimiento,Edad,Direccion)
VALUES
(@pIdentificacion,@pPrimerNombre,@pPrimerApellido,@pSegundoNombre,@pSegundoApellido,@pFechaNacimiento,@vEdad,@pDireccion);

-- Obtener el ID recién creado
SET @vCreado = SCOPE_IDENTITY();       

-- Devolverlo al cliente
SELECT @vCreado AS 'IDCreado';
END TRY
BEGIN CATCH

-- Captura y devuelve un error 
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;



-- ============================================================
-- PROCEDIMIENTO: spActualizarEstudiante
-- Modifica un registro existente según su ID
-- ============================================================
GO
CREATE PROCEDURE spActualizarEstudiante
(
@pEstudianteID INT,
@pIdentificacion NVARCHAR(50),
@pPrimerNombre NVARCHAR(150),
@pPrimerApellido NVARCHAR(150),
@pSegundoNombre NVARCHAR(150),
@pSegundoApellido NVARCHAR(150),
@pFechaNacimiento DATE,
@pDireccion NVARCHAR(250)
)
AS
BEGIN 

BEGIN TRY

-- Variables internas para manejo de errores y cálculos
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;
DECLARE @vEdad INT;
DECLARE @vActualizado INT;
SET NOCOUNT ON;

-- Cálculo actualizado de edad
SET @vEdad = YEAR(GETDATE()) - YEAR(@pFechaNacimiento);

-- Actualización de datos
UPDATE Estudiantes
SET
Identificacion = @pIdentificacion,
PrimerNombre = @pPrimerNombre,
PrimerApellido = @pPrimerApellido,
SegundoNombre = @pSegundoNombre,
SegundoApellido = @pSegundoApellido,
FechaNacimiento = @pFechaNacimiento,
Edad = @vEdad,
Direccion = @pDireccion,
FechaModificacion = GETDATE()
WHERE 
EstudianteID = @pEstudianteID;

-- Retorna cuántas filas fueron afectadas
SET @vActualizado =@@ROWCOUNT;
SELECT @vActualizado AS 'FilaActualizada';

END TRY
BEGIN CATCH

-- Captura y devuelve un error 
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;



-- ============================================================
-- PROCEDIMIENTO: spEliminarEstudiante
-- Elimina un estudiante por ID
-- ============================================================
GO
CREATE PROCEDURE spEliminarEstudiante
(
@pEstudianteID INT
)
AS
BEGIN 

BEGIN TRY

-- Variables internas para manejo de errores
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;
DECLARE @vEdad INT;
DECLARE @vEliminado INT;
SET NOCOUNT ON;

-- Eliminación por ID
DELETE Estudiantes
WHERE EstudianteID = @pEstudianteID;

-- Devuelve si se eliminó o no
SET @vEliminado = @@ROWCOUNT;
SELECT @vEliminado AS 'FilaActualizada';

END TRY
BEGIN CATCH

-- Captura y devuelve un error 
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;



-- ============================================================
-- PROCEDIMIENTO: spListarEstudiantes
-- Devuelve todos los estudiantes registrados
-- ============================================================
GO
CREATE PROCEDURE spListarEstudiantes

AS
BEGIN 

BEGIN TRY

-- Variables internas para manejo de errores
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;

SELECT EstudianteID, Identificacion, PrimerNombre, PrimerApellido, SegundoNombre, SegundoApellido, FechaNacimiento, Edad, Direccion
FROM Estudiantes

END TRY
BEGIN CATCH

-- Captura y devuelve un error 
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;


-- ============================================================
-- PROCEDIMIENTO: spBuscarEstudiante
-- Devuelve únicamente el estudiante solicitado
-- ============================================================
GO
CREATE PROCEDURE spBuscarEstudiante
(
@pEstudianteID INT
)

AS
BEGIN 
BEGIN TRY

-- Variables internas para manejo de errores
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;

SELECT EstudianteID, Identificacion, PrimerNombre, PrimerApellido, SegundoNombre, SegundoApellido, FechaNacimiento, Edad, Direccion
FROM Estudiantes
WHERE EstudianteID = @pEstudianteID;

END TRY
BEGIN CATCH

-- Captura y devuelve un error 
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;
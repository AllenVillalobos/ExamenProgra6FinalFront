CREATE DATABASE ExanenFinalProgra
GO
USE ExanenFinalProgra

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
        DECLARE @MessaError VARCHAR(100);
        DECLARE @SeveidaError INT;
        DECLARE @EstadoError INT;
        DECLARE @vEdad INT;
        DECLARE @vCreado INT;
        
		SET NOCOUNT ON;
        SET @vEdad = YEAR(GETDATE()) - YEAR(@pFechaNacimiento);

        INSERT INTO Estudiantes 
             (Identificacion,PrimerNombre,PrimerApellido,SegundoNombre,SegundoApellido,FechaNacimiento,Edad,Direccion)
        VALUES
             (@pIdentificacion,@pPrimerNombre,@pPrimerApellido,@pSegundoNombre,@pSegundoApellido,@pFechaNacimiento,@vEdad,@pDireccion);

        SET @vCreado = SCOPE_IDENTITY();
        
		SELECT @vCreado AS 'IDCreado';

      END TRY
BEGIN CATCH
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;


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
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;
DECLARE @vEdad INT;
DECLARE @vActualizado INT;
SET NOCOUNT ON;

SET @vEdad = YEAR(GETDATE()) - YEAR(@pFechaNacimiento);

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

SET @vActualizado =@@ROWCOUNT;
SELECT @vActualizado AS 'FilaActualizada';

END TRY
BEGIN CATCH
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;



GO
CREATE PROCEDURE spEliminarEstudiante
(
@pEstudianteID INT
)
AS
BEGIN 

BEGIN TRY
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;
DECLARE @vEdad INT;
DECLARE @vEliminado INT;
SET NOCOUNT ON;

DELETE Estudiantes
WHERE EstudianteID = @pEstudianteID;

SET @vEliminado = @@ROWCOUNT;
SELECT @vEliminado AS 'FilaActualizada';

END TRY
BEGIN CATCH
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;


GO
CREATE PROCEDURE spListarEstudiantes

AS
BEGIN 

BEGIN TRY
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;

SELECT EstudianteID, Identificacion, PrimerNombre, PrimerApellido, SegundoNombre, SegundoApellido, FechaNacimiento, Edad, Direccion
FROM Estudiantes

END TRY
BEGIN CATCH
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;



GO
CREATE PROCEDURE spBuscarEstudiante
(
@pEstudianteID INT
)

AS
BEGIN 

BEGIN TRY
DECLARE @MessaError VARCHAR(100);
DECLARE @SeveidaError INT;
DECLARE @EstadoError INT;

SELECT EstudianteID, Identificacion, PrimerNombre, PrimerApellido, SegundoNombre, SegundoApellido, FechaNacimiento, Edad, Direccion
FROM Estudiantes
WHERE EstudianteID = @pEstudianteID;

END TRY
BEGIN CATCH
SELECT 
@MessaError = ERROR_MESSAGE(),
@SeveidaError = ERROR_SEVERITY(),
@EstadoError = ERROR_STATE();
RAISERROR(@MessaError, @SeveidaError, @EstadoError);
END CATCH
END;
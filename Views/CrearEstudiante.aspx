<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="CrearEstudiante.aspx.cs" Inherits="ExamenProgra6FinalFront.Views.CrearEstudiante" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>
    <title>Crear Estudiantes</title>
</head>
<body class="bg-light">
    <form id="form1" runat="server">

        <div class="container mt-5">

            <h2 class="text-center mb-4">Crear Estudiante</h2>

            <!-- Identificación -->
            <div class="mb-3">
                <label class="form-label">Identificación</label>
                <asp:TextBox runat="server" ID="txtIdentificacion" CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvIdentificacion"
                    ControlToValidate="txtIdentificacion" ErrorMessage="La identificación es obligatoria"
                    ForeColor="Red" Enabled="false" />

                <asp:CompareValidator runat="server" ID="cvIdentificacion"
                    ControlToValidate="txtIdentificacion" Operator="DataTypeCheck" Type="Integer"
                    ErrorMessage="La identificación debe contener solo números" ForeColor="Red" Enabled="false" />
            </div>


            <!-- Primer Nombre -->
            <div class="mb-3">
                <label class="form-label">Primer Nombre</label>
                <asp:TextBox runat="server" ID="txtPrimerNombre" CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvPrimerNombre"
                    ControlToValidate="txtPrimerNombre" ErrorMessage="El primer nombre es obligatorio"
                    ForeColor="Red" Enabled="false" />
            </div>


            <!-- Segundo Nombre -->
            <div class="mb-3">
                <label class="form-label">Segundo Nombre</label>
                <asp:TextBox runat="server" ID="txtSegundoNombre" CssClass="form-control"></asp:TextBox>
            </div>


            <!-- Primer Apellido -->
            <div class="mb-3">
                <label class="form-label">Primer Apellido</label>
                <asp:TextBox runat="server" ID="txtPrimerApellido" CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvPrimerApellido"
                    ControlToValidate="txtPrimerApellido" ErrorMessage="El primer apellido es obligatorio"
                    ForeColor="Red" Enabled="false" />
            </div>


            <!-- Segundo Apellido -->
            <div class="mb-3">
                <label class="form-label">Segundo Apellido</label>
                <asp:TextBox runat="server" ID="txtSegundoApellido" CssClass="form-control"></asp:TextBox>
            </div>


            <!-- Fecha de nacimiento -->
            <div class="mb-3">
                <label class="form-label">Fecha Nacimiento</label>
                <div class="border rounded p-2 bg-white">
                    <asp:Calendar runat="server" ID="cFechaNecimiento"></asp:Calendar>
                </div>
            </div>


            <!-- Dirección -->
            <div class="mb-3">
                <label class="form-label">Dirección</label>
                <asp:TextBox runat="server" ID="txtDireccion" TextMode="MultiLine" Rows="3"
                    CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvDireccion"
                    ControlToValidate="txtDireccion" ErrorMessage="La dirección es obligatoria"
                    ForeColor="Red" Enabled="false" />
            </div>

            <!-- Botones -->
            <div class="mt-4">
                <asp:Button runat="server" ID="btnCrear" Text="➕ Crear Estudiante"
                    CssClass="btn btn-primary me-2" OnClick="btnCrear_Click" />

                <asp:Button runat="server" ID="btnVolver" Text="⬅️ Volver"
                    CssClass="btn btn-secondary" OnClick="btnVolver_Click" />
            </div>


            <!-- Mensaje -->
            <asp:Label runat="server" ID="lblMensaje" CssClass="fw-bold mt-3"></asp:Label>

        </div>

    </form>
</body>
</html>

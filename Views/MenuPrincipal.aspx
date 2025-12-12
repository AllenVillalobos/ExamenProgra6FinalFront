<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="MenuPrincipal.aspx.cs" Inherits="ExamenProgra6FinalFront.Views.MenuPrincipal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js" integrity="sha384-FKyoEForCGlyvwx9Hj09JcYn3nv7wiPVlz7YYwJrWVcXK/BmnVDxM+D2scQbITxI" crossorigin="anonymous"></script>

    <title>Menú Principal</title>
</head>
<body class="bg-light">
    <form id="form1" runat="server">
        <div class="container mt-4">
            <h1 class="text-center mb-4">Menú Principal</h1>

            <!-- Buscar Estudiante -->
            <div class="mb-3">
                <label class="form-label">Buscar estudiante por ID</label>
                <asp:TextBox runat="server" ID="txtBuscar" CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvBuscar"
                    ControlToValidate="txtBuscar" ErrorMessage="La ID es obligatoria para filtrar"
                    ForeColor="Red" Enabled="false" />

                <asp:CompareValidator runat="server" ID="cvBuscar"
                    ControlToValidate="txtBuscar" Operator="DataTypeCheck" Type="Integer"
                    ErrorMessage="Debe ingresar un ID numérico" ForeColor="Red" Enabled="false" />
            </div>

            <asp:Button runat="server" ID="btnBuscar" Text="Buscar"
                CssClass="btn btn-primary mb-4" OnClick="btnBuscar_Click" />

            <!-- Lista -->
            <h4>Lista de Estudiantes</h4>

            <asp:GridView EmptyDataText="No se encontraron estudiantes" runat="server" ID="gvEstudiantes"
                CssClass="table table-bordered table-striped mt-2"
                AutoGenerateColumns="false"
                OnSelectedIndexChanged="gvEstudiantes_SelectedIndexChanged">

                <Columns>
                    <asp:BoundField DataField="EstudianteID" HeaderText="ID" />
                    <asp:BoundField DataField="Identificacion" HeaderText="Identificación" />
                    <asp:BoundField DataField="PrimerNombre" HeaderText="Primer Nombre" />
                    <asp:BoundField DataField="SegundoNombre" HeaderText="Segundo Nombre" />
                    <asp:BoundField DataField="PrimerApellido" HeaderText="Primer Apellido" />
                    <asp:BoundField DataField="SegundoApellido" HeaderText="Segundo Apellido" />
                    <asp:BoundField DataField="FechaNacimiento" HeaderText="Nacimiento" DataFormatString="{0:dd-MM-yyyy}" />
                    <asp:BoundField DataField="Edad" HeaderText="Edad" />
                    <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                    <asp:CommandField ShowSelectButton="true" SelectText="Seleccionar" />
                </Columns>

            </asp:GridView>


            <!-- Botones para los reportes -->
            <div class="mt-3 mb-4">
                <asp:Button runat="server" ID="btnPDF" Text="📄 Descargar PDF"
                    CssClass="btn btn-danger me-2" OnClick="btnPDF_Click" />

                <asp:Button runat="server" ID="btnExcel" Text="📊 Descargar Excel"
                    CssClass="btn btn-success me-2" OnClick="btnExcel_Click" />

                <asp:Button runat="server" ID="btnRefrescar" Text="🔄 Refrescar Lista"
                    CssClass="btn btn-secondary" OnClick="btnRefrescar_Click" />
            </div>


            <!-- Editar/Eliminar -->
            <h3 class="mt-5">Actualizar / Eliminar Estudiantes</h3>


            <!-- ID -->
            <div class="mb-3">
                <label class="form-label">ID del Estudiante</label>
                <asp:TextBox runat="server" ID="txtID" CssClass="form-control" ReadOnly="true"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvID"
                    ControlToValidate="txtID" ErrorMessage="Debe seleccionar un estudiante"
                    ForeColor="Red" Enabled="false" />

                <asp:CompareValidator runat="server" ID="cvID"
                    ControlToValidate="txtID" Operator="DataTypeCheck" Type="Integer"
                    ErrorMessage="Debe ser numérico" ForeColor="Red" Enabled="false" />
            </div>


            <!-- Identificación -->
            <div class="mb-3">
                <label class="form-label">Identificación</label>
                <asp:TextBox runat="server" ID="txtIdentificacion" CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvIdentificacion"
                    ControlToValidate="txtIdentificacion" ErrorMessage="Campo obligatorio"
                    ForeColor="Red" Enabled="false" />

                <asp:CompareValidator runat="server" ID="cvIdentificacion"
                    ControlToValidate="txtIdentificacion" Operator="DataTypeCheck" Type="Integer"
                    ErrorMessage="Debe contener solo números" ForeColor="Red" Enabled="false" />
            </div>


            <!-- Primer Nombre -->
            <div class="mb-3">
                <label class="form-label">Primer Nombre</label>
                <asp:TextBox runat="server" ID="txtPrimerNombre" CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvPrimerNombre"
                    ControlToValidate="txtPrimerNombre" ErrorMessage="Campo obligatorio"
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
                    ControlToValidate="txtPrimerApellido" ErrorMessage="Campo obligatorio"
                    ForeColor="Red" Enabled="false" />
            </div>


            <!-- Segundo Apellido -->
            <div class="mb-3">
                <label class="form-label">Segundo Apellido</label>
                <asp:TextBox runat="server" ID="txtSegundoApellido" CssClass="form-control"></asp:TextBox>
            </div>


            <!-- Fecha de nacimiento -->
            <div class="mb-3">
                <label class="form-label">Fecha de Nacimiento</label>
                <div class="border rounded p-2 bg-white">
                    <asp:Calendar runat="server" ID="cFechaNecimiento"></asp:Calendar>
                </div>
            </div>


            <!-- Dirección -->
            <div class="mb-3">
                <label class="form-label">Dirección</label>
                <asp:TextBox runat="server" ID="txtDireccion" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>

                <asp:RequiredFieldValidator runat="server" ID="rfvDireccion"
                    ControlToValidate="txtDireccion" ErrorMessage="Campo obligatorio"
                    ForeColor="Red" Enabled="false" />
            </div>


            <!-- Botones de acción-->
            <div class="mt-4 mb-5">

                <asp:Button runat="server" ID="btnCrear" Text="➕ Crear Estudiante"
                    CssClass="btn btn-success me-2" OnClick="btnCrear_Click" />

                <asp:Button runat="server" ID="btnActualizar" Text="✏️ Actualizar"
                    CssClass="btn btn-warning me-2" OnClick="btnActualizar_Click" Enabled="false" />

                <asp:Button runat="server" ID="btnEliminar" Text="🗑️ Eliminar"
                    CssClass="btn btn-danger me-2" OnClick="btnEliminar_Click" Enabled="false" />

                <asp:Button runat="server" ID="btnLimpiar" Text="🧹 Limpiar Campos"
                    CssClass="btn btn-secondary" OnClick="btnLimpiar_Click" />

            </div>

            <!-- Mensaje -->
            <asp:Label runat="server" ID="lblMensaje" CssClass="fw-bold text-success d-block"></asp:Label>

        </div>
    </form>
</body>
</html>

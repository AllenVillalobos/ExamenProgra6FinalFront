<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="MenuPrincipal.aspx.cs" Inherits="ExamenProgra6FinalFront.Views.MenuPrincipal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Menú Principal</title>
</head>
<body>
    <form id="form1" runat="server">

        <h1>Menú Principal</h1>
        <asp:Label runat="server">Busca un estuduante por ID</asp:Label>
        <asp:TextBox runat="server" ID="txtBuscar"></asp:TextBox>
        <asp:RequiredFieldValidator runat="server" ID="rfvBuscar" ControlToValidate="txtBuscar" ErrorMessage="La identificación es obligatoria para buscar" ForeColor="Red" Enabled="false" />

        <asp:CompareValidator runat="server" ControlToValidate="txtBuscar" ID="cvBuscar" Operator="DataTypeCheck" Type="Integer"
            ErrorMessage="Para buscar estudiantes, ingrese un ID adecuado (numérico)" ForeColor="Red" Enabled="false" />

        <asp:Button runat="server" ID="btnBuscar" OnClick="btnBuscar_Click" Text="Buscar" />
        <asp:Label runat="server">Lista de Estudiantes</asp:Label>

        <asp:GridView runat="server" ID="gvEstudiantes" AutoGenerateColumns="false" OnSelectedIndexChanged="gvEstudiantes_SelectedIndexChanged">
            <Columns>
                <asp:BoundField DataField="EstudianteID" HeaderText="ID" />
                <asp:BoundField DataField="Identificacion" HeaderText="Identificación" />
                <asp:BoundField DataField="PrimerNombre" HeaderText="Primer Nombre" />
                <asp:BoundField DataField="SegundoNombre" HeaderText="Segundo Nombre" />
                <asp:BoundField DataField="PrimerApellido" HeaderText="Primer Apellido" />
                <asp:BoundField DataField="SegundoApellido" HeaderText="Segundo Apellido" />
                <asp:BoundField DataField="FechaNacimiento" HeaderText="Fecha De Nacimiento" DataFormatString="{0:dd-MM-yyyy}" />
                <asp:BoundField DataField="Edad" HeaderText="Edad" />
                <asp:BoundField DataField="Direccion" HeaderText="Dirección" />
                <asp:CommandField ShowSelectButton="true" SelectText="Seleccionar" />
            </Columns>
        </asp:GridView>
        <asp:Button runat="server" ID="btnPDF" Text="Descargar Lista en PDF" OnClick="btnPDF_Click" />
        <asp:Button runat="server" ID="btnExcel" Text="Descargar Lista en Excel" OnClick="btnExcel_Click" />
        <asp:Button runat="server" ID="btnRefrescar" OnClick="btnRefrescar_Click" Text="Refrescar Lista" />

        <h2>Actualizar / Eliminar Estudiantes</h2>
        <asp:Label runat="server">ID del Estudiante</asp:Label>
        <asp:TextBox runat="server" ID="txtID" ReadOnly="true" />

        <asp:RequiredFieldValidator runat="server" ID="rfvID" ControlToValidate="txtID" ErrorMessage="Seleccione un estudiante de la lista" ForeColor="Red" Enabled="false" />

        <asp:CompareValidator runat="server" ID="cvID" ControlToValidate="txtID" Operator="DataTypeCheck" Type="Integer"
            ErrorMessage="El ID del estudiante solo puede ser numérico" ForeColor="Red" Enabled="false" />
        <br />


        <asp:Label runat="server">Identificación:</asp:Label>
        <asp:TextBox runat="server" ID="txtIdentificacion" />

        <asp:RequiredFieldValidator runat="server" ID="rfvIdentificacion" ControlToValidate="txtIdentificacion" ErrorMessage="La identificación es obligatoria" ForeColor="Red" Enabled="false" />

        <asp:CompareValidator runat="server" ID="cvIdentificacion" ControlToValidate="txtIdentificacion" Operator="DataTypeCheck" Type="Integer"
            ErrorMessage="La identificación debe contener solo números" ForeColor="Red" Enabled="false" />
        <br />


        <asp:Label runat="server">Primer Nombre:</asp:Label>
        <asp:TextBox runat="server" ID="txtPrimerNombre" />
        <asp:RequiredFieldValidator runat="server" ID="rfvPrimerNombre" ControlToValidate="txtPrimerNombre" ErrorMessage="El primer nombre es obligatorio" ForeColor="Red" Enabled="false" />
        <br />

        <asp:Label runat="server">Segundo Nombre:</asp:Label>
        <asp:TextBox runat="server" ID="txtSegundoNombre" />
        <br />

        <asp:Label runat="server">Primer Apellido:</asp:Label>
        <asp:TextBox runat="server" ID="txtPrimerApellido" />
        <asp:RequiredFieldValidator runat="server" ID="rfvPrimerApellido" ControlToValidate="txtPrimerNombre" ErrorMessage="El primer apellido es obligatorio" ForeColor="Red" Enabled="false" />
        <br />

        <asp:Label runat="server">Segundo Apellido:</asp:Label>
        <asp:TextBox runat="server" ID="txtSegundoApellido" />
        <br />

        <asp:Label runat="server">Fecha Nacimiento:</asp:Label>
        <asp:Calendar runat="server" ID="cFechaNecimiento"></asp:Calendar>
        <br />

        <asp:Label runat="server">Dirección:</asp:Label>
        <asp:TextBox runat="server" ID="txtDireccion" TextMode="MultiLine" Rows="3" />
        <asp:RequiredFieldValidator runat="server" ID="rfvDireccion" ControlToValidate="txtDireccion" ErrorMessage="La dirección es obligatoria" ForeColor="Red" Enabled="false" />
        <br />
        <br />

        <!-- BOTONES -->
        <asp:Button runat="server" ID="btnActualizar" Text="Actualizar" OnClick="btnActualizar_Click" Enabled="false" />
        <asp:Button runat="server" ID="btnEliminar" Text="Eliminar" OnClick="btnEliminar_Click" Enabled="false" />

        <br />
        <br />
        <asp:Label runat="server" ID="lblMensaje" />
    </form>
</body>
</html>

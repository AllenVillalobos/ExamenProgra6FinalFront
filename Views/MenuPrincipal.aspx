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

        <asp:Label runat="server">Lista de Estudiantes</asp:Label>
        <asp:Button runat="server" ID="btnBuscar" />

        <asp:GridView runat="server" ID="gvEstudiantes" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="EstudianteID" HeaderText="ID" />
                <asp:BoundField DataField="Identificacion" HeaderText="Identificacion" />
                <asp:BoundField DataField="PrimerNombre" HeaderText="Primer Nombre" />
                <asp:BoundField DataField="SegundoNombre" HeaderText="Segundo Nombre" />
                <asp:BoundField DataField="PrimerApellido" HeaderText="Primer Apellido" />
                <asp:BoundField DataField="SegundoApellido" HeaderText="Segundo Apellido" />
                <asp:BoundField DataField="FechaNacimiento" HeaderText="Fecha Nacimiento" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="Edad" HeaderText="Edad" />
                <asp:BoundField DataField="Direccion" HeaderText="Direccion" />
                <asp:CommandField ShowSelectButton="true" SelectText="Seleccionar" />
            </Columns>
        </asp:GridView>
        <asp:Button runat="server" ID="btnPDF" Text="Descargar Lista en PDF" />
        <asp:Button runat="server" ID="btnExcel" Text="Descargar Lista en Excel" />

        <h2>Actualizar / Eliminar Estudiantes</h2>
        <asp:Label runat="server">ID del Estudiante</asp:Label>
        <asp:TextBox runat="server" ID="txtBuscarID" ReadOnly="true" />
        <br />


        <asp:Label runat="server">Identificación:</asp:Label>
        <asp:TextBox runat="server" ID="txtIdentificacion" />
        <br />


        <asp:Label runat="server">Primer Nombre:</asp:Label>
        <asp:TextBox runat="server" ID="txtPrimerNombre" />
        <br />

        <asp:Label runat="server">Segundo Nombre:</asp:Label>
        <asp:TextBox runat="server" ID="txtSegundoNombre" />
        <br />

        <asp:Label runat="server">Primer Apellido:</asp:Label>
        <asp:TextBox runat="server" ID="txtPrimerApellido" />
        <br />

        <asp:Label runat="server">Segundo Apellido:</asp:Label>
        <asp:TextBox runat="server" ID="txtSegundoApellido" />
        <br />

        <asp:Label runat="server">Fecha Nacimiento:</asp:Label>
        <asp:Calendar runat="server" ID="Calendario"></asp:Calendar>
        <br />

        <asp:Label runat="server">Dirección:</asp:Label>
        <asp:TextBox runat="server" ID="txtDireccion" TextMode="MultiLine" Rows="3" />
        <br />
        <br />

        <!-- BOTONES -->
        <asp:Button runat="server" ID="btnActualizar" Text="Actualizar" OnClick="btnActualizar_Click" />
        <asp:Button runat="server" ID="btnEliminar" Text="Eliminar" OnClick="btnEliminar_Click" />

        <br />
        <br />
        <asp:Label runat="server" ID="lblMensaje" />
    </form>
</body>
</html>

<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="CrearEstudiante.aspx.cs" Inherits="ExamenProgra6FinalFront.Views.CrearEstudiante" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>Crear Estudiantes</h1>

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

            <asp:Button runat="server" ID="btnCrear" Text="Crear Estudiante" OnClick="btnCrear_Click" />
            <asp:Button runat="server" ID="btnVolver" Text="Volver" OnClick="btnVolver_Click" />

            <br />
            <br />
            <asp:Label runat="server" ID="lblMensaje" />
        </div>
    </form>
</body>
</html>

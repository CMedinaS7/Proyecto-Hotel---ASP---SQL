<%@ Page Language="VB" Debug="true" %>
<%@ import namespace="system.data.sqlclient"%>
<%@ import namespace="system.data.sql"%>
<%@ import namespace="system.data.dataset"%>
<%@ import namespace="system.data"%>
<%@ import Namespace="system.IO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Dim cnn As New SqlConnection()
    Dim ObjCommand As SqlCommand
    Dim ObjDataAdapter As SqlDataAdapter
    Dim ObjDataSet As DataSet
    
    Sub limpiar()
        Me.txtape.Text = ""
        Me.txtclave.Text = ""
        Me.txtemail.Text = ""
        Me.txtid.Text = ""
        Me.txtfoto.Text = ""
        Me.txtnom.Text = ""
        Me.txttel.Text = ""
    End Sub
    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Call limpiar()
    End Sub
    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec insertarcliente '" + Me.txtid.Text + "','" + Me.txtclave.Text + "','" + Me.txtnom.Text + "','" + Me.txtape.Text + "','" + Me.txttel.Text + "','" + Me.ddlsexo.Text + "','" + Me.txtemail.Text + "','" + Me.txtfoto.Text + "','" + Me.ddlnac.Text + "'", cnn)
        MsgBox("Registro Exitoso", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        cnn.Open()
        sqlinsertar.ExecuteNonQuery()
        cnn.Close()
        Response.Redirect("login.aspx", True)
        Me.Button2.PostBackUrl = "login.aspx"
        limpiar()
        
               
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
    End Sub

   </script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Página sin título</title>
</head>
<body bgcolor="#ffffff">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <center><table style="background-image: url(Imagenes/fondo_registrarse.jpg); width: 445px; height: 438px">
            <tr>
                <td colspan="5" style="height: 30px">
                    &nbsp;&nbsp;
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BDhotelConnectionString20 %>"
                        SelectCommand="SELECT * FROM [nacionalidad]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 67px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <asp:Label ID="Label1" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="Identificación:"></asp:Label></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtid" runat="server" Width="146px"></asp:TextBox></td>
                <td style="width: 67px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtid"
                        ErrorMessage="*" ForeColor="LightGray"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <asp:Label ID="Label2" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="Clave:"></asp:Label></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtclave" runat="server" TextMode="Password" Width="146px"></asp:TextBox></td>
                <td style="width: 67px">
                    </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 26px;">
                </td>
                <td style="width: 100px; height: 26px; text-align: right;">
                    <asp:Label ID="Label3" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="Nombres:"></asp:Label></td>
                <td style="width: 100px; height: 26px;">
                    <asp:TextBox ID="txtnom" runat="server" Width="146px"></asp:TextBox></td>
                <td style="width: 67px; height: 26px;">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtnom"
                        ErrorMessage="*" ForeColor="LightGray"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <asp:Label ID="Label4" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="Apellidos:"></asp:Label></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtape" runat="server" Width="146px"></asp:TextBox></td>
                <td style="width: 67px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtape"
                        ErrorMessage="*" ForeColor="LightGray"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <asp:Label ID="Label5" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="Teléfono:"></asp:Label></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txttel" runat="server" Width="146px"></asp:TextBox></td>
                <td style="width: 67px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="txttel"
                        ErrorMessage="*" ForeColor="LightGray"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <asp:Label ID="Label8" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="Sexo:"></asp:Label></td>
                <td style="width: 100px">
                    <asp:DropDownList ID="ddlsexo" runat="server" Width="152px">
                        <asp:ListItem>Masculino</asp:ListItem>
                        <asp:ListItem>Femenino</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="width: 67px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <asp:Label ID="Label6" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="E-mail:"></asp:Label></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtemail" runat="server" Width="146px"></asp:TextBox></td>
                <td style="width: 67px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <asp:Label ID="Label9" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="Foto:"></asp:Label></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtfoto" runat="server"></asp:TextBox></td>
                <td style="width: 67px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <asp:Label ID="Label7" runat="server" Font-Bold="False" Font-Names="Calibri" ForeColor="Black"
                        Text="País:"></asp:Label></td>
                <td style="width: 100px">
                    <asp:DropDownList ID="ddlnac" runat="server" DataSourceID="SqlDataSource1" DataTextField="nombre"
                        DataValueField="cod_nacionalidad" Width="151px">
                    </asp:DropDownList>
                    &nbsp;
                </td>
                <td style="width: 67px">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="ddlnac"
                        ErrorMessage="*" ForeColor="LightGray"></asp:RequiredFieldValidator></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 67px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 21px">
                </td>
                <td colspan="2" style="height: 21px; text-align: center">
                    &nbsp;<asp:Button ID="Button1" runat="server" Text="LIMPIAR" OnClick="Button1_Click" />
                    &nbsp; &nbsp;<asp:Button ID="Button2" runat="server" Text="REGISTRARSE" OnClick="Button2_Click" Width="106px" /></td>
                <td style="width: 67px; height: 21px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 21px">
                </td>
                <td style="width: 100px; height: 21px">
                </td>
                <td style="width: 100px; height: 21px">
                </td>
                <td style="width: 67px; height: 21px">
                </td>
            </tr>
        </table></center>
    
    </div>
    </form>
</body>
</html>

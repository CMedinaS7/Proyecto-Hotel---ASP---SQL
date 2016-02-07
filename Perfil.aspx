<%@ Page Language="VB" Debug="true" %>
<%@ import namespace="system.data.sqlclient"%>
<%@ import namespace="system.data.sql"%>
<%@ import namespace="system.data.dataset"%>
<%@ import namespace="system.data"%>
<%@ import Namespace="system.IO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Dim objConnection As New SqlConnection()
    Dim ObjCommand As SqlCommand
    Dim ObjDataAdapter As SqlDataAdapter
    Dim ObjDataSet As DataSet
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        objConnection.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        Me.txtcod.Text = Request.QueryString().ToString()
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec modpersonal '" + Me.txtcod.Text + "','" + Me.txtusu.Text + "','" + Me.txtclave.Text + "','" + Me.txtnom.Text + "','" + Me.txtape.Text + "','" + Me.txttel.Text + "','" + Me.DropDownList1.Text + "','" + Me.txtemail.Text + "','" + Me.txtemail.Text + "','" + Me.DropDownList2.Text + "'", objConnection)
        objConnection.Open()
        sqlinsertar.ExecuteNonQuery()
        objConnection.Close()
        MsgBox("Registro Exitoso", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        objConnection.Open()
        
        'Dim c As String
        Dim CMD As New SqlCommand("buscapersonal", objConnection)
        With CMD
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add(New SqlParameter("@codigo", Trim(Me.txtcod.Text)))
            Dim DA As New SqlDataAdapter(CMD)
            Dim DT As New DataTable
            DA.Fill(DT)
            If DT.Rows.Count() = 0 Then
                MsgBox("Personal no Encontrado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Else
                Me.txtcod.Text = DT.Rows(0).Item("cod_personal")
                Me.txtusu.Text = DT.Rows(0).Item("usuario")
                Me.txtclave.Text = DT.Rows(0).Item("clave")
                Me.txtnom.Text = DT.Rows(0).Item("nombres")
                Me.txtape.Text = DT.Rows(0).Item("apellidos")
                Me.txttel.Text = DT.Rows(0).Item("telefono")
                Me.DropDownList1.Text = DT.Rows(0).Item("sexo")
                Me.txtemail.Text = DT.Rows(0).Item("e_mail")
            End If
        End With
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Página sin título</title>
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
        <center><table style="background-image: url(Imagenes/fondo_perfil.jpg); width: 540px; height: 423px">
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <span style="color: #006600; font-family: Calibri"><strong>
                    Codigo:</strong></span></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtcod" runat="server"></asp:TextBox></td>
                <td style="width: 100px">
                </td>
                <td colspan="2">
                </td>
                <td colspan="1">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <strong><span style="color: #006600; font-family: Calibri">
                    Usuario:</span></strong></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtusu" runat="server"></asp:TextBox></td>
                <td style="width: 100px">
                    </td>
                <td colspan="2" rowspan="4">
                    <asp:Image ID="Image1" runat="server" Height="80px" ImageUrl="~/Imagenes/user.jpg"
                        Width="90px" /><br />
                    <br />
                    <asp:Button ID="Button3" runat="server" Text="EXAMINAR" /></td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <strong><span style="color: #006600; font-family: Calibri">
                    Clave:</span></strong></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtclave" runat="server"></asp:TextBox></td>
                <td style="width: 100px">
                    </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <strong><span style="color: #006600; font-family: Calibri">
                    Nombres:</span></strong></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtnom" runat="server"></asp:TextBox></td>
                <td style="width: 100px">
                    </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <strong><span style="color: #006600; font-family: Calibri">
                    Apellidos:</span></strong></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtape" runat="server"></asp:TextBox></td>
                <td style="width: 100px">
                    </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <span style="color: #006600; font-family: Calibri"><strong>
                    Telefono:</strong></span></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txttel" runat="server"></asp:TextBox></td>
                <td style="width: 100px">
                    </td>
                <td colspan="2" rowspan="2">
                    <asp:Button ID="Button1" runat="server" Text="MODIFICAR" Width="116px" OnClick="Button1_Click" /><br />
                    <asp:Button ID="Button2" runat="server" Text="ACTUALIZAR" OnClick="Button2_Click" /></td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <span style="color: #006600; font-family: Calibri"><strong>
                    Sexo:</strong></span></td>
                <td style="width: 100px">
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="152px">
                        <asp:ListItem>Masculino</asp:ListItem>
                        <asp:ListItem>Femenino</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <span style="color: #006600; font-family: Calibri"><strong>
                    E-Mail:</strong></span></td>
                <td style="width: 100px">
                    <asp:TextBox ID="txtemail" runat="server"></asp:TextBox></td>
                <td style="width: 100px">
                </td>
                <td colspan="2">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                    <strong><span style="color: #006600; font-family: Calibri">Cargol:</span></strong></td>
                <td style="width: 100px; text-align: left;">
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="descripcion" DataValueField="cod_cargo" Width="155px">
                    </asp:DropDownList>
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td colspan="7">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BDhotelConnectionString21 %>"
                        SelectCommand="SELECT * FROM [cargo]"></asp:SqlDataSource>
                </td>
            </tr>
        </table></center>
    
    </div>
    </form>
</body>
</html>

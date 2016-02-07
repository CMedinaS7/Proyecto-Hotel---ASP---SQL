<%@ import namespace="system.data.sqlclient"%>

<%@ import Namespace="system.IO"%>

<%@ import Namespace="system.data"%>

<%@ Page Language="VB" debug="true"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Dim objConnection As New SqlConnection()
    Dim ObjCommand As SqlCommand
    Dim ObjDataAdapter As SqlDataAdapter
    Dim ObjDataSet As DataSet

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cuenta As Integer
        Dim objDataView As New DataView()
        objDataView.Table = ObjDataSet.Tables("personal")
        objDataView.RowFilter = "usuario='" & Me.txtusu.Text & "'" & _
        " and " & "clave='" & Me.txtcla.Text & "'" & " and " & "cod_cargo='" & Me.DropDownList1.Text & "'"
        If objDataView.Count > 0 Then
            Me.Dispose()
            Dim nombre As String
            Dim sqlccategoria As New SqlCommand("select cod_personal from personal where usuario='" & Me.txtusu.Text & "'", objConnection)
            Dim DAcategoria As New SqlDataAdapter(sqlccategoria)
            Dim DTcategoria As New DataTable
            DAcategoria.Fill(DTcategoria)
            nombre = DTcategoria.Rows(0).Item("cod_personal")
            Response.Redirect("Macros.aspx?=" + nombre.Trim, True)
            Me.Button1.PostBackUrl = "Perfil.aspx"
        Else
            cuenta = cuenta + 1
            If cuenta = 3 Then
                MsgBox("Sus intentos han excedido el limite permitido ...", MsgBoxStyle.Critical, "El Mirador de Santiago de Chuco")
            End If
            MsgBox("Verifique los Datos Ingresados", MsgBoxStyle.Critical, "El Mirador de Santiago de Chuco")
            Me.txtusu.Text = ""
            Me.txtcla.Text = ""
            txtusu.Focus()
        End If
             
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        objConnection.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"

        'objConnection.ConnectionString = "Data Source=.;Initial Catalog=biblioteca_municipal;Integrated Security=True"

        objConnection.Open()
        ObjDataAdapter = New SqlDataAdapter("select * from personal", objConnection)
        ObjDataSet = New DataSet()
        ObjDataAdapter.Fill(ObjDataSet, "personal")
        objConnection.Close()
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Página sin título</title>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            <table>
            <tr>
                <td colspan="2" style="height: 71px; width: 287px;">
                    <img src="Imagenes/login.jpg" /></td>
            </tr>
            <tr>
                <td colspan="2" rowspan="4" style="text-align: center; width: 287px;">
                    <table style="background-image: url(Imagenes/fondolp.png); width: 270px; height: 130px">
                        <tr>
                            <td style="width: 82px; text-align: right">
                            </td>
                            <td style="width: 179px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 82px; text-align: right">
                                Cargo:</td>
                            <td style="width: 179px; text-align: left;">
                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1"
                                    DataTextField="descripcion" DataValueField="cod_cargo" Width="146px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 82px; text-align: right">
                                Usuario:</td>
                            <td style="width: 179px; text-align: left;">
                                <asp:TextBox ID="txtusu" runat="server" Width="141px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtusu"
                                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 82px; text-align: right">
                                Contraseña:</td>
                            <td style="width: 179px; text-align: left;">
                                <asp:TextBox ID="txtcla" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtcla"
                                    ErrorMessage="*"></asp:RequiredFieldValidator></td>
                        </tr>
                        <tr>
                            <td style="width: 82px">
                            </td>
                            <td style="width: 179px">
                                <asp:Button ID="Button1" runat="server" Text="INGRESAR" OnClick="Button1_Click" /></td>
                        </tr>
                    </table>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BDhotelConnectionString4 %>"
                        SelectCommand="SELECT * FROM [cargo]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
            <tr>
            </tr>
        </table>
        </center>
    </form>
</body>
</html>

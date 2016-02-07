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
    
Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Dim cuenta As Integer
        Dim objDataView As New DataView()
        objDataView.Table = ObjDataSet.Tables("cliente")
        objDataView.RowFilter = "identificacion='" & Me.txtusu.Text & "'" & _
        " and " & "clave='" & Me.txtcla.Text & "'"
        If objDataView.Count > 0 Then
            Me.Dispose()
            Dim nombre As String
            Dim sqlccategoria As New SqlCommand("select identificacion from cliente where identificacion='" & Me.txtusu.Text & "'", objConnection)
            Dim DAcategoria As New SqlDataAdapter(sqlccategoria)
            Dim DTcategoria As New DataTable
            DAcategoria.Fill(DTcategoria)
            nombre = DTcategoria.Rows(0).Item("identificacion")
            Response.Redirect("Realizar_Reserva.aspx?" + nombre.Trim, True)
            Me.ImageButton1.PostBackUrl = "Realizar_Reserva.aspx"
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
        ObjDataAdapter = New SqlDataAdapter("select * from cliente", objConnection)
        ObjDataSet = New DataSet()
        ObjDataAdapter.Fill(ObjDataSet, "cliente")
        objConnection.Close()
    End Sub

    Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        Me.ImageButton2.PostBackUrl = "Registrar_Cliente.aspx"
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Logearse</title>
</head>

<body>
    <form id="form1" runat="server">
    <div style="text-align: center">
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
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            &nbsp;</center>
        <center>
            <table style="background-image: url(Imagenes/screen_portal_1.jpg)">
            <tr>
                <td style="width: 102px; height: 81px;">
                </td>
                <td style="width: 114px; height: 81px;">
                </td>
                <td style="width: 157px; height: 81px;">
                </td>
                <td style="height: 81px">
                </td>
            </tr>
            <tr>
                <td style="width: 102px; text-align: right">
                    </td>
                <td style="width: 114px; text-align: right">
                    <asp:TextBox ID="txtusu" runat="server" Width="127px"></asp:TextBox></td>
                <td colspan="2" rowspan="2" style="text-align: right">
                </td>
            </tr>
            <tr>
                <td style="width: 102px; height: 26px; text-align: right">
                    </td>
                <td style="width: 114px; height: 26px; text-align: right">
                    <asp:TextBox ID="txtcla" runat="server" TextMode="Password" Width="127px"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="height: 56px;" colspan="3">
                    &nbsp;<asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Imagenes/btnlogin.png" OnClick="ImageButton1_Click" />&nbsp;<asp:ImageButton
                        ID="ImageButton2" runat="server" ImageUrl="~/Imagenes/btnregistrarse.png" OnClick="ImageButton2_Click" /></td>
                <td colspan="1" style="height: 56px">
                </td>
            </tr>
            <tr>
                <td style="width: 102px; height: 20px">
                </td>
                <td style="width: 114px; height: 20px; text-align: right">
                </td>
                <td style="width: 157px; height: 20px">
                </td>
                <td style="height: 20px">
                </td>
            </tr>
        </table>
        </center>
    
    </div>
    </form>
</body>
</html>

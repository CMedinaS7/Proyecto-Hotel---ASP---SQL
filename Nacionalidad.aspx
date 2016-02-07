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
    Dim DataSet As DataSet
    Sub limpiar()
        Me.TextBox1.Text = ""
        Me.TextBox2.Text = ""
    End Sub
  

    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("insert into nacionalidad values ( '" + Me.TextBox1.Text + "','" + Me.TextBox2.Text + "')", cnn)
        Try
            cnn.Open()
            sqlinsertar.ExecuteNonQuery()
            cnn.Close()
            MsgBox("Registro Exitoso", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
            ObjDataAdapter = New SqlDataAdapter("select * from nacionalidad", cnn)
            DataSet = New DataSet
            cnn.Open()
            ObjDataAdapter.Fill(DataSet, "mostrar")
            GridView1.DataSource = DataSet.Tables("mostrar").DefaultView
            GridView1.DataBind()
            cnn.Close()
            Me.TextBox2.Enabled = False
        Catch ex As Exception
            MsgBox("Error al Registrar", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        End Try
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ObjDataAdapter = New SqlDataAdapter("select * from nacionalidad", cnn)
        DataSet = New DataSet
        cnn.Open()
        ObjDataAdapter.Fill(DataSet, "mostrar")
        GridView1.DataSource = DataSet.Tables("mostrar").DefaultView
        GridView1.DataBind()
        cnn.Close()
        Me.TextBox2.Enabled = False
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.Button1.Text = "ACTUALIZAR" Then
            Me.Button1.Text = "MODIFICAR"
            Dim sqlinsertar As SqlCommand
            sqlinsertar = New SqlCommand("exec modnacionalidad '" + Me.TextBox1.Text + "','" + Me.TextBox2.Text + "'", cnn)
            Try
                cnn.Open()
                sqlinsertar.ExecuteNonQuery()
                cnn.Close()
                MsgBox("Registro Modificado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
                cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
                ObjDataAdapter = New SqlDataAdapter("select * from nacionalidad", cnn)
                DataSet = New DataSet
                cnn.Open()
                ObjDataAdapter.Fill(DataSet, "mostrar")
                GridView1.DataSource = DataSet.Tables("mostrar").DefaultView
                GridView1.DataBind()
                cnn.Close()
            Catch
                MsgBox("Error al Modificar", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            End Try
        Else
            Me.Button1.Text = "ACTUALIZAR"
            Me.TextBox2.Enabled = True
        End If
        
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec eliminarnac '" + Me.TextBox1.Text + "'", cnn)
        cnn.Open()
        sqlinsertar.ExecuteNonQuery()
        cnn.Close()
        MsgBox("Registro Eliminado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ObjDataAdapter = New SqlDataAdapter("select * from nacionalidad", cnn)
        DataSet = New DataSet
        cnn.Open()
        ObjDataAdapter.Fill(DataSet, "mostrar")
        GridView1.DataSource = DataSet.Tables("mostrar").DefaultView
        GridView1.DataBind()
        cnn.Close()
        limpiar()
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        cnn.Open()
        'Dim c As String
        Dim CMD As New SqlCommand("buscarnac", cnn)
        With CMD
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add(New SqlParameter("@codigo", Trim(Me.TextBox1.Text)))
            Dim DA As New SqlDataAdapter(CMD)
            Dim DT As New DataTable
            DA.Fill(DT)
            If DT.Rows.Count() = 0 Then
                MsgBox("Habitacion no Encontrada", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Else
                Me.TextBox1.Text = DT.Rows(0).Item("cod_nacionalidad")
                Me.TextBox2.Text = DT.Rows(0).Item("nombre")
                
            End If
        End With
    End Sub

    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.TextBox2.Enabled = True
        limpiar()
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Página sin título</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <center><table style="background-image: url(Imagenes/fondo_pais.jpg); width: 689px; height: 174px">
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
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
                <td rowspan="4" style="width: 100px">
                    <asp:Button ID="Button5" runat="server" Text="NUEVO" Width="106px" OnClick="Button5_Click" /><asp:Button
                        ID="Button6" runat="server" Text="GUARDAR" Width="106px" OnClick="Button6_Click" /><asp:Button ID="Button1"
                            runat="server" Text="MODIFICAR" Width="106px" OnClick="Button1_Click" /><asp:Button ID="Button2" runat="server"
                                Text="ELIMINAR" Width="106px" OnClick="Button2_Click" /></td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right;">
                    <strong><span style="color: #006600; font-family: Calibri">Codigo:</span></strong></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox1" runat="server" Width="117px"></asp:TextBox>
                    <asp:ImageButton ID="ImageButton1" runat="server" Height="21px" ImageUrl="~/Imagenes/buscar.png"
                        OnClick="ImageButton1_Click" Width="22px" /></td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 100px; text-align: right">
                    <strong><span style="color: #006600; font-family: Calibri">Descripción:</span></strong></td>
                <td style="width: 100px">
                    <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox></td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
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
            </tr>
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
            </tr>
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
            </tr>
        </table></center>
        <center>
            &nbsp;</center>
    
    </div><center><table>
        <tr>
            <td colspan="6">
                &nbsp;&nbsp;<asp:GridView ID="GridView1" runat="server" BackColor="#FFFFC0" BorderColor="Red"
                    ForeColor="SteelBlue">
                </asp:GridView>
                &nbsp;
            </td>
        </tr>
    </table>
        </center>
    </form>
</body>
</html>

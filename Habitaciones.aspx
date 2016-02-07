<%@ import namespace="system.data.sqlclient"%>

<%@ import Namespace="system.IO"%>

<%@ import Namespace="system.data"%>

<%@ Page Language="VB" debug="true"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Dim cnn As New SqlConnection()
    Dim ObjCommand As SqlCommand
    Dim ObjDataAdapter As SqlDataAdapter
    Dim DataSet As DataSet


    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        cnn.Open()
        'Dim c As String
        Dim CMD As New SqlCommand("buscarhabitacion", cnn)
        With CMD
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add(New SqlParameter("@codhabitacion", Trim(Me.txtcod.Text)))
            Dim DA As New SqlDataAdapter(CMD)
            Dim DT As New DataTable
            DA.Fill(DT)
            If DT.Rows.Count() = 0 Then
                MsgBox("Habitacion no Encontrada", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Else
                Me.txtcod.Text = DT.Rows(0).Item("cod_habitacion")
                Me.CheckBox1.Checked = DT.Rows(0).Item("ocupada")
                Me.DropDownList1.Text = DT.Rows(0).Item("cod_tipo")
            End If
        End With
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim ds As DataSet
        Dim ds1 As DataSet
        Dim ad As SqlDataAdapter
        Dim ad1 As SqlDataAdapter
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ad = New SqlDataAdapter("select * from habitacion", cnn)
        ad1 = New SqlDataAdapter("select * from tipoH", cnn)
        ds = New DataSet
        ds1 = New DataSet
        cnn.Open()
        ad.Fill(ds, "mostrar")
        ad1.Fill(ds1, "mostrar1")
        GridView1.DataSource = ds.Tables("mostrar").DefaultView
        GridView1.DataBind()
        GridView2.DataSource = ds1.Tables("mostrar1").DefaultView
        GridView2.DataBind()
        cnn.Close()
        Me.txtdes.Enabled = False
        Me.CheckBox1.Enabled = False
        Me.DropDownList1.Enabled = False
        Me.txtpre.Enabled = False
    End Sub

    Protected Sub ImageButton2_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        cnn.Open()
        'Dim c As String
        Dim CMD As New SqlCommand("buscartipohabitacion", cnn)
        With CMD
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add(New SqlParameter("@codtipohabitacion", Trim(Me.txtcodt.Text)))
            Dim DA As New SqlDataAdapter(CMD)
            Dim DT As New DataTable
            DA.Fill(DT)
            If DT.Rows.Count() = 0 Then
                MsgBox("Tipo de Habitacion no Encontrada", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Else
                Me.txtcod.Text = DT.Rows(0).Item("cod_tipo")
                Me.txtdes.Text = DT.Rows(0).Item("descripcion")
                Me.txtpre.Text = DT.Rows(0).Item("precio")
            End If
        End With

    End Sub

    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim a As String
        If Me.CheckBox1.Checked = True Then
            a = "True"
        Else
            a = "False"
        End If
        
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec insertarhab '" + Me.txtcod.Text + "','" + a + "','" + Me.DropDownList1.Text + "'", cnn)
        Try
            cnn.Open()
            sqlinsertar.ExecuteNonQuery()
            cnn.Close()
            MsgBox("Registro Exitoso", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Dim ds As DataSet
            Dim ds1 As DataSet
            Dim ad As SqlDataAdapter
            Dim ad1 As SqlDataAdapter
            cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
            ad = New SqlDataAdapter("select * from habitacion", cnn)
            ad1 = New SqlDataAdapter("select * from tipoH", cnn)
            ds = New DataSet
            ds1 = New DataSet
            cnn.Open()
            ad.Fill(ds, "mostrar")
            ad1.Fill(ds1, "mostrar1")
            GridView1.DataSource = ds.Tables("mostrar").DefaultView
            GridView1.DataBind()
            GridView2.DataSource = ds1.Tables("mostrar1").DefaultView
            GridView2.DataBind()
            cnn.Close()
            Me.CheckBox1.Enabled = False
            Me.DropDownList1.Enabled = False
        Catch
            MsgBox("Error al Registrar", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        End Try
        
    End Sub

    Protected Sub Button4_Click1(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec insertarthab '" + Me.txtcodt.Text + "','" + Me.txtdes.Text + "','" + Me.txtpre.Text + "'", cnn)
        Try
            cnn.Open()
            sqlinsertar.ExecuteNonQuery()
            cnn.Close()
            MsgBox("Registro Exitoso", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Dim ds As DataSet
            Dim ds1 As DataSet
            Dim ad As SqlDataAdapter
            Dim ad1 As SqlDataAdapter
            cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
            ad = New SqlDataAdapter("select * from habitacion", cnn)
            ad1 = New SqlDataAdapter("select * from tipoH", cnn)
            ds = New DataSet
            ds1 = New DataSet
            cnn.Open()
            ad.Fill(ds, "mostrar")
            ad1.Fill(ds1, "mostrar1")
            GridView1.DataSource = ds.Tables("mostrar").DefaultView
            GridView1.DataBind()
            GridView2.DataSource = ds1.Tables("mostrar1").DefaultView
            GridView2.DataBind()
            cnn.Close()
            Me.txtdes.Enabled = False
            Me.txtpre.Enabled = False
        Catch
            MsgBox("Error al Registrar", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim a As String
        If Me.CheckBox1.Checked = True Then
            a = "True"
        Else
            a = "False"
        End If
        
        
        If Me.Button1.Text = "MODIFICAR" Then
            Me.CheckBox1.Enabled = True
            Me.DropDownList1.Enabled = True
            Me.Button1.Text = "ACTUALIZAR"
        Else
            Me.Button1.Text = "MODIFICAR"
            Dim sqlinsertar As SqlCommand
            Try
                sqlinsertar = New SqlCommand("exec modificarhab '" + Me.txtcod.Text + "','" + a + "','" + Me.DropDownList1.Text + "'", cnn)
                cnn.Open()
                sqlinsertar.ExecuteNonQuery()
                cnn.Close()
                MsgBox("Registro Modificado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
                Dim ds As DataSet
                Dim ds1 As DataSet
                Dim ad As SqlDataAdapter
                Dim ad1 As SqlDataAdapter
                cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
                ad = New SqlDataAdapter("select * from habitacion", cnn)
                ad1 = New SqlDataAdapter("select * from tipoH", cnn)
                ds = New DataSet
                ds1 = New DataSet
                cnn.Open()
                ad.Fill(ds, "mostrar")
                ad1.Fill(ds1, "mostrar1")
                GridView1.DataSource = ds.Tables("mostrar").DefaultView
                GridView1.DataBind()
                GridView2.DataSource = ds1.Tables("mostrar1").DefaultView
                GridView2.DataBind()
                cnn.Close()
                Me.CheckBox1.Enabled = False
                Me.DropDownList1.Enabled = False
            Catch
                MsgBox("Error al Modificar registro", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            End Try
            
        End If
        
    End Sub

    Protected Sub Button7_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.Button7.Text = "ACTUALIZAR" Then
            Me.Button7.Text = "MODIFICAR"
            Dim sqlinsertar As SqlCommand
            sqlinsertar = New SqlCommand("exec modificarthab '" + Me.txtcodt.Text + "','" + Me.txtdes.Text + "','" + Me.txtpre.Text + "'", cnn)
            Try
                cnn.Open()
                sqlinsertar.ExecuteNonQuery()
                cnn.Close()
                MsgBox("Registro Modificado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
                Dim ds As DataSet
                Dim ds1 As DataSet
                Dim ad As SqlDataAdapter
                Dim ad1 As SqlDataAdapter
                cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
                ad = New SqlDataAdapter("select * from habitacion", cnn)
                ad1 = New SqlDataAdapter("select * from tipoH", cnn)
                ds = New DataSet
                ds1 = New DataSet
                cnn.Open()
                ad.Fill(ds, "mostrar")
                ad1.Fill(ds1, "mostrar1")
                GridView1.DataSource = ds.Tables("mostrar").DefaultView
                GridView1.DataBind()
                GridView2.DataSource = ds1.Tables("mostrar1").DefaultView
                GridView2.DataBind()
                cnn.Close()
            Catch ex As Exception
                MsgBox("Error al Modificar Registro", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            End Try
            Me.txtdes.Enabled = False
            Me.txtpre.Enabled = False
        Else
            Me.Button7.Text = "ACTUALIZAR"
            Me.txtdes.Enabled = True
            Me.txtpre.Enabled = True
        End If
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec eliminarhab '" + Me.txtcod.Text + "'", cnn)
        Try
            cnn.Open()
            sqlinsertar.ExecuteNonQuery()
            cnn.Close()
            MsgBox("Registro Eliminado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Dim ds As DataSet
            Dim ds1 As DataSet
            Dim ad As SqlDataAdapter
            Dim ad1 As SqlDataAdapter
            cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
            ad = New SqlDataAdapter("select * from habitacion", cnn)
            ad1 = New SqlDataAdapter("select * from tipoH", cnn)
            ds = New DataSet
            ds1 = New DataSet
            cnn.Open()
            ad.Fill(ds, "mostrar")
            ad1.Fill(ds1, "mostrar1")
            GridView1.DataSource = ds.Tables("mostrar").DefaultView
            GridView1.DataBind()
            GridView2.DataSource = ds1.Tables("mostrar1").DefaultView
            GridView2.DataBind()
            cnn.Close()
            Me.txtcod.Text = ""
            Me.CheckBox1.Checked = False
            Me.CheckBox1.Enabled = False
            Me.DropDownList1.Enabled = False
        Catch
            MsgBox("Imposible Eliminar El Registro", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        End Try
    End Sub

    Protected Sub Button8_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec eliminarthab '" + Me.txtcodt.Text + "'", cnn)
        Try
            
            cnn.Open()
            sqlinsertar.ExecuteNonQuery()
            cnn.Close()
            MsgBox("Registro Eliminado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Dim ds As DataSet
            Dim ds1 As DataSet
            Dim ad As SqlDataAdapter
            Dim ad1 As SqlDataAdapter
            cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
            ad = New SqlDataAdapter("select * from habitacion", cnn)
            ad1 = New SqlDataAdapter("select * from tipoH", cnn)
            ds = New DataSet
            ds1 = New DataSet
            cnn.Open()
            ad.Fill(ds, "mostrar")
            ad1.Fill(ds1, "mostrar1")
            GridView1.DataSource = ds.Tables("mostrar").DefaultView
            GridView1.DataBind()
            GridView2.DataSource = ds1.Tables("mostrar1").DefaultView
            GridView2.DataBind()
            cnn.Close()
            Me.txtcodt.Text = ""
            Me.txtdes.Text = ""
            Me.txtpre.Text = ""
        Catch
            MsgBox("Error al Eliminar Registro", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        End Try
    End Sub

    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.CheckBox1.Enabled = True
        Me.DropDownList1.Enabled = True
    End Sub

    Protected Sub Button3_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Me.txtdes.Enabled = True
        Me.txtpre.Enabled = True
        Me.txtdes.Text = ""
        Me.txtpre.Text = ""
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Página sin título</title>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div style="text-align: center">
        <center>
            <table style="background-image: url(Imagenes/fondo_habitacion.jpg); width: 806px; height: 313px">
                <tr>
                    <td style="width: 100px; height: 76px">
                    </td>
                    <td style="width: 131px; height: 76px; text-align: right">
                        <br />
                        <table>
                            <tr>
                                <td rowspan="2" style="width: 100px; text-align: right">
                                    <strong><span style="color: #006600; font-family: Calibri">Codigo:</span></strong></td>
                                <td rowspan="2" style="width: 100px; text-align: left">
                                    &nbsp;<asp:TextBox ID="txtcod" runat="server" Width="115px"></asp:TextBox>
                                    <asp:ImageButton ID="ImageButton1" runat="server" Height="21px" ImageUrl="~/Imagenes/buscar.png"
                                        OnClick="ImageButton1_Click" Width="22px" /></td>
                                <td style="width: 100px">
                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 100px; text-align: left">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px; text-align: right">
                                    <strong><span style="color: #006600; font-family: Calibri">Ocupada:</span></strong></td>
                                <td style="width: 100px; text-align: left">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Text="Si" /></td>
                                <td style="width: 100px; text-align: left">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px; text-align: right">
                                    <strong><span style="color: #006600; font-family: Calibri">Tipo:</span></strong></td>
                                <td style="width: 100px">
                                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1"
                                        DataTextField="descripcion" DataValueField="cod_tipo" Width="153px">
                                    </asp:DropDownList>
                                </td>
                                <td style="width: 100px">
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 24px; height: 76px">
                    </td>
                    <td style="width: 44px; height: 76px">
                    </td>
                    <td style="width: 100px; height: 76px">
                        <br />
                        <table>
                            <tr>
                                <td rowspan="2" style="width: 100px; text-align: right">
                                    <strong><span style="color: #006600; font-family: Calibri">Codigo:</span></strong></td>
                                <td rowspan="2" style="width: 100px; text-align: left">
                                    <asp:TextBox ID="txtcodt" runat="server" Width="121px"></asp:TextBox>
                                    <asp:ImageButton ID="ImageButton2" runat="server" Height="21px" ImageUrl="~/Imagenes/buscar.png"
                                        Width="22px" OnClick="ImageButton2_Click" /></td>
                                <td style="width: 100px">
                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 100px">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 100px; text-align: right">
                                    <strong><span style="color: #006600; font-family: Calibri">Descripcion:</span></strong></td>
                                <td style="width: 100px; text-align: left">
                                    <asp:TextBox ID="txtdes" runat="server"></asp:TextBox></td>
                                <td style="width: 100px; text-align: left">
                                    </td>
                            </tr>
                            <tr>
                                <td style="width: 100px; text-align: right">
                                    <strong><span style="color: #006600; font-family: Calibri">Precio:</span></strong></td>
                                <td style="width: 100px">
                                    <asp:TextBox ID="txtpre" runat="server"></asp:TextBox></td>
                                <td style="width: 100px">
                                    </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 100px; height: 76px">
                    </td>
                </tr>
                <tr>
                    <td style="width: 100px; height: 26px;">
                    </td>
                    <td style="width: 131px; text-align: center; height: 26px;">
                        <asp:Button ID="Button5" runat="server" Text="NUEVO" Width="106px" OnClick="Button5_Click" /><br />
                        <asp:Button ID="Button6" runat="server" Text="GUARDAR" Width="106px" OnClick="Button6_Click" /><br />
                        <asp:Button ID="Button1" runat="server" Text="MODIFICAR" Width="106px" OnClick="Button1_Click" /><br />
                        <asp:Button ID="Button2" runat="server" Text="ELIMINAR" Width="106px" OnClick="Button2_Click" /></td>
                    <td style="width: 24px; text-align: left; height: 26px;">
                    </td>
                    <td style="width: 44px; height: 26px;">
                    </td>
                    <td style="width: 100px; text-align: center; height: 26px;">
                        <asp:Button ID="Button3" runat="server" Text="NUEVO" Width="106px" OnClick="Button3_Click" /><br />
                        <asp:Button ID="Button4" runat="server" Text="GUARDAR" Width="106px" OnClick="Button4_Click1" /><br />
                        <asp:Button ID="Button7" runat="server" Text="MODIFICAR" Width="106px" OnClick="Button7_Click" /><br />
                        <asp:Button ID="Button8" runat="server" Text="ELIMINAR" Width="106px" OnClick="Button8_Click" /></td>
                    <td style="width: 100px; height: 26px;">
                    </td>
                </tr>
            </table>
        </center>
    
    </div><center><table style="width: 806px; height: 306px">
        <tr>
            <td style="width: 100px; height: 195px;">
            </td>
            <td style="width: 131px; text-align: center; height: 195px;">
                &nbsp;&nbsp;
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BDhotelConnectionString14 %>"
                            SelectCommand="SELECT * FROM [tipoH]"></asp:SqlDataSource>
                &nbsp;<asp:GridView ID="GridView1" runat="server" BackColor="#FFFFC0" BorderColor="Red"
                    ForeColor="SteelBlue">
                </asp:GridView>
                    </td>
                    <td style="width: 24px; height: 195px;">
                    </td>
                    <td style="width: 44px; height: 195px;">
                    </td>
                    <td style="width: 100px; text-align: center; height: 195px;">
                        &nbsp;&nbsp;&nbsp;<asp:GridView ID="GridView2" runat="server" BackColor="#FFFFC0"
                            BorderColor="Red" ForeColor="SteelBlue">
                        </asp:GridView>
                    </td>
                    <td style="width: 100px; height: 195px;">
                    </td>
        </tr>
    </table></center>
    </form>
</body>
</html>

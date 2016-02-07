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
    Dim dataset As DataSet

        Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        cnn.Open()
        Dim CMD As New SqlCommand("buscar_reserva", cnn)
        With CMD
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add(New SqlParameter("@cod", Trim(Me.TextBox1.Text)))
            Dim DA As New SqlDataAdapter(CMD)
            Dim DT As New DataTable
            DA.Fill(DT)
            If DT.Rows.Count() = 0 Then
                MsgBox("Reserva no Encontrada", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Else
                Me.TextBox1.Text = DT.Rows(0).Item("cod_reserva")
                Me.txtid.Text = DT.Rows(0).Item("identificacion")
                Me.txtfl.Text = DT.Rows(0).Item("fecha_llegada")
                Me.txtfs.Text = DT.Rows(0).Item("fecha_salida")
                Me.txtp.Text = DT.Rows(0).Item("personas")
                Me.txthab.Text = DT.Rows(0).Item("cod_habitacion")
                Me.DropDownList1.Text = DT.Rows(0).Item("cod_personal")
            End If
        End With
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ObjDataAdapter = New SqlDataAdapter("select * from reserva", cnn)
        dataset = New DataSet
        cnn.Open()
        ObjDataAdapter.Fill(dataset, "mostrar")
        GridView1.DataSource = dataset.Tables("mostrar").DefaultView
        GridView1.DataBind()
        cnn.Close()
        proteger()
    End Sub

    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cmd As New SqlCommand("select max(cod_reserva)from reserva", cnn)
        Dim codh As String
        Dim hab As New SqlCommand("select cod_habitacion from habitacion where cod_tipo='" + Me.DropDownList1.Text + "'", cnn)
        Dim strCodigo As String
        Dim sqlinsertar As SqlCommand
        Try
            cnn.Open()
            strCodigo = cmd.ExecuteScalar
            codh = hab.ExecuteScalar
            Me.TextBox1.Text = Format(Val(strCodigo) + 1)
            sqlinsertar = New SqlCommand("exec registrar_reserva '" + Me.TextBox1.Text + "','" + Me.txtid.Text + "','" + Me.txtfl.Text + "','" + Me.txtfs.Text + "','" + Me.txtp.Text + "','" + Me.txthab.Text + "','" + Me.DropDownList1.Text + "'", cnn)
            sqlinsertar.ExecuteNonQuery()
            MsgBox("Reserva Registrada", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            cnn.Close()
            cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
            ObjDataAdapter = New SqlDataAdapter("select * from reserva", cnn)
            dataset = New DataSet
            cnn.Open()
            ObjDataAdapter.Fill(dataset, "mostrar")
            GridView1.DataSource = dataset.Tables("mostrar").DefaultView
            GridView1.DataBind()
            cnn.Close()
            proteger()
        Catch
            MsgBox("Error de Reserva", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.Button1.Text = "ACTUALIZAR" Then
            Me.Button1.Text = "MODIFICAR"
            Dim sqlinsertar As SqlCommand
            sqlinsertar = New SqlCommand("exec modreserva '" + Me.TextBox1.Text + "','" + Me.txtid.Text + "','" + Me.txtfl.Text + "','" + Me.txtfs.Text + "','" + Me.txtp.Text + "','" + Me.txthab.Text + "','" + Me.DropDownList1.Text + "'", cnn)
            cnn.Open()
            sqlinsertar.ExecuteNonQuery()
            cnn.Close()
            MsgBox("Registro Modificado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
            ObjDataAdapter = New SqlDataAdapter("select * from reserva", cnn)
            dataset = New DataSet
            cnn.Open()
            ObjDataAdapter.Fill(dataset, "mostrar")
            GridView1.DataSource = dataset.Tables("mostrar").DefaultView
            GridView1.DataBind()
            cnn.Close()
            proteger()
        Else
            Me.Button1.Text = "ACTUALIZAR"
            habilitar()
        End If
        
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec eliminar_reserva '" + Me.TextBox1.Text + "'", cnn)
        cnn.Open()
        sqlinsertar.ExecuteNonQuery()
        cnn.Close()
        MsgBox("Registro Eliminado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ObjDataAdapter = New SqlDataAdapter("select * from reserva", cnn)
        dataset = New DataSet
        cnn.Open()
        ObjDataAdapter.Fill(dataset, "mostrar")
        GridView1.DataSource = dataset.Tables("mostrar").DefaultView
        GridView1.DataBind()
        cnn.Close()
        limpiar()
    End Sub

    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ObjDataAdapter = New SqlDataAdapter("select * from reserva", cnn)
        DataSet = New DataSet
        cnn.Open()
        ObjDataAdapter.Fill(DataSet, "mostrar")
        GridView1.DataSource = DataSet.Tables("mostrar").DefaultView
        GridView1.DataBind()
        cnn.Close()
        limpiar()
        habilitar()
    End Sub
    Sub limpiar()
        Me.txtfl.Text = ""
        Me.txtfs.Text = ""
        Me.txthab.Text = ""
        Me.txtid.Text = ""
        Me.txtp.Text = ""
    End Sub
    Sub proteger()
        Me.txtfl.Enabled = False
        Me.txtfs.Enabled = False
        Me.txthab.Enabled = False
        Me.txtid.Enabled = False
        Me.txtp.Enabled = False
        Me.DropDownList1.Enabled = False
    End Sub
    Sub habilitar()
        Me.txtfl.Enabled = True
        Me.txtfs.Enabled = True
        Me.txthab.Enabled = True
        Me.txtid.Enabled = True
        Me.txtp.Enabled = True
        Me.DropDownList1.Enabled = True
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Página sin título</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
       <center> <table style="background-image: url(Imagenes/fondo_reserva.jpg); width: 614px; height: 423px">
            <tr>
                <td style="width: 100px">
                </td>
                <td>
                </td>
                <td style="width: 183px">
                    &nbsp;</td>
                <td style="width: 82px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right"><strong><span style="color: #006600; font-family: Calibri">Codigo:</span></strong></td>
                <td style="width: 183px; text-align: left;">
                    <asp:TextBox ID="TextBox1" runat="server" Width="110px"></asp:TextBox>
                    <asp:ImageButton ID="ImageButton1" runat="server" Height="21px" ImageUrl="~/Imagenes/buscar.png"
                        OnClick="ImageButton1_Click" Width="22px" /></td>
                <td style="width: 82px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600; font-family: Calibri"><strong>Identificaci</strong><span
                        style="color: #000000; font-family: Times New Roman">ó</span><strong>n:</strong></span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtid" runat="server"></asp:TextBox>
                    </td>
                <td rowspan="4" style="font-weight: bold; width: 82px; color: #006600; font-family: Calibri">
                </td>
                <td rowspan="4" style="font-weight: bold; width: 100px; color: #006600; font-family: Calibri">
                    <asp:Button
                        ID="Button5" runat="server" Text="NUEVO" Width="106px" OnClick="Button5_Click" /><asp:Button ID="Button6"
                            runat="server" Text="GUARDAR" Width="106px" OnClick="Button6_Click" /><asp:Button ID="Button1" runat="server"
                                Text="MODIFICAR" Width="106px" OnClick="Button1_Click" /><asp:Button ID="Button2" runat="server" Text="ELIMINAR"
                                    Width="106px" OnClick="Button2_Click" /></td>
            </tr>
            <tr style="font-weight: bold; color: #006600; font-family: Calibri">
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600">Fecha_Llegada:</span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtfl" runat="server"></asp:TextBox><span style="color: #006600">
                    </span>
                    </td>
            </tr>
            <tr style="font-weight: bold; color: #000000; font-family: Calibri">
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600">Fecha_Salida:</span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtfs" runat="server"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <strong><span style="color: #006600; font-family: Calibri">Nº Personas:</span></strong></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtp" runat="server"></asp:TextBox>
                    </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600; font-family: Calibri"><strong>Habitacion:</strong></span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txthab" runat="server"></asp:TextBox></td>
                <td style="width: 82px; text-align: left">
                </td>
                <td style="width: 183px; text-align: left">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600; font-family: Calibri"><strong>Personal:</strong></span></td>
                <td style="width: 183px; text-align: left">
                    &nbsp;<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2"
                        DataTextField="nombres" DataValueField="cod_personal" Width="147px">
                    </asp:DropDownList>&nbsp;&nbsp;
                </td>
                <td style="width: 82px; text-align: left">
                </td>
                <td style="width: 183px; text-align: left">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                </td>
                <td style="width: 183px; text-align: left">
                </td>
                <td style="width: 82px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
        </table></center>
        <center>
            <table style="width: 609px">
                <tr>
                    <td style="width: 100px">
                        &nbsp;&nbsp;&nbsp;<asp:GridView ID="GridView1" runat="server" BackColor="#FFFFC0"
                            BorderColor="Red" ForeColor="SteelBlue">
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:BDhotelConnectionString26 %>"
                            SelectCommand="SELECT * FROM [personal]"></asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </center>
        <center>
            &nbsp;</center>
    
    </div>
    </form>
</body>
</html>

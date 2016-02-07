﻿<%@ Page Language="VB" Debug="true" %>
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
    
    Sub limpiar()
        Me.TextBox1.Text = ""
        Me.txtape.Text = ""
        Me.txtclave.Text = ""
        Me.txtemail.Text = ""
        Me.txtfoto.Text = ""
        Me.txtid.Text = ""
        Me.txtnom.Text = ""
        Me.txttel.Text = ""
    End Sub
    
    Sub proteger()
        Me.txtape.Enabled = False
        Me.txtclave.Enabled = False
        Me.txtemail.Enabled = False
        Me.txtfoto.Enabled = False
        Me.txtid.Enabled = False
        Me.txtnom.Enabled = False
        Me.txttel.Enabled = False
        Me.DropDownList1.Enabled = False
        Me.DropDownList2.Enabled = False
    End Sub
    
    Sub habilitar()
        Me.txtape.Enabled = True
        Me.txtclave.Enabled = True
        Me.txtemail.Enabled = True
        Me.txtfoto.Enabled = True
        Me.txtid.Enabled = True
        Me.txtnom.Enabled = True
        Me.txttel.Enabled = True
        Me.DropDownList1.Enabled = True
        Me.DropDownList2.Enabled = True
    End Sub
    
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ObjDataAdapter = New SqlDataAdapter("select * from personal", cnn)
        DataSet = New DataSet
        cnn.Open()
        ObjDataAdapter.Fill(DataSet, "mostrar")
        GridView1.DataSource = DataSet.Tables("mostrar").DefaultView
        GridView1.DataBind()
        cnn.Close()
        proteger()
    End Sub

    Protected Sub Button6_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec insertarpersonal '" + Me.TextBox1.Text + "','" + Me.txtid.Text + "','" + Me.txtclave.Text + "','" + Me.txtnom.Text + "','" + Me.txtape.Text + "','" + Me.txttel.Text + "','" + Me.DropDownList1.Text + "','" + Me.txtemail.Text + "','" + Me.txtfoto.Text + "','" + Me.DropDownList2.Text + "'", cnn)
        Try
            cnn.Open()
            sqlinsertar.ExecuteNonQuery()
            cnn.Close()
            MsgBox("Registro Exitoso", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
            ObjDataAdapter = New SqlDataAdapter("select * from personal", cnn)
            dataset = New DataSet
            cnn.Open()
            ObjDataAdapter.Fill(dataset, "mostrar")
            GridView1.DataSource = dataset.Tables("mostrar").DefaultView
            GridView1.DataBind()
            cnn.Close()
            proteger()
        Catch
            MsgBox("Error al Registrar", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        End Try
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If Me.Button1.Text = "ACTUALIZAR" Then
            Me.Button1.Text = "MODIFICAR"
            Dim sqlinsertar As SqlCommand
            sqlinsertar = New SqlCommand("exec modpersonal '" + Me.TextBox1.Text + "','" + Me.txtid.Text + "','" + Me.txtclave.Text + "','" + Me.txtnom.Text + "','" + Me.txtape.Text + "','" + Me.txttel.Text + "','" + Me.DropDownList1.Text + "','" + Me.txtemail.Text + "','" + Me.txtfoto.Text + "','" + Me.DropDownList2.Text + "'", cnn)
            Try
                cnn.Open()
                sqlinsertar.ExecuteNonQuery()
                cnn.Close()
                MsgBox("Registro Modificado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
                cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
                ObjDataAdapter = New SqlDataAdapter("select * from personal", cnn)
                dataset = New DataSet
                cnn.Open()
                ObjDataAdapter.Fill(dataset, "mostrar")
                GridView1.DataSource = dataset.Tables("mostrar").DefaultView
                GridView1.DataBind()
                cnn.Close()
            Catch
                MsgBox("Error al Modificar Registro", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            End Try
        Else
            Me.Button1.Text = "ACTUALIZAR"
            habilitar()
        End If
        
    End Sub

    Protected Sub Button2_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim sqlinsertar As SqlCommand
        sqlinsertar = New SqlCommand("exec borrarpersonal '" + Me.TextBox1.Text + "'", cnn)
        cnn.Open()
        sqlinsertar.ExecuteNonQuery()
        cnn.Close()
        MsgBox("Registro Eliminado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ObjDataAdapter = New SqlDataAdapter("select * from personal", cnn)
        dataset = New DataSet
        cnn.Open()
        ObjDataAdapter.Fill(dataset, "mostrar")
        GridView1.DataSource = dataset.Tables("mostrar").DefaultView
        GridView1.DataBind()
        cnn.Close()
        limpiar()
  
    End Sub

    Protected Sub ImageButton1_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs)
        
        cnn.Open()
        'Dim c As String
        Dim CMD As New SqlCommand("buscapersonal", cnn)
        With CMD
            .CommandType = CommandType.StoredProcedure
            .Parameters.Add(New SqlParameter("@codigo", Trim(Me.TextBox1.Text)))
            Dim DA As New SqlDataAdapter(CMD)
            Dim DT As New DataTable
            DA.Fill(DT)
            If DT.Rows.Count() = 0 Then
                MsgBox("Personal no Encontrado", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
            Else
                Me.TextBox1.Text = DT.Rows(0).Item("cod_personal")
                Me.txtid.Text = DT.Rows(0).Item("usuario")
                Me.txtclave.Text = DT.Rows(0).Item("clave")
                Me.txtnom.Text = DT.Rows(0).Item("nombres")
                Me.txtape.Text = DT.Rows(0).Item("apellidos")
                Me.txttel.Text = DT.Rows(0).Item("telefono")
                Me.DropDownList1.DataTextField = DT.Rows(0).Item("sexo")
                Me.txtemail.Text = DT.Rows(0).Item("e_mail")
                Me.txtfoto.Text = DT.Rows(0).Item("foto")
                Me.DropDownList2.Text = DT.Rows(0).Item("cod_cargo")
            End If
        End With
    End Sub

    Protected Sub Button5_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        ObjDataAdapter = New SqlDataAdapter("select * from personal", cnn)
        dataset = New DataSet
        cnn.Open()
        ObjDataAdapter.Fill(dataset, "mostrar")
        GridView1.DataSource = dataset.Tables("mostrar").DefaultView
        GridView1.DataBind()
        cnn.Close()
        limpiar()
        habilitar()
        
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Página sin título</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <center><table style="background-image: url(Imagenes/fondo_personal.jpg); width: 614px; height: 423px">
            <tr>
                <td style="width: 100px">
                </td>
                <td>
                </td>
                <td style="width: 183px">
                    &nbsp;</td>
                <td style="width: 57px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <strong><span style="color: #006600; font-family: Calibri">Codigo:</span></strong></td>
                <td style="width: 183px; text-align: left;">
                    <asp:TextBox ID="TextBox1" runat="server" Width="110px"></asp:TextBox>
                    <asp:ImageButton ID="ImageButton1" runat="server" Height="21px" ImageUrl="~/Imagenes/buscar.png"
                        OnClick="ImageButton1_Click" Width="22px" /></td>
                <td style="width: 57px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600; font-family: Calibri"><strong>Usuario:</strong></span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtid" runat="server"></asp:TextBox>
                    </td>
                <td style="width: 57px; text-align: left">
                </td>
                <td rowspan="4" style="font-weight: bold; width: 100px; color: #006600; font-family: Calibri">
                    <asp:Image ID="Image1" runat="server" Height="80px" ImageUrl="~/Imagenes/user.jpg"
                        Width="90px" /><br />
                    <asp:TextBox ID="txtfoto" runat="server" Width="101px"></asp:TextBox></td>
                <td rowspan="4" style="font-weight: bold; width: 100px; color: #006600; font-family: Calibri">
                </td>
            </tr>
            <tr style="font-weight: bold; color: #006600; font-family: Calibri">
                <td style="width: 100px">
                </td>
                <td>
                    <span></span>
                </td>
                <td style="width: 183px; text-align: left">
                </td>
                <td style="width: 57px; text-align: left">
                </td>
            </tr>
            <tr style="font-weight: bold; color: #006600; font-family: Calibri">
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600">Clave:</span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtclave" runat="server"></asp:TextBox><span style="color: #006600">
                    </span>
                    </td>
                <td style="width: 57px; text-align: left">
                </td>
            </tr>
            <tr style="font-weight: bold; color: #000000; font-family: Calibri">
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600">Nombres:</span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtnom" runat="server"></asp:TextBox>
                    </td>
                <td style="width: 57px; text-align: left">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <strong><span style="color: #006600; font-family: Calibri">Apellidos:</span></strong></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtape" runat="server"></asp:TextBox>
                    </td>
                <td style="width: 57px; text-align: left">
                </td>
                <td rowspan="6" style="width: 100px">
                    <asp:Button
                        ID="Button5" runat="server" Text="NUEVO" Width="106px" OnClick="Button5_Click" /><asp:Button ID="Button6"
                            runat="server" Text="GUARDAR" Width="106px" OnClick="Button6_Click" /><asp:Button ID="Button1" runat="server"
                                Text="MODIFICAR" Width="106px" OnClick="Button1_Click" /><asp:Button ID="Button2" runat="server" Text="ELIMINAR"
                                    Width="106px" OnClick="Button2_Click" /></td>
                <td rowspan="4" style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600; font-family: Calibri"><strong>Telefono:</strong></span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txttel" runat="server"></asp:TextBox>
                    </td>
                <td style="width: 57px; text-align: left">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600; font-family: Calibri"><strong>Sexo:</strong></span></td>
                <td style="width: 183px; text-align: left">
                    <asp:DropDownList ID="DropDownList1" runat="server" Width="152px">
                        <asp:ListItem>Masculino</asp:ListItem>
                        <asp:ListItem>Femenino</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="width: 57px; text-align: left">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <span style="color: #006600; font-family: Calibri"><strong>E-Mail:</strong></span></td>
                <td style="width: 183px; text-align: left">
                    <asp:TextBox ID="txtemail" runat="server"></asp:TextBox></td>
                <td style="width: 57px; text-align: left">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                    <strong><span style="color: #006600; font-family: Calibri">Cargo:</span></strong></td>
                <td style="width: 183px; text-align: left">
                    <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="descripcion" DataValueField="cod_cargo" Width="157px">
                    </asp:DropDownList>&nbsp;
                </td>
                <td style="width: 57px; text-align: left">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="text-align: right">
                </td>
                <td style="width: 183px; text-align: left">
                </td>
                <td style="width: 57px; text-align: left">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td colspan="7" style="height: 26px">
                    &nbsp;</td>
            </tr>
        </table></center>
        <center>
            <table>
                <tr>
                    <td style="width: 100px">
                        &nbsp;<asp:GridView ID="GridView1" runat="server" BackColor="#FFFFC0" BorderColor="Red"
                            ForeColor="SteelBlue">
                        </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BDhotelConnectionString18 %>"
                        SelectCommand="SELECT * FROM [cargo]"></asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </center>
    
    </div>
    </form>
</body>
</html>

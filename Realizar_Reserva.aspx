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
    Protected Sub DropDownList1_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim i As Integer
        i = Me.DropDownList1.SelectedIndex
        Select Case i
            Case 0
                Me.Image1.ImageUrl = "Imagenes/individual.jpg"
                Page_Load(sender, e)
            Case 1
                Me.Image1.ImageUrl = "Imagenes/matrimonial.jpg"
                Page_Load(sender, e)
            Case 2
                Me.Image1.ImageUrl = "Imagenes/doble.jpg"
                Page_Load(sender, e)
            Case 3
                Me.Image1.ImageUrl = "Imagenes/triple.jpg"
                Page_Load(sender, e)
        End Select
    End Sub

    Protected Sub Button1_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Dim cmd As New SqlCommand("select max(cod_reserva)from reserva", cnn)
        Dim codh As String
        Dim hab As New SqlCommand("select cod_habitacion from habitacion where cod_tipo='" + Me.DropDownList1.Text + "'", cnn)
        Dim strCodigo As String
        Dim sqlinsertar As SqlCommand
        cnn.Open()
        strCodigo = cmd.ExecuteScalar
        codh = hab.ExecuteScalar
        txtcod.Text = Format(Val(strCodigo) + 1)
        sqlinsertar = New SqlCommand("exec registrar_reserva '" + Me.txtcod.Text + "','" + Me.txtid.Text + "','" + Me.Calendar1.SelectedDate + "','" + Me.Calendar2.SelectedDate + "','" + Me.txtnp.Text + "','" + codh + "','p-02'", cnn)
        sqlinsertar.ExecuteNonQuery()
        MsgBox("Reserva Registrada", MsgBoxStyle.Information, "El Mirador de Santiago de Chuco")
        Page_Load(sender, e)
        cnn.Close()
        
            
        
        
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        cnn.ConnectionString = "Server=.;Initial Catalog=BDhotel;Integrated Security=True"
        Me.txtid.Text = Request.QueryString().ToString()
        
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Página sin título</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <center><table style="width: 624px; height: 619px">
            <tr>
                <td colspan="7" rowspan="2">
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:BDhotelConnectionString3 %>"
                        SelectCommand="SELECT * FROM [tipoH]"></asp:SqlDataSource>
                </td>
            </tr>
            <tr>
            </tr>
            <tr>
                <td style="width: 15px; height: 26px">
                </td>
                <td colspan="2" style="height: 26px; text-align: right">
                </td>
                <td colspan="2" style="height: 26px">
                </td>
                <td style="width: 100px; height: 26px">
                </td>
                <td style="height: 26px">
                </td>
            </tr>
            <tr>
                <td style="width: 15px; height: 26px;">
                </td>
                <td style="text-align: right; height: 26px;" colspan="2">
                    Identificación:</td>
                <td colspan="2" style="height: 26px">
                    <asp:TextBox ID="txtid" runat="server" Enabled="False"></asp:TextBox></td>
                <td style="width: 100px; height: 26px;">
                    <asp:TextBox ID="txtcod" runat="server" Width="140px" Visible="False"></asp:TextBox></td>
                <td style="height: 26px;">
                </td>
            </tr>
            <tr>
                <td style="width: 15px">
                </td>
                <td style="width: 130px">
                </td>
                <td style="width: 128px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 117px">
                </td>
                <td style="width: 100px">
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 15px; height: 24px">
                </td>
                <td style="width: 130px; height: 24px">
                </td>
                <td style="width: 128px; height: 24px; text-align: right;">
                    Tipo de Habitación:</td>
                <td style="width: 100px; height: 24px">
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1"
                        DataTextField="descripcion" DataValueField="cod_tipo" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
                <td style="width: 117px; height: 24px">
                    Nº de Personas:</td>
                <td style="width: 100px; height: 24px; text-align: left;">
                    <asp:TextBox ID="txtnp" runat="server" Width="103px"></asp:TextBox></td>
                <td style="height: 24px">
                </td>
            </tr>
            <tr>
                <td style="width: 15px">
                    </td>
                <td style="width: 130px">
                </td>
                <td style="width: 128px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 117px">
                </td>
                <td style="width: 100px">
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 15px">
                </td>
                <td colspan="5" style="text-align: center">
                    <asp:Image ID="Image1" runat="server" Height="140px" Width="670px" ImageUrl="~/Imagenes/tipo.png" /></td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 15px">
                </td>
                <td style="width: 130px">
                </td>
                <td style="width: 128px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 117px">
                </td>
                <td style="width: 100px">
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 15px">
                </td>
                <td colspan="3">
                    Fecha Entrada:</td>
                <td colspan="2">
                    Fecha Salida:</td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 15px">
                </td>
                <td colspan="3">
                    <center><asp:Calendar ID="Calendar1" runat="server" BackColor="#FFFFCC" BorderColor="#FFCC66"
                        BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="#663399" Height="200px" ShowGridLines="True" Width="220px">
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                    </asp:Calendar></center>
                </td>
                <td colspan="2" style="text-align: center">
                    <center><asp:Calendar ID="Calendar2" runat="server" BackColor="#FFFFCC" BorderColor="#FFCC66"
                        BorderWidth="1px" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="#663399" Height="200px" ShowGridLines="True" Width="220px">
                        <SelectedDayStyle BackColor="#CCCCFF" Font-Bold="True" />
                        <SelectorStyle BackColor="#FFCC66" />
                        <TodayDayStyle BackColor="#FFCC66" ForeColor="White" />
                        <OtherMonthDayStyle ForeColor="#CC9966" />
                        <NextPrevStyle Font-Size="9pt" ForeColor="#FFFFCC" />
                        <DayHeaderStyle BackColor="#FFCC66" Font-Bold="True" Height="1px" />
                        <TitleStyle BackColor="#990000" Font-Bold="True" Font-Size="9pt" ForeColor="#FFFFCC" />
                    </asp:Calendar></center>
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 15px">
                </td>
                <td style="width: 130px">
                </td>
                <td style="width: 128px">
                </td>
                <td style="width: 100px">
                </td>
                <td style="width: 117px">
                </td>
                <td style="width: 100px">
                </td>
                <td>
                </td>
            </tr>
            <tr>
                <td style="width: 15px">
                </td>
                <td style="width: 130px">
                </td>
                <td style="width: 128px">
                </td>
                <td colspan="2">
                    <asp:Button ID="Button1" runat="server" Text="RESERVAR" OnClick="Button1_Click" /></td>
                <td style="width: 100px">
                </td>
                <td>
                </td>
            </tr>
        </table></center>
    
    </div>
    </form>
</body>
</html>

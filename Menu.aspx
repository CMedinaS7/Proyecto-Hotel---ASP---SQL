<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Menu.aspx.vb" Inherits="Menu" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Cabecera</title>
    <script type="text/javascript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<body onload="MM_preloadImages('Imagenes/salir.png')">
<table align="center" border="0" cellpadding="0" cellspacing="0" class="container1">
        <tbody>
            <tr>
                <td colspan="8" style="height: 37px">
                    <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0"
                        style="width: 784px; height: 224px">
                        <param name="movie" value="Flash/animacion_1.swf">
                        <param name="quality" value="high">
                        <embed height="221" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash"
                            quality="high" src="Flash/animacion_1.swf" type="application/x-shockwave-flash"
                            width="870"></embed>
                    </object>
                </td>
            </tr>
            <tr>
                <td style="height: 37px">
                    <a href="Inicio.aspx" target="Frm_MAIN"><img src="Imagenes/btn_inicio.png" border="0" /></a></td>
                <td style="width: 97px; height: 37px">
                    <a href="Perfil.aspx" target="Frm_MAIN"><img src="Imagenes/btn_empresa.png" border="0" /></a></td>
                <td style="height: 37px">
                    <a href="Clientes.aspx" target="Frm_MAIN"><img src="Imagenes/btn_reservas.png" border="0" /></a></td>
<td style="width: 97px; height: 37px">
                    <a href="Habitaciones.aspx" target="Frm_MAIN"><img src="Imagenes/btn_ofertas.png" border="0" /></a></td>
                <td style="height: 37px">
                    <a href="Reservas.aspx" target="Frm_MAIN"><img src="Imagenes/btn_fotos.png" border="0" /></a></td>
                <td style="height: 37px">
                    <a href="Personal.aspx" target="Frm_MAIN"><img src="Imagenes/btn_turismo.png" border="0" /></a></td>
                <td style="height: 37px">
                    <a href="Nacionalidad.aspx" target="Frm_MAIN"><img src="Imagenes/btn_intranet.png" border="0" /></a></td>
                <td style="height: 37px"><a href="login.aspx" target="Frm_MAIN" onmouseover="MM_swapImage('Image8','','Imagenes/salir.png',1)" onmouseout="MM_swapImgRestore()"><img src="Imagenes/btn_contactanos.png" name="Image8" width="96" height="33" border="0" id="Image8" /></a></td>
          </tr>
        </tbody>
    </table>
</body>
</html>

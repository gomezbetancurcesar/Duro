<%@page import="java.sql.ResultSet"%>
<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
    <head id="Head1"> <title>Login</title>
    <link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
    <link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
    <link rel="stylesheet" href="css/Desck.css" type="text/css" />
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="css/bootstrap-responsive.css" type="text/css" />
    <!--<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>-->
    <script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
    <script src="js/jquery.validate.min.js" type="text/javascript"></script>
    
    <!--<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.9/jquery.validate.min.js" type="text/javascript"></script>-->
    <script src="js/Funcion_Errores.js" type="text/javascript" ></script>
    
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
    <script src="//code.jquery.com/jquery-1.10.2.js"></script>
    <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
    <script type="text/javascript">
    <%  HttpSession s = request.getSession();
            s.setAttribute("nom",null);%> 
        function validaLogin()
        {
            var rut = $("#tbUsuario").val();
            var pass = $("#tbPassword").val();
            var org = $("#tbOrgani").val();
            if (rut == "RUT USUARIO")
            {
                rut = "a";
                pass = "a";
            }
            if (rut == "") 
            {
                rut = "a";
                pass = "a";
            }
            if (pass === "" || pass === "||||||||||||")
            {
                pass = "a";
            }
            if (org == "")
            {
                org ="a";
            }
            $.ajax(
            {
                url : 'ServletValidaLogin', 
                data : "rut="+rut+"&pass="+pass+"&org="+org,
                type : 'POST',
                dataType : "html",
                success : function(data)
                {                  
                    
                    if (data != "ok")
                    {
                        FuncionErrores(4);
                        $("#txt_err_id").focus();
                        return false;
                    }
                    window.location='Main.jsp';
                }
            });
        }
     
        $(document).ready(function ()
        {
            $(".logines").focus(function ()
            {
                if (this.value == this.defaultValue)
                {
                    this.value = "";
                }
            }).blur(function ()
            {
                if (!this.value.length)
                {
                    this.value = this.defaultValue;
                }
            });
        });
    </script>
</head>
<body>
<div id="dialog" title="Basic dialog">
</div>
    <table class= "header">
        <tr>
            <td>
                <img align="left" src="images/logotipos/logo_solutel.png" width="180px" height="100px"/>
            </td>
        </tr>
        <tr>
            <td>
                <div id="PanelLogin">
                    <div class="contenedor">
                        <div class="loginAccesosContenidos">
                        </div>
                        <form action="" name="frmLogin" method="post">
                            <div class="loginAccesos">
                                <div class="P-Right section Bloque">
                                    <h2 style="margin-top:0px; padding-top:0px;">Acceso Usuarios</h2>
                                    <input name="tbUsuario" maxlength="11" type="text" id="tbUsuario"  class="validate[required] logines" value="RUT USUARIO" style="width:95%;" />
                                    <br />
                                    <br />
                                    <br />
                                    <br />
                                    <input name="tbPassword" maxlength="10" type="password" id="tbPassword" class="validate[required] logines"  value="||||||||||||" style="width:95%;" />
                                    <br />
                                    <br />
                                    <br />
                                    <span id="lblnoexiste" style="color:Red;"></span>	
                                    <br />
                                    <input name="btnLogin" type="button" id="btnLogin" onclick="validaLogin()" value="Ingresar" class="BotonIngresar"/>
                                </div>
                                <br />
                            </div>
                        </form>
                        <div style="width:100%; clear:left; background-color:#f2f2f2;">
                            <div style="width:800px; background-position: center top; margin: 0 auto; padding:10px;">
                                <b>Contáctenos</b>
                                <br />
                                <b>Dirección: </b> General Bari 144, Providencia, Chile
                                <b>Teléfono central:</b> 24841200
                                <b>Mail</b>: <a href="mailto:solutel@solutel.com ">solutel@solutel.com</a>
                            </div>
                        </div>
                        <br />
                        <br />
                        <br />
                    </div>
                </div>
            </td>
        </tr>
    </table>
</body>
</html>
    
<%@page import="java.sql.Types"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="DAL.conexionBD"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <title>Ingreso Orden Taller</title>
        <link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
        <link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />   
        <link href="css/style_tabla.css" type="text/css" rel="stylesheet" />
        <link href="css/solutel.css" type="text/css" rel="stylesheet" />
        <!--Codigo Sistemas SA-->
        <link href="css/calendario.css" type="text/css" rel="stylesheet" /> 

        <!--<link type="text/css" rel="stylesheet" media="screen" href="css/jquery.ui.all.css"/>-->
        <link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap-theme.min.css"/>
        <link type="text/css" rel="stylesheet" media="screen" href="css/jquery-ui.css"/>
        <link type="text/css" rel="stylesheet" href="css/bootstrap-3.3.5.min.css"/>
        

        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>

        <script src="js/calendar.js" type="text/javascript"></script>
        <script src="js/calendar-es.js" type="text/javascript"></script>
        <script src="js/calendar-setup.js" type="text/javascript"></script>
        <script src="js/Funcion_Errores.js" type="text/javascript"></script>
        <script src="js/validaciones.js" type="text/javascript"></script>        
        <!-- Librerias Jquery -->
        <script type="text/javascript" src="js/bootstrap-3.3.5.min.js"></script>
        <script type="text/javascript" src="js/jquery.validate-1.14.0.min.js"></script>
        <script type="text/javascript" src="js/jquery-validate.bootstrap-tooltip.js"></script>        
        <script src="js/jquery.validate.js" type="text/javascript"></script>
        <script src="js/jquery.validate.min.js" type="text/javascript"></script>
        <script src="js/messages_es.js" type="text/javascript" ></script>
        <script src="js/CargarCombo.js" type="text/javascript" ></script>
        <script src="js/CRUD_OrdenTaller.js" type="text/javascript"></script>
        <script src="js/CRUD_ordentaller_det.js" type="text/javascript"></script>
        <%
            //TipoUser, Rut y Nombre Ejecutivo PAra actualiza Actividad comercial.    
            HttpSession s = request.getSession();
            Connection _connMy = null;
            CallableStatement sp_usu = null;
            String tipoUser = "";
            String tipoNegocio = "";
            String rut = "";
            String nom = "";
            String id = "";
            String secuencia = "";
            String var = "";
            String tipoNeg = "";
            String fecha = "";
            String NomEje = "";
            String Estado = "";
            String rutEje = "";
            String rutCli = "";
            String nomCli = "";
            String caso = "";
            String tipServi = "";
            String servMovil = "";
            String cantMovil = "";
            String codCli = "";
            String tipCli = "";
            String corrOT = "0";
            String codEje = "";
            String crm = "";
            String comentario = "";
            String supervisor = "";
            String supervisorSP = "";
            String cantMovilSP = "";
            String negocio = "";

            corrOT = request.getParameter("secuencia") != null ? request.getParameter("secuencia") : "0";

            try {
                _connMy = conexionBD.Conectar((String) s.getAttribute("organizacion"));

                nom = (String) s.getAttribute("nom");

                if (s.getAttribute("nom") == null) {
                    response.sendRedirect("login.jsp");
                }

                if (request.getParameter("par") != null) {
                    id = request.getParameter("par");
                }
                if (request.getParameter("secuencia") != null) {
                    secuencia = request.getParameter("secuencia");
                }

            } catch (Exception e) {
                out.println("Error:" + e.getMessage());
            }

        %>
        <script type="text/javascript">

            $(document).ready(function () {
                cargaCotEspecial();                
                cargaOrdenTaller();                
            });

            function goBack() {
                location.href = 'svm_Seleccion_OT.jsp';
            }

            function getUrlParameter(sParam) {
                var sPageURL = decodeURIComponent(window.location.search.substring(1)),
                        sURLVariables = sPageURL.split('&'),
                        sParameterName,
                        i;

                for (i = 0; i < sURLVariables.length; i++) {
                    sParameterName = sURLVariables[i].split('=');

                    if (sParameterName[0] === sParam) {
                        return sParameterName[1] === undefined ? true : sParameterName[1];
                    }
                }
            };
            
            function loadDialogPiezas(){
    $( "#dialog_pieza" ).dialog({
        modal: true,
        width: 600,
        height:400,
        resizable: false,
        buttons: {
            Seleccionar: 
                function() {
                $("#select_ordentaller_pieza").val($("#select_cotizacion_pieza_filter").val());
                $( this ).dialog( "close" );
                cargaValorDetalle();
                calculaTotal();
            },
            Cancelar: function() {
                $( this ).dialog("close");
            }            
        },
        open: function(event, ui) {
            $("#txt_cotizacion_filtro_pieza").val("");
            $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
            filtraPiezas();
        }
    });
}

    function loadDialogClientes() {
                $("#dialog_clientes").dialog({
                    modal: true,
                    width: 600,
                    height: 420,
                    resizable: false,                    
                    buttons: {
                        Seleccionar: function () {
                            $("#txt_rutcli").val($("#select_cliente_filter").val());
                            var text = $("#select_cliente_filter option:selected").text();
                            $("#txt_cliente").val(text.substring(21, text.length));
                            $(this).dialog("close");
                        },
                        Cancelar: function () {
                            $(this).dialog("close");
                        }
                    },
                    open: function(event, ui) {
                        $("#txt_filtro_cliente_rut").val("");
                        $("#txt_filtro_cliente_nombre").val("");
                        $(".ui-dialog-titlebar-close", ui.dialog | ui).hide();
                        filtraClientes();
                    }
                });
            }

        </script>
    </head>
    <body id="principal">
        <input type="hidden" value="<%=id%>" id="parametroActComercial" />
        <div class="formularioIngresar">
            <table id="header">                           
                <tr>
                    <td>
                        <form action="" method="post">
                            <table>
                                <tr>
                                    <td colspan ="4" >DATOS OT<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                    <td colspan = "2">DATOS CLIENTES<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                                </tr>
                                <tr>
                                    <td>N° Orden:</td>                            
                                    <td>                                 
                                        <input type="text" disabled= "disabled" id="txt_orden_numero" maxlength="11" name="txt_orden_numero" />
                                    </td>                           
                                    <td>N° Factura:</td>
                                    <td><input type="text" disabled= "disabled" id="txt_factura_numero" maxlength="11" name="txt_factura_numero" /></td>
                                    <td>RUT:</td>
                                    <td><input type="text" readonly id="txt_rutcli" maxlength="11" name="txt_rutcli" />
                                    <input class = "botonera" style="width: 70px" type="button" name="btnClientes" id="btnClientes" value="Clientes" onClick="loadDialogClientes()" /></td>
                                    <td></td>
                                    <td>
                                
                                    </td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>
                                    <td>&nbsp;</td> <td>&nbsp;</td>                            
                                    <td>&nbsp;</td> <td>&nbsp;</td>  
                                    <td>&nbsp;</td> <td>&nbsp;</td>  
                                    <td>&nbsp;</td> <td>&nbsp;</td>  
                                    <td>&nbsp;</td> <td>&nbsp;</td>  
                                    <td>&nbsp;</td> <td>&nbsp;</td>  
                                    <td rowspan="6" >
                                        <div id="alineacionEstados" >
                                            <div class="etiqueta" >
                                                <center><label><b>Historial de Estados</b></label></center>
                                            </div>
                                            <div class="grillaConf">
                                                <table>
                                                    <thead>
                                                        <tr>
                                                            <th>Estado Anterior</th>
                                                            <th>Estado Siguiente</th>
                                                            <th>Fecha</th>                                    
                                                            <th>Rut Usuario</th>                                    
                                                            <th>Nombre Usuario</th>
                                                        </tr>
                                                    </thead>				
                                                    <tbody>
                                                        <%
                                                            int cont = 0;
                                                            var = "select";
                                                            sp_usu = _connMy.prepareCall("{call sp_historial(?,?,'','')}");
                                                            sp_usu.setString(1, var);
                                                            sp_usu.setLong(2, Long.parseLong(secuencia));
                                                            sp_usu.execute();
                                                            final ResultSet rsHistorial = sp_usu.getResultSet();
                                                            String claseGrilla = "";
                                                            while (rsHistorial.next()) {
                                                                if (cont % 2 == 0) {
                                                                    claseGrilla = "alt";
                                                                }
                                                                out.println("<tr id='filaTablaHistorial" + cont + "' class='" + claseGrilla + "'>");
                                                        %>                                                                                                                                                                    
                                                        <td id ="historial_estAnterior<%=cont%>"><%=rsHistorial.getString("estado_anterior")%></td>
                                                        <td id ="historial_estSiguiente<%=cont%>"><%=rsHistorial.getString("estado_siguiente")%></td>
                                                        <td id ="historial_fecha<%=cont%>"><%=rsHistorial.getString("fecha")%></td>
                                                        <td id ="historial_rutUser<%=cont%>"><%=rsHistorial.getString("rutUser")%></td>
                                                        <td id ="historial_nomUser<%=cont%>"><%=rsHistorial.getString("nomUser")%></td>                                                                                   
                                                        <%
                                                                out.print("</tr>");
                                                                claseGrilla = "";
                                                                cont++;
                                                            }
                                                        %>                               
                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Fecha emisi&oacute;n:</td>
                                    <td>
                                        <input type = "text" name = "txt_orden_fecha" readonly id= "txt_orden_fecha" size="12" />
                                        <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Inicial" id="lanzador"/>
                                        <!-- script que define y configura el calendario--> 
                                        <script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "txt_orden_fecha", // id del campo de texto 
                                                ifFormat: "%d-%m-%Y", // formato de la fecha que se escriba en el campo de texto 
                                                button: "lanzador"     // el id del boton que lanzará el calendario 
                                            });
                                        </script>	
                                    </td>                          
                                    <td>N° Gu&iacute;a Despacho:</td>
                                    <td><input type="text" disabled= "disabled" id="txt_guia_despacho" maxlength="11" name="txt_guia_despacho" /></td>
                                    <td>Cliente:</td>
                                    <td rowspan="3">
                                        <textarea rows="3" cols="27" readonly id="txt_cliente" maxlength="40">
                                        </textarea> 
                                    </td>
                                </tr>
                                <tr>
                                    <td>Fecha Despacho:</td>
                                    <td>
                                        <input type = "text" disabled= "disabled" name = "txt_orden_fecha_desp" readonly id= "txt_orden_fecha_desp" size="12" />
                                        <!-- <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Despacho" id="lanzador2"/> -->
                                        <!-- script que define y configura el calendario--> 
                                        <script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "txt_orden_fecha_desp", // id del campo de texto 
                                                ifFormat: "%d-%m-%Y", // formato de la fecha que se escriba en el campo de texto 
                                                button: "lanzador2"     // el id del boton que lanzará el calendario 
                                            });
                                        </script>
                                    </td>
                                    <td>Especial:</td>
                                    <td><select name="select_especial" id="select_especial">
                                            <option value="-1">--Seleccione--</option>
                                            <option value="NO">NO</option>
                                            <option value="SI">SI</option>
                                        </select> 
                                    </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>Fecha T&eacute;rmino:</td>
                                    <td>
                                        <input type = "text" disabled= "disabled" name = "txt_orden_fecha_term" readonly id= "txt_orden_fecha_term" size="12" />
                                        <!-- <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Despacho" id="lanzador3"/> -->
                                        <!-- script que define y configura el calendario--> 
                                        <script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "txt_orden_fecha_term", // id del campo de texto 
                                                ifFormat: "%d-%m-%Y", // formato de la fecha que se escriba en el campo de texto 
                                                button: "lanzador3"     // el id del boton que lanzará el calendario 
                                            });
                                        </script>
                                    </td>
                                    <td>Acepta con:</td>                            
                                    <td><input type="text" id="txt_acepta_con" maxlength="45" name="txt_acepta_con" /></td>
                                </tr>
                                <tr>
                                    <td>N° Cotizaci&oacute;n:</td>
                                    <td><input type="text" id="txt_cotizacion_numero" maxlength="9" name="txt_cotizacion_numero" onkeypress="return validarSiNumero(event)"/></td>
                                </tr>
                                <tr>
                                    <td>Detalle:</td>
                                    <td> <textarea rows="3" cols="27" maxlength="255" id="txt_detalle"></textarea>  </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                </tr>
                            </table>    
                            <table>
                                <tr>
                                    <td colspan ="8" ><hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                </tr> 
                                <tr>
                                    <td colspan ="8" >TALLER<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                </tr>                        
                                <tr>
                                    <td colspan = "2">DATOS RECTIFICADO PREVIO<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                    <td colspan = "2">DATOS DE CROMADO<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                                    <td colspan = "2">DATOS RECTIFICADO FINAL<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                    <td colspan = "2">INSPECCI&Oacute;N FINAL<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>Rectificado pr&eacute;vio:</td>
                                    <td><select name="select_rectificado_previo" id="select_rectificado_previo">
                                            <option value="-1">--Seleccione--</option>
                                            <option value="NO">NO</option>
                                            <option value="SI">SI</option>
                                    </select> </td>
                                    <td>Cromado:</td>
                                    <td><select name="select_cromado" id="select_cromado">
                                            <option value="-1">--Seleccione--</option>
                                            <option value="NO">NO</option>
                                            <option value="SI">SI</option>
                                    </select> </td>
                                    <td>Rectificado final:</td>
                                    <td><select name="select_rectificado_final" id="select_rectificado_final">
                                            <option value="-1">--Seleccione--</option>
                                            <option value="NO">NO</option>
                                            <option value="SI">SI</option>
                                    </select> </td>                                    
                                    <td rowspan="3">Observaciones:</td>
                                    <td rowspan="3"><textarea rows="2" cols="27" maxlength="60" id="txt_observaciones"></textarea></td>
                                </tr>
                                <tr>
                                    <td>Medida Obtenida:</td>
                                    <td><input type="text" id="txt_medida_obtenida_rectprevio" maxlength="6" name="txt_medida_rect_previo" onkeypress="return validarSiDecimal(event)"/></td>
                                    <td>Espesor pedido:</td>
                                    <td><input type="text" id="txt_espesor_pedido" maxlength="6" name="txt_espesor_pedido" onkeypress="return validarSiDecimal(event)"/></td>
                                    <td>Medida Obtenida:</td>
                                    <td><input type="text" id="txt_medida_obtenida_rectfinal" maxlength="6" name="txt_medida_rect_final" onkeypress="return validarSiDecimal(event)"/></td>                                    
                                </tr>
                                <tr>
                                    <td>Rectificado en:</td>
                                    <td><input type="text" id="txt_rectificadoprevio_en" maxlength="20" name="txt_rectificadoprevio_en" /></td>
                                    <td>Cromado en:</td>
                                    <td><input type="text" id="txt_cromado_en" maxlength="20" name="txt_cromado_en"/></td>
                                    <td>Rectificado en:</td>
                                    <td><input type="text" id="txt_rectificadofinal_en" maxlength="20" name="txt_rectificadofinal_en" /></td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>

                                <tr>
                                    <td>Torno:</td>
                                    <td><select id="select_torno_rect_previo" name="select_torno_rect_previo" >
                                        <option value="-1">--Seleccione--</option>
                                        <option value="NO">NO</option>
                                        <option value="SI">SI</option>
                                        </select>
                                    </td>
                                    <td>Superficie:</td>
                                    <td><input type="text" id="txt_superficie" maxlength="6" name="txt_superficie" onkeypress="return validarSiDecimal(event)"/></td>
                                    <td>Torno:</td>
                                    <td><select id="select_torno_rect_final" name="select_torno_rect_final" >
                                        <option value="-1">--Seleccione--</option>
                                        <option value="NO">NO</option>
                                        <option value="SI">SI</option>
                                        </select>                                            
                                    </td>
                                    <td rowspan="3">Inspecci&oacute;n final:</td>
                                    <td rowspan="3"><textarea rows="3" cols="27" maxlength="60" id="txt_inspeccion_final"></textarea></td>                                    
                                    <td>&nbsp;</td>                                     
                                </tr>                            
                                <tr>
                                    <td>Por:</td>
                                    <td><input type="text" id="txt_tornopor_previo" maxlength="19" name="txt_tornopor_previo" /></td>
                                    <td>Corriente:</td>
                                    <td><input type="text" id="txt_corriente" maxlength="6" name="txt_corriente" onkeypress="return validarSiDecimal(event)"/></td>
                                    <td>Por:</td>
                                    <td><input type="text" id="txt_tornopor_final" maxlength="19" name="txt_tornopor_final" /></td>                                                               
                                </tr>                           
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>Tiempo:</td>
                                    <td><input type="text" id="txt_tiempo" maxlength="20" name="txt_tiempo" /></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>Otro baño o tratamiento:</td>
                                    <td><input type="text" id="txt_otro_tratamiento" maxlength="40" name="txt_otro_tratamiento" /></td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>                                    
                                    <td>Tratamiento Final T&eacute;rmico:</td>
                                    <td><input type="text" id="txt_tratamientofinaltermico" maxlength="40" name="txt_tratamientofinaltermico" /></td>                                    
                                </tr>    
                            </table>
                            <table>                        
                                <tr>
                                    <td colspan ="8" ><hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                </tr>       
                                <tr>
                                    <td colspan ="8" >ASPECTOS ADICIONALES A CONSIDERAR<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                </tr>       
                                <tr>
                                    <td>Metal Base:</td>
                                    <td><input type="text" id="txt_metalbase_considerar" maxlength="4" name="txt_metalbase_considerar" /></td>
                                    <td>Cromados Anteriores:</td>
                                    <td><input type="text" id="txt_cromados_anteriores" maxlength="30" name="txt_cromados_anteriores" /></td>
                                    <td>Temperatura:</td>
                                    <td><input type="text" id="txt_temperatura" maxlength="20" name="txt_temperatura" /></td>
                                </tr>
                                <tr>
                                    <td>Tratamiento T&eacute;rmico:</td>
                                    <td><select name="select_tratamiento_termico" id="select_tratamiento_termico">
                                            <option value="-1">--Seleccione--</option>
                                            <option value="NO">SI</option>
                                            <option value="SI">NO</option>
                                        </select> 
                                    </td>
                                    <td>Presi&oacute;n:</td>
                                    <td><input type="text" id="txt_presion" maxlength="20" name="txt_presion" /></td>
                                    <td>Suspensi&oacute;n de la Pieza:</td>
                                    <td><input type="text" id="txt_suspension" maxlength="20" name="txt_suspension" /></td>
                                </tr>
                                <tr>
                                    <td>Superficie Dureza:</td>
                                    <td><select name="select_superficiedureza" id="select_superficiedureza">
                                            <option value="-1">--Seleccione--</option>
                                            <%
                                                Statement stmt = null;
                                                ResultSet rsQuery = null;                                       
                                                String q = "";
                                                
                                                stmt = _connMy.createStatement();
                                                q="select descripcion from svm_mae_tablas where tablas = 'Superficie Dureza'";
                                                rsQuery = stmt.executeQuery(q);
                                                while(rsQuery.next())
                                                {
                                                    out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                                }
                                            %>                                            
                                        </select> 
                                    </td>
                                    <td>Medio:</td>
                                    <td><input type="text" id="txt_medio" maxlength="20" name="txt_medio" /></td>
                                    <td>Conexi&oacute;n El&eacute;ctrica:</td>
                                    <td><input type="text" id="txt_conexion_electrica" maxlength="40" name="txt_conexion_electrica" /></td>
                                </tr>
                                <tr>
                                    <td>Superficie Estado:</td>
                                    <td><select name="select_superficieestado" id="select_superficieestado">
                                            <option value="-1">--Seleccione--</option>
                                            <%
                                                stmt = _connMy.createStatement();
                                                q="select descripcion from svm_mae_tablas where tablas = 'Superficie Estado'";
                                                rsQuery = stmt.executeQuery(q);
                                                while(rsQuery.next())
                                                {
                                                    out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                                }
                                            %>                                             
                                        </select> 
                                    </td>
                                    <td>Desgaste:</td>
                                    <td><input type="text" id="txt_desgaste" maxlength="20" name="txt_desgaste" /></td>
                                </tr>                                              
                                <tr>
                                    <td>Superficie Soldadura:</td>
                                    <td><select name="select_superficiesoldadura" id="select_superficiesoldadura">
                                            <option value="-1">--Seleccione--</option>
                                            <%
                                                stmt = _connMy.createStatement();
                                                q="select descripcion from svm_mae_tablas where tablas = 'Superficie Soldadura'";
                                                rsQuery = stmt.executeQuery(q);
                                                while(rsQuery.next())
                                                {
                                                    out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                                }
                                            %>                                                
                                        </select> 
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan = "8"><hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                                </tr>
                                <tr>
                                    <td colspan = "8">PIEZA<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                                </tr>                    
                                <tr>
                                    <td>Pieza:</td>
                                    <td>
                                        <select style="width:120px" id="select_ordentaller_pieza" name="select_ordentaller_pieza">
                                        <option value="">--Seleccione--</option>
                                            <%
                                                stmt = _connMy.createStatement();
                                                q="select codigo, nombre from svm_mae_pieza";
                                                rsQuery = stmt.executeQuery(q);
                                                while(rsQuery.next())
                                                {
                                                    out.println("<option value='"+rsQuery.getString("codigo")+"'>"+rsQuery.getString("nombre")+"</option>");
                                                }
                                            %>
                                            </select> 
                                            <input class = "botonera" type="button" name="btnPiezas" id="btnPiezas" value="Piezas" onClick="loadDialogPiezas()" /></td>
                                           
                                    <td>Cantidad:</td>
                                    <td><input type="text" maxlength="9" id="txt_cotizacion_cantidad" name="txt_cotizacion_cantidad" /></td>         
                                    <td>Estado:</td>
                                    <td><select name="select_estado_piezas" id="select_estado_piezas">
                                        <option value="-1">--Seleccione--</option>
                                            <%
                                                stmt = _connMy.createStatement();
                                                q="select descripcion from svm_mae_tablas where tablas = 'Estado Pieza'";
                                                rsQuery = stmt.executeQuery(q);
                                                while(rsQuery.next())
                                                {
                                                    out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                                }
                                            %>       
                                        </select> </td>
                                </tr> 
                                <tr>        
                                    <td>Metal base:</td>
                                    <td><select name="select_metalbase_piezas" id="select_metalbase_piezas">
                                        <option value="-1">--Seleccione--</option>
                                            <%
                                                stmt = _connMy.createStatement();
                                                q="select descripcion from svm_mae_tablas where tablas = 'Metalbase'";
                                                rsQuery = stmt.executeQuery(q);
                                                while(rsQuery.next())
                                                {
                                                    out.println("<option value='"+rsQuery.getString("descripcion")+"'>"+rsQuery.getString("descripcion")+"</option>");
                                                }
                                            %>                                               
                                        </select> </td>
                                    <td>Medidas:</td>
                                    <td><input type="text" maxlength="6" id="txt_medidas1_pieza" name="txt_medidas1_pieza" onkeypress="return validarSiDecimal(event)"/></td>         
                                    <td></td>
                                    <td><input type="text" maxlength="6" id="txt_medidas2_pieza" name="txt_medidas2_pieza" onkeypress="return validarSiDecimal(event)"/></td>         
                                </tr>
                                <tr>
                                    <td>Largo:</td>
                                    <td><input type="text" maxlength="6" id="txt_largo_pieza" name="txt_largo_pieza" onkeypress="return validarSiDecimal(event)"/></td>
                                    <td>Planos:</td>
                                    <td><input type="text" maxlength="30" id="txt_planos_pieza" name="txt_planos_pieza" /></td>         
                                    <td rowspan="3">Trabajo a realizar:</td>
                                    <td rowspan="3"><textarea rows="3" cols="27" maxlength="20" id="txt_trabajo_realizar"></textarea></td>                                    
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>      
            </table>
        </div>            
        <input class ="botonera" type="submit" id="btn_ordentaller_grabar" name="btn_ordentaller_grabar" value="Grabar" onclick="grabarOrdenTaller()"/>
        <input class = "botonera" type="submit" name="btnCancela" value="Cancelar" onClick="goBack()" />
        
<div id="dialog_pieza" title="Piezas" style="display:none;">
    <div id="contenido_pieza">
        Nombre de pieza:&nbsp;&nbsp;
       <input type="text" maxlength="11" id="txt_cotizacion_filtro_pieza" name="txt_cotizacion_filtro_pieza" />
       &nbsp;&nbsp;&nbsp;
       <input style="font-size:12px; height: 23px" class = "botonera" type="submit" name="btnCancela" value="Filtrar Piezas" onclick="filtraPiezas()" />
       <br/>
       <br/>
        <select size="10" style="width: 560px;" id="select_cotizacion_pieza_filter" name="select_cotizacion_pieza_filter" multiple>
            <%                                    
                stmt = _connMy.createStatement();
                q="select codigo, nombre from svm_mae_pieza";
                rsQuery = stmt.executeQuery(q);

                while(rsQuery.next())
                {
                    out.println("<option value='"+rsQuery.getString("codigo")+"'>"+rsQuery.getString("nombre")+"</option>");
                }
            %>
        </select>
    </div>
</div>        

        <div id="dialog_clientes" title="Clientes" style="display:none;" >
            <div id="contenido_clientes">
                <table>
                    <tr>
                        <td>Rut de cliente:</td>
                        <td><input type="text" style="width: 160px" id="txt_filtro_cliente_rut" name="txt_filtro_cliente_rut" /></td>
                        <td>&nbsp;&nbsp;<input style="font-size:12px; height: 23px; width: 120px" class = "botonera" type="submit" name="btnCancela" value="Filtrar Clientes" onclick="filtraClientes()" /></td>
                    </tr>
                    <tr>
                        <td>Nombre de cliente</td>
                        <td><input type="text" style="width: 160px" id="txt_filtro_cliente_nombre" name="txt_filtro_cliente_nombre" /></td>
                        <td></td>
                    </tr>
                </table>
                <br/>
                <select size="10" style="width: 560px;" id="select_cliente_filter" name="select_cliente_filter" multiple>
                    <%                stmt = _connMy.createStatement();
                        q="SELECT concat(rut,'-',dv) rut, razon_social,replace(concat(rpad(concat(rut,'-',dv),20,' '),'|'),' ','&nbsp;') rut_pad FROM svm_mae_clientes";
                        rsQuery = stmt.executeQuery(q);
                        while(rsQuery.next())
                        {
                            out.println("<option value='"+rsQuery.getString("rut")+"'>"+rsQuery.getString("rut_pad")+rsQuery.getString("razon_social")+"</option>");
                        }
                    %>
                </select>
            </div>
        </div>

    </body>
</html>

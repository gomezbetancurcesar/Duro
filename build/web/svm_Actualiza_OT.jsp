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

        <link type="text/css" rel="stylesheet" media="screen" href="css/jquery.ui.all.css"/>
        <link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap.min.css"/>
        <link type="text/css" rel="stylesheet" media="screen" href="css/bootstrap-theme.min.css"/>
        <link type="text/css" rel="stylesheet" media="screen" href="css/jquery-ui.css"/>

        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <script src="js/jquery-ui.js" type="text/javascript"></script>

        <script src="js/calendar.js" type="text/javascript"></script>
        <script src="js/calendar-es.js" type="text/javascript"></script>
        <script src="js/calendar-setup.js" type="text/javascript"></script>
        <script src="js/Funcion_Errores.js" type="text/javascript"></script>
        <!-- Librerias Jquery -->
        <script src="js/jquery.validate.js" type="text/javascript"></script>
        <script src="js/jquery.validate.min.js" type="text/javascript"></script>
        <script src="js/jquery.validate.js" type="text/javascript"></script>
        <script src="js/messages_es.js" type="text/javascript" ></script>
        <script src="js/CargarCombo.js" type="text/javascript" ></script>
        <script src="js/CRUD_OrdenTaller.js" type="text/javascript"></script>
        <script src="js/CRUD_ordentaller_det.js" type="text/javascript"></script>
        <!--<script src="js/CargaPlanes.js" type="text/javascript" ></script>
        
        <script src="js/jquery-2.1.3.js" type="text/javascript"></script>
        <script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
        <script src="js/jquery.min.js" type="text/javascript"></script>
        
        <script src="js/CRUD_ActividadComercial.js" type="text/javascript"></script>
        <script src="js/validaciones.js" type="text/javascript"></script>
        <script src="js/ValidacionActividadComercial.js" type="text/javascript"></script>
        <script src="js/CRUD_DetalleActComer.js" type="text/javascript" ></script>
        <script src="js/CRUD_Distribucion.js" type="text/javascript" ></script>-->
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
            String corrCotiza = "0";
            String codEje = "";
            String crm = "";
            String comentario = "";
            String supervisor = "";
            String supervisorSP = "";
            String cantMovilSP = "";
            String negocio = "";

            corrCotiza = request.getParameter("secuencia") != null ? request.getParameter("secuencia") : "0";

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
                cargaMoneda();
                cargaCotEspecial();
                cargaPresupuesto();
                cargaCondicion();
                cargaPLazoEntrega();
                //cargaCotizacion();
                $("#txt_cotizacion_cantidad").keyup(function () {
                    calculaTotal();
                });
                $("#txt_cotizacion_valUniCrom").keyup(function () {
                    calculaTotal();
                });
            });

            function goBack() {
                location.href = 'svm_Seleccion_Cotizacion.jsp';
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
            }
            ;

            function loadDialogPiezas() {
                $("#dialog_pieza").dialog({
                    modal: true,
                    width: 600,
                    height: 400,
                    buttons: {
                        Cancelar: function () {
                            $(this).dialog("close");
                        },
                        Seleccionar: function () {
                            $("#select_cotizacion_pieza").val($("#select_cotizacion_pieza_filter").val());
                            $(this).dialog("close");
                            cargaValorDetalle();
                            calculaTotal();
                        }
                    }
                });
            }

            function loadDialogClientes() {
                $("#dialog_clientes").dialog({
                    modal: true,
                    width: 600,
                    height: 420,
                    buttons: {
                        Cancelar: function () {
                            $(this).dialog("close");
                        },
                        Seleccionar: function () {
                            $("#txt_cotizacion_rutcli").val($("#select_cliente_filter").val());
                            var text = $("#select_cliente_filter option:selected").text();
                            $("#txt_cotizacion_cli").val(text.substring(21, text.length));
                            $(this).dialog("close");
                        }
                    }
                });
            }

        </script>
    </head>
    <body id="principal">
        <input type="hidden" value="<%=id%>" id="parametroActComercial" />
        <input type="hidden" value="<%=servMovil%>" id="tipServicio" />
        <input type="hidden" value="<%=tipoUser%>" id="tipoUser" />
        <input type="hidden" value="<%=rut%>" id="rutUsuario" />
        <input type="hidden" value="<%=tipServi%>" id="tipoServicioMovil" />
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
                                    <td><input type="text" disabled= "disabled" id="txt_factura_numero" maxlength="11" name="txt_factura_numero" />
                                        <td>RUT:</td>
                                        <td>
                                            <input type="text" disabled= "disabled" id="txt_rutcli" maxlength="11" name="txt_rutcli" />
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
                                                ifFormat: "%Y-%m-%d", // formato de la fecha que se escriba en el campo de texto 
                                                button: "lanzador"     // el id del boton que lanzará el calendario 
                                            });
                                        </script>	
                                    </td>                          
                                    <td>N° Gu&iacute;a Despacho:</td>
                                    <td>
                                        <input type="text" disabled= "disabled" id="txt_guia_despacho" maxlength="11" name="txt_guia_despacho" />
                                    </td>
                                    <td>Cliente:</td>
                                    <td>
                                        <input type="text" disabled= "disabled" id="txt_cliente" maxlength="11" name="txt_cliente" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>Fecha Despacho:</td>
                                    <td>
                                        <input type = "text" name = "txt_orden_fecha_desp" readonly id= "txt_orden_fecha_desp" size="12" />
                                        <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Despacho" id="lanzador2"/>
                                        <!-- script que define y configura el calendario--> 
                                        <script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "txt_orden_fecha_desp", // id del campo de texto 
                                                ifFormat: "%Y-%m-%d", // formato de la fecha que se escriba en el campo de texto 
                                                button: "lanzador2"     // el id del boton que lanzará el calendario 
                                            });
                                        </script>
                                    </td>
                                    <!--<td><input type="text" id="txt_cotizacion_atencion" maxlength="11" name="txt_cotizacion_atencion" /></td>-->
                                    <td>Especial:</td>
                                    <td><select name="select_especial" id="select_especial">
                                            <option value="-1">--Seleccione--</option>
                                            <option value="0">NO</option>
                                            <option value="1">SI</option>
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
                                        <input type = "text" name = "txt_orden_fecha_term" readonly id= "txt_orden_fecha_term" size="12" />
                                        <img src="images/calendario.png" width="16" height="16" border="0" title="Fecha Despacho" id="lanzador3"/>
                                        <!-- script que define y configura el calendario--> 
                                        <script type="text/javascript">
                                            Calendar.setup({
                                                inputField: "txt_orden_fecha_term", // id del campo de texto 
                                                ifFormat: "%Y-%m-%d", // formato de la fecha que se escriba en el campo de texto 
                                                button: "lanzador3"     // el id del boton que lanzará el calendario 
                                            });
                                        </script>
                                    </td>

                                    <td>Acepta con:</td>                            
                                    <td><input type="text" id="txt_acepta_con" maxlength="11" name="txt_acepta_con" /></td>
                                </tr>
                                <tr>
                                    <td>N° Cotizaci&oacute;n:</td>
                                    <td><input type="text" disabled= "disabled" id="txt_cotizacion_numero" maxlength="11" name="txt_cotizacion_numero" />
                                    </td>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Detalle:</td>
                                    <td> <textarea rows="3" cols="27" disabled= "disabled" id="txt_detalle"></textarea>  </td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>

                                    </td>
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
                                    <td>Rectificado en:</td>
                                    <td><input type="text" id="txt_rectificado_en" name="txt_rectificado_en" /></td>
                                    <td>Cromado en:</td>
                                    <td><input type="text" id="txt_cromado_en" name="txt_cromado_en" /></td>
                                    <td>Rectificado en:</td>
                                    <td><input type="text" id="txt_rectificado_en_final" name="txt_rectificado_en_final" /></td>
                                    <td rowspan="3">Observaciones:</td>
                                    <td rowspan="3"><textarea rows="3" cols="27" id="txt_observaciones"></textarea></td>
                                </tr>
                                <tr>
                                    <td>Medida Obtenida:</td>
                                    <td><input type="text" id="txt_medida_obtenida" name="txt_medida_obtenida" /></td>
                                    <td>Superficie:</td>
                                    <td><input type="text" id="txt_superficie" name="txt_superficie" /></td>
                                    <td>Medida Obtenida:</td>
                                    <td><input type="text" id="txt_medida_obtenida_final" name="txt_medida_obtenida_final" /></td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>Torno:</td>
                                    <td><input type="text" id="txt_torno" name="txt_torno" /></td>
                                    <td>Corriente:</td>
                                    <td><input type="text" id="txt_corriente" name="txt_corriente" /></td>
                                    <td>Torno:</td>
                                    <td><input type="text" id="txt_torno_final" name="txt_torno_final" /></td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>                            
                                </tr>
                                <tr>
                                    <td>Por:</td>
                                    <td><input type="text" id="txt_por" name="txt_por" /></td>
                                    <td>Tiempo:</td>
                                    <td><input type="text" id="txt_tiempo" name="txt_tiempo" /></td>
                                    <td>Por:</td>
                                    <td><input type="text" id="txt_por_final" name="txt_por_final" /></td>                           
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>Otro baño o tratamiento:</td>
                                    <td><input type="text" id="txt_otro_tratamiento" name="txt_otro_tratamiento" /></td>
                                </tr>                           
                                <tr>
                                    <td colspan ="8" ><hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                </tr>       
                                <tr>
                                    <td colspan ="8" >ASPECTOS ADICIONALES A CONSIDERAR<hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                                </tr>       
                                <tr>
                                    <td>Metal Base:</td>
                                    <td><select name="select_metal_base" id="select_metal_base">
                                            <option value="">--Seleccione--</option>
                                        </select> 
                                    </td>
                                    <td>Cromados Anteriores:</td>
                                    <td><input type="text" id="txt_cromados_anteriores" name="txt_cromados_anteriores" /></td>
                                    <td>Temperatura:</td>
                                    <td><input type="text" id="txt_temperatura" name="txt_temperatura" /></td>
                                </tr>
                                <tr>
                                    <td>Tratamiento T&eacute;rmico:</td>
                                    <td><select name="select_tratamiento_termico" id="select_tratamiento_termico">
                                            <option value="">--Seleccione--</option>
                                        </select> 
                                    </td>
                                    <td>Presi&oacute;n:</td>
                                    <td><input type="text" id="txt_presion" name="txt_presion" /></td>
                                    <td>Suspensi&oacute;n de la Pieza:</td>
                                    <td><input type="text" id="txt_suspension" name="txt_suspension" /></td>
                                </tr>
                                <tr>
                                    <td>Superficie:</td>
                                    <td><select name="select_superficie" id="select_superficie">
                                            <option value="">--Seleccione--</option>
                                        </select> 
                                    </td>
                                    <td>Medio:</td>
                                    <td><input type="text" id="txt_medio" name="txt_medio" /></td>
                                    <td>Conexi&oacute;n El&eacute;ctrica:</td>
                                    <td><input type="text" id="txt_conexion_electrica" name="txt_conexion_electrica" /></td>
                                </tr>
                                <tr>
                                    <td>Estado:</td>
                                    <td><select name="select_estado" id="select_estado">
                                            <option value="">--Seleccione--</option>
                                        </select> 
                                    </td>
                                    <td>Desgaste:</td>
                                    <td><input type="text" id="txt_desgaste" name="txt_desgaste" /></td>
                                    <td>Rectificado pr&eacute;vio:</td>
                                    <td><select name="select_rectificado_previo" id="select_rectificado_previo">
                                            <option value="-1">--Seleccione--</option>
                                                                                        <option value="0">NO</option>
                                            <option value="1">SI</option>

                                        </select> </td>
                                </tr>                        
                                </tr>
                                <tr>
                                    <td rowspan="3">Trabajo a realizar:</td>
                                    <td rowspan="3"><textarea rows="3" cols="27" id="txt_trabajo_realizar"></textarea>
                                    </td>
                                    <td>Medida:</td>
                                    <td><input type="text" id="txt_medida" name="txt_medida" /></td>
                                    <td>Cromado:</td>
                                    <td><select name="select_cromado" id="select_cromado">
                                            <option value="-1">--Seleccione--</option>
                                                                                        <option value="0">NO</option>
                                            <option value="1">SI</option>

                                        </select> </td>
                                </tr>                           
                                <tr>
                                    <td>Espesor pedido:</td>
                                    <td><input type="text" id="txt_espesor_pedido" name="txt_espesor_pedido" /></td>
                                    <td>Rectificado final:</td>
                                    <td><select name="select_rectificado_final" id="select_rectificado_final">
                                            <option value="-1">--Seleccione--</option>
                                                                                        <option value="0">NO</option>
                                            <option value="1">SI</option>

                                        </select> </td>
                                </tr>                              
                                <tr>
                                    <td>Medida:</td>
                                    <td><input type="text" id="txt_medida2" name="txt_medida2" /></td>
                                </tr>                             
                            </table>
                        </form>
                    </td>

                </tr>      
                <tr>
                    <td colspan="9">
                        <table class="detalle">
                            <tr>
                                <td colspan = "14"><hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                            </tr>
                            <tr>
                                <td colspan = "14">PIEZAS<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                            </tr>                    
                            <tr>
                                <td>Pieza:</td>
                                <td><select style="width:120px" id="select_cotizacion_pieza" onchange="cargaValorDetalle()" name="select_cotizacion_pieza">
                                        <option value="">--Seleccione--</option>
                                        <%
                                            //stmt = _connMy.createStatement();
                                            //q="select codigo, nombre from svm_mae_pieza";
                                            //rsQuery = stmt.executeQuery(q);
                                            //while(rsQuery.next())
                                            //{
                                            //    out.println("<option value='"+rsQuery.getString("codigo")+"'>"+rsQuery.getString("nombre")+"</option>");
                                            //}
                                        %>
                                    </select> 
                                    <input class = "botonera" type="submit" name="btnCancela" value="Piezas" onClick="loadDialogPiezas()" /></td>
                                <td>Cantidad:</td>
                                <td><input type="text" maxlength="11" id="txt_cotizacion_cantidad" name="txt_cotizacion_cantidad" /></td>         
                                <td>Estado:</td>
                                <td><select name="select_estado_piezas" id="select_estado_piezas">
                                        <option value="">--Seleccione--</option>
                                    </select> </td></td>         
                                <td>Metal base:</td>
                                <td><select name="select_metalbase_piezas" id="select_metalbase_piezas">
                                        <option value="">--Seleccione--</option>
                                    </select> </td></td>         
                                <td>Planos:</td>
                                <td><input type="text" maxlength="11" id="txt_planos_pieza" name="txt_planos_pieza" /></td>         
                                <td>Medida:</td>
                                <td><input type="text" maxlength="11" id="txt_medida_pieza" name="txt_medidas_pieza" /></td>         
                                <td>Largo:</td>
                                <td><input type="text" maxlength="11" id="txt_largo_pieza" name="txt_largo_pieza" /></td>
                            </tr>
                            <tr>
                                <td colspan="13" rowspan="5" id='margen'>
                                    <div  id = "tablaDetalle" class="grillaConf">
                                        <table id="tblDetalleComer">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Numero</th>
                                                    <th>Cod. Pieza</th>
                                                    <th>Pieza</th>
                                                    <th>Cantidad</th>
                                                    <th>Valor DM</th>
                                                    <th>D&iacute;ametro</th>
                                                    <th>Largo</th>
                                                    <th>ValUniCrom</th>
                                                    <th>Total Crom</th>
                                                </tr>
                                            </thead>				
                                            <tbody>
                                                <%                                        cont = 0;
                                                    int ultimo = 0;

                                                    var = "select";
                                                    sp_usu = _connMy.prepareCall("{call sp_cotizaciones_det(?,?,?,?,?,?,?,?,?,?,?,?)}");
                                                    sp_usu.setString(1, var);
                                                    sp_usu.setInt(2, 0);
                                                    sp_usu.setInt(3, 0);
                                                    sp_usu.setString(4, "");
                                                    sp_usu.setString(5, "");
                                                    sp_usu.setInt(6, 0);
                                                    sp_usu.setString(7, "");
                                                    sp_usu.setDouble(8, 0.0);
                                                    sp_usu.setDouble(9, 0.0);
                                                    sp_usu.setInt(10, 0);
                                                    sp_usu.setInt(11, 0);
                                                    sp_usu.setInt(12, Integer.parseInt(corrCotiza));
                                                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                                                    sp_usu.execute();
                                                    final ResultSet rsDetalle = sp_usu.getResultSet();
                                                    claseGrilla = "";
                                                    while (rsDetalle.next()) {
                                                        if (cont % 2 == 0) {
                                                            claseGrilla = "alt";
                                                        }
                                                        out.println("<tr id='filaTablaDetalle" + cont + "' class='" + claseGrilla + "'>");
                                                %>                                        
                                                <td>
                                                    <a id="seleccion<%=cont%>" href="javascript: onclick=ModificaDetalleComercial(<%=cont%>)"> >></a>
                                                    <input type="hidden" value="0" id="habilitaDetCom" name="habilitaDetCom" />
                                                </td>                                                                                       
                                                <td id ="cotazacionDet_correlativo<%=cont%>"><%=rsDetalle.getString("correlativo")%></td>
                                                <td id ="cotazacionDet_codPieza<%=cont%>"><%=rsDetalle.getString("cod_pieza")%></td>
                                                <td id ="cotazacionDet_pieza<%=cont%>"><%=rsDetalle.getString("desc_pieza")%></td>
                                                <td id ="cotazacionDet_cantidad<%=cont%>"><%=rsDetalle.getString("cantidad")%></td>
                                                <td id ="cotazacionDet_valorDm<%=cont%>"><%=rsDetalle.getString("valor_dm")%></td>
                                                <td id ="cotazacionDet_diametro<%=cont%>"><%=rsDetalle.getString("diametro")%></td>
                                                <td id ="cotazacionDet_largo<%=cont%>"><%=rsDetalle.getString("largo")%></td>                                            
                                                <td id ="cotazacionDet_valUniCrom<%=cont%>"><%=rsDetalle.getString("valor_uni_crom")%></td>
                                                <td id ="cotazacionDet_totalCrom<%=cont%>"><%=rsDetalle.getString("total_cromado")%></td>
                                                <%
                                                        out.print("</tr>");
                                                        claseGrilla = "";
                                                        cont++;
                                                        ultimo = Integer.parseInt(rsDetalle.getString("numero_cotizacion"));

                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                        <input type="hidden" id="ultimo" value="<%=ultimo + 1%>"></input>
                                        <input type="hidden" id="cantidad" value="<%=cont%>"></input>
                                        <input type="hidden" id="txt_correlativo" value=""></input>
                                    </div>                                               
                                </td>
                                <td id="bottom" rowspan="1">
                                    <img style="cursor: pointer" onclick="ingresaDetalleOT()" id="DetalleIngreso" class="ico" border="0" src="images/logotipos/agregar.png" 
                                         height="48px" width="25px"/>
                                </td>
                            </tr>
                            <tr>
                                <td id="bottom">
                                    <a href="#">
                                        <img id="DetalleModifica" style="display: none" onclick="modificaDetalle()" src="images/logotipos/modificar.png" border="0" 
                                             height="25px" width="25px" />
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td id="bottom">
                                    <a href="#">
                                        <img id="DetalleElimina" style="display: none" border="0" onclick="eliminaDetalle()" src="images/logotipos/eliminar.png" 
                                             height="25px" width="25px" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td colspan="6">
                        <table class="detalle">
                            <tr>
                                <td colspan="6"><hr style="margin-bottom: 4px;margin-top: 4px;" /></td>
                            </tr>       
                            <tr>
                                <td colspan="6">DETALLE TRABAJO A REALIZAR<hr style="margin-bottom: 4px;margin-top: 4px;"/></td>
                            </tr>
                            <tr>
                                <td rowspan="3">Trabajo a realizar:</td>
                                <td rowspan="3"><textarea rows="3" cols="27" id="txt_trabajo_realizar_detalle"></textarea>
                                </td>
                                <td>Rectificado pr&eacute;vio:</td>
                                <td><select name="select_rectificado_previo_detalle" id="select_rectificado_previo_detalle">
                                        <option value="-1">--Seleccione--</option>
                                        <option value="0">NO</option>
                                        <option value="1">SI</option>
                                    </select> </td>
                                <td>Medida:</td>
                                <td><input type="text" id="txt_medida_rect_previo_detalle" name="txt_medida_rect_previo_detalle" /></td>
                            </tr>
                            <tr>
                                <td>Cromado:</td>
                                <td><select name="select_cromado_detalle" id="select_cromado_detalle">
                                        <option value="-1">--Seleccione--</option>
                                        <option value="0">NO</option>
                                        <option value="1">SI</option>
                                    </select> </td>
                                <td>Espeso pedido:</td>
                                <td><input type="text" id="txt_espesor_pedido_detalle" name="txt_espesor_pedido_detalle" /></td>
                            </tr>                    
                            <tr>
                                <td>Rectificado final:</td>
                                <td><select name="select_rectificado_final_detalle" id="select_rectificado_final_detalle">
                                        <option value="-1">--Seleccione--</option>
                                        <option value="0">NO</option>
                                        <option value="1">SI</option>
                                    </select> </td>
                                <td>Medida:</td>
                                <td><input type="text" id="txt_medida_rect_final_detalle" name="txt_medida_rect_final_detalle" /></td>
                            </tr>                    
                            <tr>
                                <td colspan="13" rowspan="5" id='margen'>
                                    <div  id = "tablaDetalle" class="grillaConf">
                                        <table id="tblDetalleComer">
                                            <thead>
                                                <tr>
                                                    <th></th>
                                                    <th>Trabajo a Realizar</th>
                                                    <th>Rectificado Previo</th>
                                                    <th>Medida Rectificado Previo</th>
                                                    <th>Cromado</th>
                                                    <th>Espesor Pedido</th>
                                                    <th>Rectificado Final</th>
                                                    <th>Medida Rectificado Final</th>
                                                </tr>
                                            </thead>				
                                            <tbody>
                                                <%
                                                    cont = 0;
                                                    ultimo = 0;

                                                    var = "select";
                                                    sp_usu = _connMy.prepareCall("{call sp_cotizaciones_det(?,?,?,?,?,?,?,?,?,?,?,?)}");
                                                    sp_usu.setString(1, var);
                                                    sp_usu.setInt(2, 0);
                                                    sp_usu.setInt(3, 0);
                                                    sp_usu.setString(4, "");
                                                    sp_usu.setString(5, "");
                                                    sp_usu.setInt(6, 0);
                                                    sp_usu.setString(7, "");
                                                    sp_usu.setDouble(8, 0.0);
                                                    sp_usu.setDouble(9, 0.0);
                                                    sp_usu.setInt(10, 0);
                                                    sp_usu.setInt(11, 0);
                                                    sp_usu.setInt(12, Integer.parseInt(corrCotiza));
                                                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                                                    sp_usu.execute();
                                                    final ResultSet rsDetalle2 = sp_usu.getResultSet();
                                                    claseGrilla = "";
                                                    while (rsDetalle.next()) {
                                                        if (cont % 2 == 0) {
                                                            claseGrilla = "alt";
                                                        }
                                                        out.println("<tr id='filaTablaDetalle" + cont + "' class='" + claseGrilla + "'>");
                                                %>                                        
                                                <td>
                                                    <a id="seleccion<%=cont%>" href="javascript: onclick=ModificaDetalleComercial(<%=cont%>)"> >></a>
                                                    <input type="hidden" value="0" id="habilitaDetCom" name="habilitaDetCom" />
                                                </td>                                                                                       
                                                <td id ="cotazacionDet_correlativo<%=cont%>"><%=rsDetalle.getString("correlativo")%></td>
                                                <td id ="cotazacionDet_codPieza<%=cont%>"><%=rsDetalle.getString("cod_pieza")%></td>
                                                <td id ="cotazacionDet_pieza<%=cont%>"><%=rsDetalle.getString("desc_pieza")%></td>
                                                <td id ="cotazacionDet_cantidad<%=cont%>"><%=rsDetalle.getString("cantidad")%></td>
                                                <td id ="cotazacionDet_valorDm<%=cont%>"><%=rsDetalle.getString("valor_dm")%></td>
                                                <td id ="cotazacionDet_diametro<%=cont%>"><%=rsDetalle.getString("diametro")%></td>
                                                <td id ="cotazacionDet_largo<%=cont%>"><%=rsDetalle.getString("largo")%></td>                                            
                                                <td id ="cotazacionDet_valUniCrom<%=cont%>"><%=rsDetalle.getString("valor_uni_crom")%></td>
                                                <td id ="cotazacionDet_totalCrom<%=cont%>"><%=rsDetalle.getString("total_cromado")%></td>
                                                <%
                                                        out.print("</tr>");
                                                        claseGrilla = "";
                                                        cont++;
                                                        ultimo = Integer.parseInt(rsDetalle.getString("numero_cotizacion"));

                                                    }
                                                %>
                                            </tbody>
                                        </table>
                                        <input type="hidden" id="ultimo" value="<%=ultimo + 1%>"></input>
                                        <input type="hidden" id="cantidad" value="<%=cont%>"></input>
                                        <input type="hidden" id="txt_correlativo" value=""></input>
                                    </div>                                               
                                </td>
                                <td id="bottom" rowspan="1">
                                    <img style="cursor: pointer" onclick="ingresaDetalleOT()" id="DetalleIngreso" class="ico" border="0" src="images/logotipos/agregar.png" 
                                         height="48px" width="25px"/>
                                </td>
                            </tr>
                            <tr>
                                <td id="bottom">
                                    <a href="#">
                                        <img id="DetalleModifica" style="display: none" onclick="modificaDetalle()" src="images/logotipos/modificar.png" border="0" 
                                             height="25px" width="25px" />
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td id="bottom">
                                    <a href="#">
                                        <img id="DetalleElimina" style="display: none" border="0" onclick="eliminaDetalle()" src="images/logotipos/eliminar.png" 
                                             height="25px" width="25px" />
                                    </a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

            </table>
        </div>            
        <input class ="botonera" type="submit" id="btn_ordentaller_grabar" name="btn_ordentaller_grabar" value="Grabar" onclick="grabarOrdenTaller()"/>
        <input class = "botonera" type="submit" name="btnCancela" value="Cancelar" onClick="goBack()" />
        <input class = "botonera" style="width: 150px" id="btn_cotizacion_aprobar" type="submit" name="btnCancela" value="Aprobar Cotizacion" onClick="aprobarCotiza()" />



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
                        //stmt = _connMy.createStatement();
                        //q="select codigo, nombre from svm_mae_pieza";
                        //rsQuery = stmt.executeQuery(q);

                        //while(rsQuery.next())
                        //{
                        //    out.println("<option value='"+rsQuery.getString("codigo")+"'>"+rsQuery.getString("nombre")+"</option>");
                        //}
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
                    <%                //stmt = _connMy.createStatement();
                        //q="SELECT concat(rut,'-',dv) rut, razon_social,replace(concat(rpad(concat(rut,'-',dv),20,' '),'|'),' ','&nbsp;') rut_pad FROM svm_mae_clientes";
                        //rsQuery = stmt.executeQuery(q);
                        //while(rsQuery.next())
                        //{
                        //    out.println("<option value='"+rsQuery.getString("rut")+"'>"+rsQuery.getString("rut_pad")+rsQuery.getString("razon_social")+"</option>");
                        //}
                    %>
                </select>
            </div>
        </div>

    </body>
</html>

<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="DAL.conexionBD"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"  xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Seleccion Actividad Comercial</title>
<link rel="icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon" />
<link rel="shortcut icon" href="images/logotipos/logo_solutel.ico" type="image/vnd.microsoft.icon"/>   
<link rel="stylesheet" type="text/css" href="css/estilo_modulo1.css"/>
<link href="css/style_tabla.css" type="text/css" rel="STYLESHEET"/>
<link href="css/solutel.css" type="text/css" rel="STYLESHEET"/>
<!--Codigo Sistemas SA-->
<link href="css/calendario.css" type="text/css" rel="stylesheet"/>
<script src="js/calendar.js" type="text/javascript"></script>
<script src="js/calendar-es.js" type="text/javascript"></script>
<script src="js/calendar-setup.js" type="text/javascript"></script>
<script src="js/FuncionTablas.js" type="text/javascript"></script>
<script src="js/CRUD_Mantenedor.js" type="text/javascript"></script>
<script src="js/validaciones.js" type="text/javascript"></script>
<!-- Librerias JQuery -->
<script src ="js/jquery-1.10.2.js" type="text/javascript "></script>
<script src="js/jquery-1.4.2.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery-2.1.3.js" type="text/javascript"></script>
<script src="js/jquery.validate.min.js" type="text/javascript"></script>
<script src="js/jquery.validate.js" type="text/javascript"></script>
<script src="js/jquery.min.js" type="text/javascript"></script>
<script src="js/messages_es.js" type="text/javascript" ></script>
<script src="js/Funcion_Errores.js" type="text/javascript" ></script>
<!--Codigo Sistemas SA-->
    <%  
        HttpSession s = request.getSession();
        int contTabla =0;
        if(s.getAttribute("nom")==null)
        {
            response.sendRedirect("login.jsp");
        }
        String tipoUser = (String)s.getAttribute("tipo");
        Connection _connMy = null;
        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
//        if(_connMy == null)
//        {
//            response.sendRedirect("login.jsp");
//        }
    %>
</head>
<body id="principal">
    <table id="header" >
        <!--barra de color -->
        <tr>
            <td colspan="2">
                <table>               
                    <tr>                                  
                        <td rowspan="2" class="espacioTablas">
                            <div class="etiqueta">
                                <center><label><b>Usuarios</b></label></center>
                            </div>
                            <div class="gridConf">
                                <table id="tblUser">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Rut</th>
                                            <th>Nombre Usuario</th>
                                            <th>Contraseña</th>
                                            <th>Tipo</th>
                                            <th>Tipo Negocio</th>
                                            <th>Supervisor</th>                                            
                                        </tr>
                                    </thead>                                                                      
                                    <tbody>                                           
                                        <%
                                            String var = "consulta_N";
                                            try{
                                                int cont =0;
                                                CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_usuarios(?,'','','','','','')}");
                                                sp_usu.setString(1,var);
                                                sp_usu.execute();
                                                final ResultSet rs = sp_usu.getResultSet();
                                                String cla = "";
                                                while(rs.next())
                                                {
                                                    if(cont % 2 == 0)
                                                    {                                                        
                                                        cla = "alt";
                                                    }
                                                    out.println("<tr id='filaUsr"+cont+"' class='"+cla+"'>");
                                                    %>                                                                           
                                                    <td>
                                                        <a id="datoUsr" href="javascript: onclick=habilitaModUsr(<%=cont%>)"> >></a>
                                                        <input type="hidden" id="habilitaUsr" value="0" />
                                                    </td>

                                                    <td id="usr_rutUsr<%=cont%>"><%= rs.getString("rut")%></td>
                                                    <td id="usr_nomUsr<%=cont%>"><%= rs.getString("nombre_user")%></td>
                                                    <td id="usr_pass<%=cont%>"><%= rs.getString("password")%></td>
                                                    <td id="usr_tipo<%=cont%>"><%= rs.getString("tipo")%></td>
                                                    <td id="usr_tipoNeg<%=cont%>"><%= rs.getString("tipo_negocio")%></td>
                                                    <td id="usr_supervisor<%=cont%>"><%= rs.getString("supervisor")%></td>
                                                    <%
                                                    out.println("</tr>");                                   
                                                    cont ++;
                                                    cla = "";
                                                }
                                            }catch(Exception e){
                                                e.printStackTrace();
                                                System.out.println("error");
                                            }
                                        %>  
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <form id="frm_usr" name="frm_usr" action="" method="post">
                                <table>
                                    <tr>
                                        <td class="letra">Rut:</td>
                                        <td class="letra">
                                        <input id="txt_usr_rut" name="txt_usr_rut"  maxlength="11" type="text" name="nom" />
                                        <div > </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Nombre Usuario:</td>
                                        <td class="letra">
                                            <input class="nombre" id="txt_usr_nom" name="txt_usr_nom" maxlength="40" type="text" name="usu" />                                        
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Tipo:</td>
                                        <td class="letra">
                                            <select id="slt_usr_tipo" name="slt_usr_tipo">
                                                <option value="">--Selecione--</option>
                                                <%
                                                    String CargaTpo;
                                                    CallableStatement sp_CargaCombo_Tipo;
                                                    try{
                                                        CargaTpo = "Tipo Usuario";
                                                        sp_CargaCombo_Tipo = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                        sp_CargaCombo_Tipo.setString(1,CargaTpo);
                                                        sp_CargaCombo_Tipo.execute();
                                                        final ResultSet CargarTipo = sp_CargaCombo_Tipo.getResultSet();                                                   
                                                        while(CargarTipo.next())
                                                        {             
                                                            %>
                                                            <option value="<%=CargarTipo.getString("descripcion")%>"><%=CargarTipo.getString("descripcion")%></option>
                                                            <%                                                       
                                                        }
                                                    }catch(Exception e){
                                                        e.printStackTrace();
                                                        System.out.println("error");
                                                    }
                                                %>
                                                </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Tipo Negocio:</td>
                                        <td class="letra">
                                            <select id="slt_usr_tipoNegocio" name="slt_usr_tipoNegocio">
                                                <option value="">--Selecione--</option>
                                                <%
                                                    try{
                                                        CargaTpo = "Tipo Negocio";
                                                        sp_CargaCombo_Tipo = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                        sp_CargaCombo_Tipo.setString(1,CargaTpo);
                                                        sp_CargaCombo_Tipo.execute();
                                                        final ResultSet CargarTipoNegocio = sp_CargaCombo_Tipo.getResultSet();                                                   
                                                        while(CargarTipoNegocio.next())
                                                        {             
                                                            %>
                                                            <option value="<%=CargarTipoNegocio.getString("descripcion")%>"><%=CargarTipoNegocio.getString("descripcion")%></option>
                                                            <%                                                       
                                                        }
                                                    }catch(Exception e){
                                                        e.printStackTrace();
                                                        System.out.println("error");
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Supervisor:</td>
                                        <td class="letra">
                                            <select id="slt_usr_supervisor" name="slt_usr_supervisor">
                                                <option value="">--Selecione--</option>
                                                <%
                                                    try{
                                                        Statement stmt = null;
                                                        ResultSet rsStmt = null;
                                                        stmt = _connMy.createStatement();
                                                        rsStmt = stmt.executeQuery("SELECT rut,nombre_user FROM svm_mae_usuarios where tipo = 'Supervisor'");                                                                                         
                                                        while(rsStmt.next())
                                                        {             
                                                            %>
                                                            <option value="<%=rsStmt.getString("rut")%>"><%=rsStmt.getString("nombre_user")%></option>
                                                            <%
                                                        }
                                                    }catch(Exception e){
                                                        e.printStackTrace();
                                                        System.out.println("error");
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                        <tr>
                                        <td class="letra">Contraseña</td>
                                        <td class="letra">
                                            <input id="txt_usr_pass" type="password" maxlength="10" name="txt_usr_pass" />
                                        </td>
                                    </tr>
                                </table>
                                <input class ="botonera" onclick="Usuarios('ingreso')" id="btn_usr_ing" name='ing' type="button" value="Insertar" />
                                <input class ="botonera" onclick="Usuarios('modifica')" style="display: none" name='mod' id="btn_usr_mod" type="button" value="Modificar" />
                                <input class ="botonera" onclick="FuncionUsuarios('elimina')" style="display: none" name='eli' id="btn_usr_eli" type="button" value="Eliminar" />                   
<!--                                <input class ="botonera" onclick="cancelarUsr()" style="display: none" id="btn_usr_can" type="button" value="Desmarcar" />                                -->
                            </form>         
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5"><hr /></td>
                    </tr>
                    <tr>
                        <td  rowspan="2"  class="espacioTablas">
                            <div class="etiqueta">
                                <center><label><b>Maestro Tablas</b></label></center>
                            </div>   
                            <div class="gridConf">
                                <table id ="tblMaeTabla">
                                    <thead>
                                        <tr>
                                            <th></th>                                            
                                            <th>Tabla</th>
                                            <th>Relación 1</th>
                                            <th>Relación 2</th>
                                            <th>Descripción</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try{
                                                CallableStatement sp_Tabla = _connMy.prepareCall("{call sp_mae_tablas(?,0,'','','','')}");
                                                sp_Tabla.setString(1,var);
                                                sp_Tabla.execute();
                                                final ResultSet rsTabla = sp_Tabla.getResultSet();
                                                String claTabla = "";
                                                contTabla=0;
                                                while(rsTabla.next())
                                                {
                                                    if(contTabla % 2 == 0)
                                                    {                                                    
                                                        claTabla = "alt";
                                                    }else
                                                    {  
                                                        claTabla = "";                                                    
                                                    }
                                                    out.println("<tr id='filaTabla"+contTabla+"' class='"+claTabla+"'>");
                                                    %>
                                                    <td> 
                                                        <a id="datoUsr" href="javascript: onclick=habilitaModTabla(<%=contTabla%>)"> >></a>
                                                        <input type="hidden" id="habilitaTabla" value="0" />
                                                    </td>
                                                    <input type="hidden" id="tabla_Id<%=contTabla%>" value="<%= rsTabla.getString("id")%>"/>
                                                    <td id="tabla_TablaMae<%=contTabla%>"><%= rsTabla.getString("tablas")%></td>
                                                    <td id="tabla_Relacion1<%=contTabla%>"><%= rsTabla.getString("relacion1")%></td>
                                                    <td id="tabla_Relacion2<%=contTabla%>"><%= rsTabla.getString("relacion2")%></td>
                                                    <td id="tabla_descripcion<%=contTabla%>"><%= rsTabla.getString("descripcion")%></td>
                                                    <%
                                                    out.println("</tr>");                                   
                                                    contTabla ++;
                                                }
                                            }catch(Exception e){
                                                e.printStackTrace();
                                                System.out.println("error");
                                            }
                                        %>                                       
                                    </tbody>
                                </table>             
                            </div>                        
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <form name="frmTablas" id="frmTablas" action="" method="post">
                                <table colspan="4">
                                    <tr>                                        
                                        <td class="letra">Tablas:</td>
                                        <input type="hidden" id="hid_tabla_id" name="hid_tabla_id" value="0"/>
                                        <td class="letra">
                                            <%
                                                CallableStatement sp_Carga;
                                                String CargaTabla;
                                            %>
                                            <select id="slt_tabla_mae" name="slt_tabla_mae">
                                                <option value="">--Selecione--</option>
                                                <%
                                                    try{
                                                        CargaTabla = "maeTabla";                                                    
                                                        sp_Carga = _connMy.prepareCall("{call sp_ConsultaMaeTabla(?)}");
                                                        sp_Carga.setString(1,CargaTabla);
                                                        sp_Carga.execute();
                                                        final ResultSet CargarMaeTabla = sp_Carga.getResultSet();                                                   
                                                        while(CargarMaeTabla.next())
                                                        {             
                                                            %>
                                                            <option value="<%=CargarMaeTabla.getString("tablas")%>"><%=CargarMaeTabla.getString("tablas")%></option>
                                                            <%                                                       
                                                        }
                                                    }catch(Exception e){
                                                        e.printStackTrace();
                                                        System.out.println("Error");
                                                    }
                                                %>
                                            </select>
                                        </td>
                                            
                                        <td class="letra">
                                            <input class="contacto" type="text" id="txt_tabla_mae" name="txt_tabla_mae" maxlength="20" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Relación 1:</td>
                                        <td class="letra">
                                            <select id="slt_tabla_rel1" name="slt_tabla_rel1">                                
                                                <option value="">--Selecione--</option>
                                                <%
                                                    try{
                                                        CargaTabla ="rel1";
                                                        sp_Carga = _connMy.prepareCall("{call sp_ConsultaMaeTabla(?)}");
                                                        sp_Carga.setString(1,CargaTabla);
                                                        sp_Carga.execute();
                                                        final ResultSet CargarRel1 = sp_Carga.getResultSet();
                                                        while(CargarRel1.next())
                                                        {
                                                            if(!CargarRel1.getString("relacion1").equals(""))
                                                            {          
                                                                %>
                                                                <option value="<%=CargarRel1.getString("relacion1")%>"><%=CargarRel1.getString("relacion1")%></option>
                                                                <%
                                                            }
                                                        }
                                                    }catch(Exception e){
                                                        e.printStackTrace();
                                                        System.out.println("error");
                                                    }
                                                    %>
                                            </select>
                                        </td>
                                        <td class="letra">
                                            <input class="contacto" type="text" id="txt_tabla_rel1" name="txt_tabla_rel1" maxlength="20"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Relación 2:</td>
                                        <td class="letra" >
                                            <select id="slt_tabla_rel2" name="slt_tabla_rel2">
                                                <option value="">--Selecione--</option>
                                                <%
                                                    try{
                                                        CargaTabla ="rel2";
                                                        sp_Carga = _connMy.prepareCall("{call sp_ConsultaMaeTabla(?)}");
                                                        sp_Carga.setString(1,CargaTabla);
                                                        sp_Carga.execute();
                                                        final ResultSet CargarRel2 = sp_Carga.getResultSet();
                                                        while(CargarRel2.next())
                                                        { 
                                                            if(!CargarRel2.getString("relacion2").equals(""))
                                                            {                                                       
                                                                %>
                                                                <option value="<%=CargarRel2.getString("relacion2")%>"><%=CargarRel2.getString("relacion2")%></option>
                                                                <%
                                                            }
                                                        }
                                                    }catch(Exception e){
                                                        e.printStackTrace();
                                                        System.out.println("error");
                                                    }
                                                    %>
                                            </select>
                                        </td>
                                        <td class="letra">
                                            <input class="contacto" type="text" id="txt_tabla_rel2" name="txt_tabla_rel2" maxlength="20"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Descripción:</td>
                                        <td class="letra" colspan="2">
                                            <input class ="nombre" type="text" id="txt_tabla_descripcion" name="txt_tabla_descripcion" maxlength="40"/>
                                        </td>
                                    </tr>
                                </table>
                                <input class ="botonera" id="btn_tabla_ing" onclick="MaeTablas('ingreso');" name='ing' type="button" value="Insertar" />
                                <input class ="botonera" style="display: none" onclick="MaeTablas('modifica');" name='mod' id="btn_tabla_mod" type="button" value="Modificar" />
                                <input class ="botonera" style="display: none" onclick="FuncionMaeTabla('elimina');" name='eli' id="btn_tabla_eli" type="button" value="Eliminar" />                   
<!--                                <input class ="botonera" style="display: none" onclick="cancelarTabla()"  id="btn_tabla_can" type="button" value="Desmarcar" />                                       -->
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5"><hr /></td>
                    </tr>
                    <tr>
                        <td class="espacioTablas" rowspan="2">
                            <div class="etiqueta">
                                <center><label><b>Work Flow</b></label></center>
                            </div>
                            <div class="gridConf">
                                <table id="tblWork">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Estado Actual</th>
                                            <th>Estado Siguiente</th>
                                            <th>Rut Usuario</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                       <%
                                            int contWork =0;
                                            try{
                                                CallableStatement sp_Work = _connMy.prepareCall("{call sp_mae_workflow(?,0,'','','')}");
                                                sp_Work.setString(1,var);
                                                sp_Work.execute();
                                                final ResultSet rsWork = sp_Work.getResultSet();
                                                String claseWork ="";
                                                while(rsWork.next())
                                                {
                                                    if(contWork % 2 == 0)
                                                    {
                                                        claseWork = "alt";
                                                    }else
                                                    {  
                                                        claseWork = "";
                                                    }
                                                    out.println("<tr id='filaWork"+contWork+"' class='"+claseWork+"'>");
                                                    %> 
                                                    <td>
                                                        <a id="datoWork" href="javascript: onclick=habilitaModWork(<%=contWork%>)"> >></a>
                                                        <input type="hidden" id="habilitaWork" value="0" />
                                                    </td>
                                                    <input type="hidden" id="work_id<%=contWork%>" value="<%=rsWork.getString("id")%>"/>
            <!--                                         //<td id="work_Id<%--contWork%>"><%= rsWork.getString("id")--%></td>-->
                                                    <td id="work_estAct<%=contWork%>"><%=rsWork.getString("estado_actual")%></td>
                                                    <td id="work_estSig<%=contWork%>"><%=rsWork.getString("estado_siguiente")%></td>
                                                    <td id="work_usr<%=contWork%>"><%=rsWork.getString("rut_usr")%></td>
                                                    <%
                                                    out.println("</tr>");
                                                    contWork++;
                                                }
                                            }catch(Exception e){
                                                e.printStackTrace();
                                                System.out.println("error");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>                                           
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <form id="frmWork" name="frmWork" action="" method="post">
                                <table >
                                    <input type="hidden" id="hid_work_id" name="hid_work_id" value="0"/>
                                    <tr>
                                        <td class="letra">Estado Actual:</td>
                                         
                                        <td  class="letra">
                                            <select name="slt_work_estAct" id="slt_work_estAct">
                                                <option value="">--Seleccione--</option>
                                                <%
                                                    try{
                                                        String varCargaEstado = "Estado_ActCom";
                                                        CallableStatement sp_Carga_Estado = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                        sp_Carga_Estado.setString(1,varCargaEstado);
                                                        sp_Carga_Estado.execute();
                                                        final ResultSet CargarEstado = sp_Carga_Estado.getResultSet();                                                   
                                                        while(CargarEstado.next())
                                                        {             
                                                            %>
                                                            <option value="<%=CargarEstado.getString("descripcion")%>"><%=CargarEstado.getString("descripcion")%></option>
                                                            <%                                                       
                                                        }
                                                    }catch(Exception e){
                                                        e.printStackTrace();
                                                        System.out.println("error");
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                <tr>
                                    <td class="letra" >Estado Siguiente:</td>
                                    <td class="letra">
                                        <select name="slt_work_estSig" id="slt_work_estSig">
                                        <option value="">--Seleccione--</option>
                                        <%
                                            try{
                                                String carga_Estado = "Estado_ActCom";
                                                CallableStatement sp_Carga_Siguiente = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                sp_Carga_Siguiente.setString(1,carga_Estado);
                                                sp_Carga_Siguiente.execute();
                                                final ResultSet CargarSiguiente = sp_Carga_Siguiente.getResultSet();                                                   
                                                while(CargarSiguiente.next())
                                                {             
                                                    %>
                                                    <option value="<%=CargarSiguiente.getString("descripcion")%>"><%=CargarSiguiente.getString("descripcion")%></option>
                                                    <%                                                       
                                                }
                                            }catch(Exception e){
                                                e.printStackTrace();
                                                System.out.println("error");
                                            }
                                        %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="letra">Rut:</td>
                                    <td class="letra">
                                        <input type="text" maxlength="11" name="txt_work_rut" id="txt_work_rut" />
                                    </td>
                                </tr>                         
                                </table>
                                <input class ="botonera" id="btn_work_ing" onclick="WorkFlow('ingreso')" name='ing' type="button" value="Insertar" />
                                <input class ="botonera" style="display: none" onclick="WorkFlow('modifica')" name='mod' id="btn_work_mod" type="button" value="Modificar" />
                                <input class ="botonera" style="display: none" onclick="FuncionWorkFlow('elimina')" name='eli' id="btn_work_eli" type="button" value="Eliminar" />                 
<!--                                <input class ="botonera" onclick="cancelarWork()" style="display: none" id="btn_work_can" type="button" value="Desmarcar" />-->
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5"><hr /></td>
                    </tr>
                    <tr>
                        <td rowspan="2" class="espacioTablas">
                            <div class="etiqueta">
                                <center><label><b>Notificaciones</b></label></center>
                            </div>    
                            <div class="gridConf">
                                <table id="tblNot">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Estado</th>
                                            <th>Usuario</th>
                                            <th>E-Mail</th>
                                        </tr>
                                    </thead>       
                                    <tbody>
                                        <%                                                            
                                            int contNot =0;
                                            try{
                                                CallableStatement sp_Not = _connMy.prepareCall("{call sp_mae_notificaciones(?,'','','')}");
                                                sp_Not.setString(1,var);
                                                sp_Not.execute();
                                                final ResultSet rsNot = sp_Not.getResultSet();
                                                String claNot = "";
                                                while(rsNot.next())
                                                {
                                                    if(contNot % 2 == 0)
                                                    {
                                                        claNot = "alt";
                                                    }else
                                                    {  
                                                        claNot = "";
                                                    }
                                                    out.println("<tr id='filaNot"+contNot+"' class='"+claNot+"'>");
                                                    %>    
                                                    <td>
                                                        <a id="datoNot" href="javascript: onclick=habilitaModNot(<%=contNot%>)"> >></a>
                                                        <input type="hidden" id="habilitaNot" value="0" />
                                                    </td>
                                                    <td id='not_est<%=contNot%>'><%=rsNot.getString("estado")%></td>
                                                    <td id='not_Usr<%=contNot%>'><%=rsNot.getString("nombre_usr")%></td>
                                                    <td id='not_email<%=contNot%>'><%=rsNot.getString("email")%></td>
                                                    <%
                                                    out.println("</tr>");
                                                    contNot++;
                                                }
                                            }catch(Exception e){
                                                e.printStackTrace();
                                                System.out.println("error");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <form id="frmNot" name="frmNot" action="" method="post">
                                <table>
                                    <tr>
                                        <td class="letra">Estado:</td>
                                        <td class="letra">
                                            <select id ='slt_not_est' name="slt_not_est">
                                                <option value="">--Seleccione--</option>
                                                <%
                                                    try{
                                                        String cargaEstado_Notificacion = "Estado_Notificacion";
                                                        CallableStatement sp_CargaEstado_Notificacion = _connMy.prepareCall("{call sp_CargaCombo(?,'','')}");
                                                        sp_CargaEstado_Notificacion.setString(1,cargaEstado_Notificacion);
                                                        sp_CargaEstado_Notificacion.execute();
                                                        final ResultSet CargarEstadoNotificacion = sp_CargaEstado_Notificacion.getResultSet();                                                   
                                                        while(CargarEstadoNotificacion.next())
                                                        {             
                                                            %>
                                                            <option value="<%=CargarEstadoNotificacion.getString("descripcion")%>"><%=CargarEstadoNotificacion.getString("descripcion")%></option>
                                                            <%                                                       
                                                        }
                                                    }catch(Exception e){
                                                        e.printStackTrace();
                                                        System.out.println("error");
                                                    }
                                                %>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Usuario:</td>
                                        <td class="letra">
                                            <input class="nombre"type="text" maxlength="40" id='txt_not_usr' name="txt_not_usr"  />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">E-Mail:</td>
                                        <td class="letra">
                                            <input class="nombre" type="text" maxlength="40" id='txt_not_email' name="txt_not_email" />
                                        </td>
                                    </tr>                                   
                                </table>
                                <input class ="botonera" id="btn_not_ing" onclick="Notificaciones('ingreso')" name='ing' type="button" value="Insertar" />
                                <input class ="botonera" style="display: none" onclick="Notificaciones('modifica')" name='mod' id="btn_not_mod" type="button" value="Modificar" />
                                <input class ="botonera" style="display: none" onclick="FuncionNotificaciones('elimina')" name='eli' id="btn_not_eli" type="button" value="Eliminar" />                   
<!--                                <input class ="botonera" onclick="cancelarNot()" style="display: none" id="btn_not_can" type="button" value="Desmarcar" />                                      -->
                            </form>
                        </td>                                    
                    </tr>
                    <tr>
                        <td colspan="5"><hr /></td>
                    </tr>
                    <tr>
                        <td rowspan="2"  class="espacioTablas">
                            <div class="etiqueta">
                                <center><label><b>Publicaciones de Escritorio</b></label></center>
                            </div>
                            <div class="gridConf">
                                <table id="tblEsc">
                                    <thead>
                                        <tr>
                                            <th></th>
                                            <th>Autor</th>
                                            <th>Fecha</th>
                                            <th>Titulo</th>
                                            <th>Noticia</th>
                                            <th>Vigencia</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            try{
                                                int contEsc =0;
                                                String varEsc = "consulta_N";
                                                Date sqlDate= new Date(11/2/2015);
                                                CallableStatement sp_Esc = _connMy.prepareCall("{call sp_mae_escritorio(?,?,'','','','')}");
                                                sp_Esc.setString(1,varEsc);
                                                sp_Esc.setDate(2,sqlDate);
                                                sp_Esc.execute();
                                                final ResultSet rsEsc = sp_Esc.getResultSet();
                                                String claEsc = "";
                                                while(rsEsc.next())
                                                {
                                                    if(contEsc % 2 == 0)
                                                    {
                                                        claEsc = "alt";
                                                    }else
                                                    {  
                                                        claEsc = "";
                                                    }
                                                    out.println("<tr id='filaEsc"+contEsc+"' class='"+claEsc+"'>");
                                                    %> 
                                                    <td>
                                                        <a id="datoNot" href="javascript: onclick=habilitaModEsc(<%=contEsc%>)"> >></a>
                                                        <input type="hidden" id="habilitaEsc" value="0" />
                                                    </td>
                                                    <td id="esc_autor<%=contEsc%>"><%=rsEsc.getString("autor")%></td>
                                                    <td id="esc_fecha<%=contEsc%>"><%=rsEsc.getString("fecha")%></td>
                                                    <td id="esc_titulo<%=contEsc%>"><%=rsEsc.getString("titulo")%></td>
                                                    <td id="esc_noticia<%=contEsc%>"><%=rsEsc.getString("noticia")%></td>
                                                    <td id="esc_vigencia<%=contEsc%>"><%=rsEsc.getString("vigencia")%></td>
                                                    <%
                                                    out.println("</tr>");
                                                    contEsc++;
                                                }
                                            }catch(Exception e){
                                                e.printStackTrace();
                                                System.out.println("error");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>                                              
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <form id="frmEsc" name="frmEsc" action="" method="post">
                                <table>
                                    <tr>
                                        <td class="letra">Autor:</td>
                                        <td class="letra">
                                            <input class="nombre" type="text" maxlength="40" id="txt_esc_autor" name="txt_esc_autor" />
                                        </td>                                                                                
                                    </tr>
                                    <tr>
                                        <td  class="letra">Vigencia:</td>
                                        <td><input id="ckbox_esc_vig" name="ckbox_esc_vig" type="checkbox" checked /></td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Fecha:</td>
                                        <td class="letra">
                                            
                                            <input type = "text" readonly name="txt_esc_fecha" id= "txt_esc_fecha" size="12" />                                                           
                                            <!-- script que define y configura el calendario--> 
                                            <img src="images/calendario.png" width="18" height="18" border="0" align="center" title="Fecha Inicial" id="lanzador" />
                                            <script type="text/javascript"> 
                                                Calendar.setup({ 
                                                inputField     :    "txt_esc_fecha",     // id del campo de texto 
                                                ifFormat     :     "%Y-%m-%d",     // formato de la fecha que se escriba en el campo de texto 
                                                button     :    "lanzador"     // el id del botón que lanzará el calendario 
                                                }); 
                                            </script> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Título Publicación:</td>
                                        <td class="letra">
                                            <input type="text" maxlength="30" style="width:230px" name="txt_esc_titulo" id="txt_esc_titulo" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Contenido Publicación:</td>
                                        <td class="letra">
                                            <textarea class="descripcion" id="txa_esc_cont" name="txa_esc_cont" rows="4" cols="16"></textarea>
                                        </td>
                                    </tr>                                 
                                </table>
                                <input class ="botonera" id="btn_esc_ing" onclick="Escritorio('ingreso')" name='ing' type="button" value="Insertar" />
                                <input class ="botonera" style="display: none" onclick="Escritorio('modifica')" name='mod' id="btn_esc_mod" type="button" value="Modificar" />
                                <input class ="botonera" style="display: none" name='eli' onclick="FuncionEscritorio('elimina')" id="btn_esc_eli" type="button" value="Eliminar" />                   
<!--                                <input class ="botonera" onclick="cancelarEsc()" style="display: none" id="btn_esc_can" type="button" value="Desmarcar" />-->                                        
                            </form>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5"><hr /></td>
                    </tr>
                    <tr>
                        <td rowspan="2"  class="espacioTablas">
                            <div class="etiqueta">
                                <center><label><b>Errores</b></label></center>
                            </div>
                            <div class="gridConf">
                                <table id="tblErr">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>ID</th>
                                        <th>Tipo</th>
                                        <th>Descripción</th>
                                    </tr>
                                </thead>
                                    <tbody>
                                        <%
                                            try{
                                                int contErr =0;
                                                CallableStatement sp_Err = _connMy.prepareCall("{call sp_mae_errores(?,'100','','')}");
                                                sp_Err.setString(1,var);
                                                sp_Err.execute();
                                                final ResultSet rsErr = sp_Err.getResultSet();
                                                String claErr = "" ;
                                                while(rsErr.next())
                                                {
                                                    if(contErr % 2 == 0)
                                                    {
                                                        claErr = "alt";
                                                    }else
                                                    {  
                                                        claErr = "";
                                                    }
                                                    out.println("<tr id='filaErr"+contErr+"' class='"+claErr+"'>");
                                                    %> 
                                                    <td>
                                                        <a id="datoErr" href="javascript: onclick=habilitaModErr(<%=contErr%>)"> >></a>
                                                        <input type="hidden" id="habilitaErr" value="0" />
                                                    </td>
                                                    <td id="err_id<%=contErr%>"><%=rsErr.getString("id")%></td>
                                                    <td id="err_tipo<%=contErr%>"><%=rsErr.getString("tipo_error")%></td>
                                                    <td id="err_descripcion<%=contErr%>"><%=rsErr.getString("descripcion")%></td>
                                                    <%
                                                    out.println("</tr>");
                                                    contErr++;
                                                }
                                            }catch(Exception e){
                                                e.printStackTrace();
                                                System.out.println("error");
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>                                              
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <form id="frmEsc" name="frmErr" action="" method="post">
                                <table>
                                <tr>
                                    <td class="letra">ID:</td>
                                        <td class="letra">
                                            <input type="text" id="txt_err_id" name="txt_err_id" />
                                        </td> 
                                    </tr>
                                    <tr>
                                        <td class="letra">Tipo de Error:</td>
                                        <td class="letra">
                                            <input class="contacto" type = "text" name="txt_err_tipo" maxlength="20" id= "txt_err_tipo" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="letra">Descripción:</td>
                                        <td class="letra">
                                            <textarea class="descripcion"id="txa_err_descripcion" name="txa_err_descripcion" rows="4" cols="17" maxlength="100" ></textarea>
                                        </td>
                                    </tr>                                   
                                </table>
                                <input class ="botonera" id="btn_err_ing" onClick="Error('ingreso')" name='ing' type="button" value="Insertar" />
                                <input class ="botonera" style="display: none" onClick="Error('modifica')" name='mod' id="btn_err_mod" type="button" value="Modificar" />
                                <input class ="botonera" style="display: none" onClick="FuncionError('elimina')" name='eli' id="btn_err_eli" type="button" value="Eliminar" />                   
<!--                                <input class ="botonera" onclick="cancelarErr()" style="display: none" id="btn_err_can" type="button" value="Desmarcar" />                                       -->
                            </form>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>                            
    </table>
</body>
</html>

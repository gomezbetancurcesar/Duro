/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DAL.conexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Blas MuÃ±oz
 */
@WebServlet(name = "ServletFacturaGDtmp", urlPatterns = {"/ServletFacturaGDtmp"})
public class ServletFacturaGDtmp extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession s = request.getSession();
            Connection _connMy = null;             
            String flag = "";
            flag = request.getParameter("flag");
            String var, cliente, nombcliente, ejecutivo, formapago, excenta, adicional, comentario = "";
            int guia, fact = 0;
            String nroGuia = "";
            String nroGuias = "";
            String fechaEmision = "";
            String total = "";
            String nroOT = "";
            String retTbl = "";
            int secuencia = 0;
            if(flag.equals("cargaCliente"))
            {
                var = "SELECT_USER";
                cliente = request.getParameter("cliente");
                try {                
                    ResultSet rs = null;
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));                                        
                    CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1,var);
                    sp_usu.setInt(2,0);
                    sp_usu.setString(3,"");
                    sp_usu.setString(4,cliente);
                    sp_usu.setString(5,"");
                    sp_usu.setString(6,"");
                    sp_usu.setString(7,"");
                    sp_usu.setString(8,"");
                    sp_usu.setString(9,"");                               
                    sp_usu.setInt(10,0);     
                    sp_usu.setInt(11,0);
                    sp_usu.execute();

                    rs = sp_usu.getResultSet();                                                    
                    while(rs.next())
                    {
                        nroGuia=rs.getString("numero_guia");
                        fechaEmision=rs.getString("fecha_emision");
                        total=rs.getString("total");
                        nroOT= rs.getString("numero_ordentaller");
                        retTbl += "<option value='"+nroGuia+"'>";
                        retTbl += conexionBD.agregaCaracter(nroGuia);
                        retTbl += conexionBD.agregaCaracter(fechaEmision);
                        retTbl += nroOT;
                        retTbl += "</option>";

                    }
                    out.print(retTbl);
                } catch (Exception e) {
                    System.out.println("Error:"+e.getMessage());
                }
            }else if(flag.equals("cargaTMPGD")) {
                    var = "SELECT_GD";
                    guia = Integer.parseInt(request.getParameter("nroGuia"));
                    secuencia = Integer.parseInt(request.getParameter("secuencia"));
                    
                    System.out.println("Nro Guia: "+guia);
                    System.out.println("Secuencia: "+secuencia);
                    
                    try {
                        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                        CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                        sp_usu.setString(1,var);
                        sp_usu.setInt(2,0);
                        sp_usu.setString(3,"");
                        sp_usu.setString(4,"");
                        sp_usu.setString(5,"");
                        sp_usu.setString(6,"");
                        sp_usu.setString(7,"");
                        sp_usu.setString(8,"");
                        sp_usu.setString(9,"");                               
                        sp_usu.setInt(10,guia);
                        sp_usu.setInt(11,secuencia);
                        sp_usu.execute();

                        final ResultSet rs = sp_usu.getResultSet();
                        String cla = "";
                        while(rs.next())
                        {
                            nroGuia=rs.getString("numero_guia");
                            fechaEmision=rs.getString("fecha_emision");
                            total=rs.getString("total");
                            System.out.println("Nro Guia: "+nroGuia);
                            System.out.println("Fecha: "+fechaEmision);
                            System.out.println("Total: "+total);
                            
                            retTbl = "<tr id='filaGD"+nroGuia+"'><td><a href=\"javascript: onclick=SeleccionGD("+nroGuia+")\"> >> </a>";
                            retTbl += "<input type='hidden' id='hid"+nroGuia+"' value='"+nroGuia+"'></td>";
                            retTbl += "<td>"+nroGuia+"</td>";
                            retTbl += "<td>"+fechaEmision+"</td>";
                            retTbl += "<td>"+total+"</td></tr>";
                        }
                        out.print(retTbl);
                    } catch (Exception e) {
                        System.out.println("Error: "+e.getMessage());
                    }
            } else if(flag.equals("cargaDetalleFactura")) {
                        var = "SELECT_DETALLEGD";
                        guia = Integer.parseInt(request.getParameter("nroGuia"));
                        String vUnitario = "";
                        String nom = "";
                        String cant = "";
                        try {
                            _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                            CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                            sp_usu.setString(1,var);
                            sp_usu.setInt(2,0);
                            sp_usu.setString(3,"");
                            sp_usu.setString(4,"");
                            sp_usu.setString(5,"");
                            sp_usu.setString(6,"");
                            sp_usu.setString(7,"");
                            sp_usu.setString(8,"");
                            sp_usu.setString(9,"");                               
                            sp_usu.setInt(10,guia);
                            sp_usu.setInt(11,0);
                            sp_usu.execute();

                            final ResultSet rs = sp_usu.getResultSet();
                            int cont = 0;
                            while(rs.next())
                            {
                                cont ++;
                                nroGuia=rs.getString("numero_guia");
                                nom=rs.getString("nombre");
                                vUnitario=rs.getString("valor_unitario");
                                cant= rs.getString("cantidad");
                                total= rs.getString("total_item");
                                retTbl += "<tr class='filaDetalle"+nroGuia+"' id='"+nroGuia+"'>";
                                retTbl += "<td>"+nroGuia+"</td>";
                                retTbl += "<td>"+nom+"</td>";
                                retTbl += "<td>"+vUnitario+"</td>";
                                retTbl += "<td>"+cant+"</td>";
                                retTbl += "<td>"+total+"</td>";                                  
                                retTbl += "</tr>";
                                
                            }                    
                            //retTbl += "<input type='hidden' id='contadorDetalle"+nroGuia+"' value='"+cont+"' ";  
                            out.print(retTbl);
                        } catch (Exception e) {
                            System.out.println("Error: "+e.getMessage());
                        }
            } else if(flag.equals("cambioEnFactura")) {
                        try {         
                        _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                        nroGuia = request.getParameter("nroGuia");                            
                        PreparedStatement stmt = _connMy.prepareStatement("UPDATE svm_guiadespacho_cab SET enFactura = '0' WHERE numero_guia = ?");
                        stmt.setString(1,nroGuia);
                        stmt.executeUpdate();
                        } catch (Exception e) {
                            System.out.println("Error UPDATE: "+e.getMessage());
                        }  
            } else if(flag.equals("guiasNofactI")) {
                cliente = request.getParameter("cliente");
                secuencia = Integer.parseInt(request.getParameter("secuencia"));
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    Statement stmt = _connMy.createStatement();
                    String q="select DISTINCT head.numero_guia AS numero_guia, " +
                                " DATE_FORMAT(head.fecha_emision,'%d-%m-%Y') AS fecha_emision " +
                                " FROM svm_guiadespacho_cab head INNER JOIN svm_mae_clientes cli " +
                                " ON head.rut_cliente=cli.rut " +
                                " INNER JOIN svm_guiadespacho_det GDDET " +
                                " ON head.numero_guia = GDDET.numero_guia " +
                                " WHERE head.facturado = 0 and " +
                                " head.rut_cliente = '"+cliente+"' " +
                                " AND head.numero_guia NOT IN (select nro_guia_desp from svm_factura_det_tmp where secuencia = "+secuencia+") ";
                    if(request.getParameter("guia") != null && !request.getParameter("guia").trim().isEmpty()){
                        guia = Integer.parseInt(request.getParameter("guia"));
                        q += " AND head.numero_guia LIKE ('%"+guia+"%') ";
                    }

                    ResultSet rsQuery = stmt.executeQuery(q);

                    while(rsQuery.next())
                    {
                        nroGuia=rsQuery.getString("numero_guia");
                        retTbl += "<tr>";
                        retTbl += "<td><input type='checkbox' name='"+nroGuia+"' class='checkboxguias'/></td>";
                        retTbl += "<td>"+nroGuia+"</td>";
                        retTbl += "<td>"+rsQuery.getString("fecha_emision")+"</td>";
                        retTbl += "</tr>";
                    }
                    out.print(retTbl);
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            } else if(flag.equals("guiasNofact")) {
                cliente = request.getParameter("cliente");
                secuencia = Integer.parseInt(request.getParameter("secuencia"));
                fact = Integer.parseInt(request.getParameter("nroFact"));
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    Statement stmt = _connMy.createStatement();
                    String q="select DISTINCT head.numero_guia as numero_guia, " +
                                " DATE_FORMAT(head.fecha_emision,'%d-%m-%Y') as fecha_emision " +
                                " from svm_guiadespacho_cab head inner join svm_mae_clientes cli " +
                                " on head.rut_cliente=cli.rut " +
                                " INNER JOIN svm_guiadespacho_det GDDET " +
                                " ON head.numero_guia = GDDET.numero_guia " +
                                " where head.facturado = 0 and " +
                                " head.rut_cliente = '"+cliente+"' " +
                                " and head.numero_guia not in (select nro_guia_desp from svm_factura_det_tmp where secuencia = "+secuencia+") ";
                    if(request.getParameter("guia") != null && !request.getParameter("guia").trim().isEmpty()){
                        guia = Integer.parseInt(request.getParameter("guia"));
                        q += " AND head.numero_guia LIKE ('%"+guia+"%') ";
                    }
                    
                    q += "union all " +
                            " select DISTINCT head.numero_guia as numero_guia, " +
                            " DATE_FORMAT(head.fecha_emision,'%d-%m-%Y') as fecha_emision " +
                            " from svm_guiadespacho_cab head inner join svm_mae_clientes cli " +
                            " on head.rut_cliente=cli.rut " +
                            " INNER JOIN svm_guiadespacho_det GDDET " +
                            " ON head.numero_guia = GDDET.numero_guia " +
                            " INNER JOIN svm_factura_det FD " +
                            " ON GDDET.numero_guia = FD.nro_guia_desp " +
                            " where head.facturado = 1 and " +
                            " head.rut_cliente = '"+cliente+"' " +
                            " and FD.nro_factura = "+fact+" " +
                            " and head.numero_guia not in (select nro_guia_desp from svm_factura_det_tmp where secuencia = "+secuencia+") ";
                    if(request.getParameter("guia") != null && !request.getParameter("guia").trim().isEmpty()){
                        guia = Integer.parseInt(request.getParameter("guia"));
                        q += " AND head.numero_guia LIKE ('%"+guia+"%') ";
                    }
                    
                    ResultSet rsQuery = stmt.executeQuery(q);

                    while(rsQuery.next())
                    {
                        nroGuia=rsQuery.getString("numero_guia");
                        retTbl += "<tr>";
                        retTbl += "<td><input type='checkbox' name='"+nroGuia+"' class='checkboxguias'/></td>";
                        retTbl += "<td>"+nroGuia+"</td>";
                        retTbl += "<td>"+rsQuery.getString("fecha_emision")+"</td>";
                        retTbl += "</tr>";
                    }
                    out.print(retTbl);
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            }else if(flag.equals("ingresofact")) {
                var = "INGRESO";
                fechaEmision = request.getParameter("fecha_emision");
                cliente = request.getParameter("rcliente");
                nombcliente = request.getParameter("ncliente");
                ejecutivo = request.getParameter("ejecutivo");
                formapago = request.getParameter("pago");
                excenta = request.getParameter("excent");
                adicional = request.getParameter("adic");
                comentario = request.getParameter("coment");
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1,var);
                    sp_usu.setInt(2,0);
                    sp_usu.setString(3,fechaEmision);
                    sp_usu.setString(4,cliente);
                    sp_usu.setString(5,ejecutivo);
                    sp_usu.setString(6,formapago);
                    sp_usu.setString(7,excenta);
                    sp_usu.setString(8,adicional);
                    sp_usu.setString(9,comentario);
                    sp_usu.setInt(10,0);
                    sp_usu.setInt(11,0);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
                    sp_usu.execute();
                    String resp = sp_usu.getString(1);
                    
                    out.print(resp);
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            } else if(flag.equals("validGuia")) {
                var = "VALIDA_GUIA";
                
                guia = Integer.parseInt(request.getParameter("nroGuia"));
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1,var);
                    sp_usu.setInt(2,0);
                    sp_usu.setString(3,null);
                    sp_usu.setString(4,null);
                    sp_usu.setString(5,null);
                    sp_usu.setString(6,null);
                    sp_usu.setString(7,null);
                    sp_usu.setString(8,null);
                    sp_usu.setString(9,null);
                    sp_usu.setInt(10,guia);
                    sp_usu.setInt(11,0);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
                    sp_usu.execute();
                    String resp = sp_usu.getString(1);
                    out.print(resp);
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            } else if(flag.equals("validGuiaActualiza")) {
                var = "VALIDA_GUIA_ACTUALIZA";
                
                guia = Integer.parseInt(request.getParameter("nroGuia"));
                secuencia = Integer.parseInt(request.getParameter("secuencia"));
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1,var);
                    sp_usu.setInt(2,0);
                    sp_usu.setString(3,null);
                    sp_usu.setString(4,null);
                    sp_usu.setString(5,null);
                    sp_usu.setString(6,null);
                    sp_usu.setString(7,null);
                    sp_usu.setString(8,null);
                    sp_usu.setString(9,null);
                    sp_usu.setInt(10,guia);
                    sp_usu.setInt(11,secuencia);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
                    sp_usu.execute();
                    String resp = sp_usu.getString(1);
                    out.print(resp);
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            }else if(flag.equals("ingresoGuiaFact")) {
                var = "INGRESOGUIAFACT";
                fact = Integer.parseInt(request.getParameter("nroFact"));
                secuencia = Integer.parseInt(request.getParameter("secuencia"));
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1,var);
                    sp_usu.setInt(2,fact);
                    sp_usu.setString(3,null);
                    sp_usu.setString(4,null);
                    sp_usu.setString(5,null);
                    sp_usu.setString(6,null);
                    sp_usu.setString(7,null);
                    sp_usu.setString(8,null);
                    sp_usu.setString(9,null);
                    sp_usu.setInt(10,0);
                    sp_usu.setInt(11,secuencia);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
                    sp_usu.execute();
                    String resp = sp_usu.getString(1);
                    out.print(resp);
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            }else if(flag.equals("ActualizaGuiaFact")) {
                var = "ACTUALIZAGUIAFACT";
                fact = Integer.parseInt(request.getParameter("nroFact"));
                secuencia = Integer.parseInt(request.getParameter("secuencia"));
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1,var);
                    sp_usu.setInt(2,fact);
                    sp_usu.setString(3,null);
                    sp_usu.setString(4,null);
                    sp_usu.setString(5,null);
                    sp_usu.setString(6,null);
                    sp_usu.setString(7,null);
                    sp_usu.setString(8,null);
                    sp_usu.setString(9,null);
                    sp_usu.setInt(10,0);
                    sp_usu.setInt(11,secuencia);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
                    sp_usu.execute();
                    String resp = sp_usu.getString(1);
                    out.print(resp);
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            } else if(flag.equals("actulizafact")) {
                var = "ACTUALIZA";
                
                fact = Integer.parseInt(request.getParameter("nroFact"));
                fechaEmision = request.getParameter("fecha_emision");
                cliente = request.getParameter("rcliente");
                nombcliente = request.getParameter("ncliente");
                ejecutivo = request.getParameter("ejecutivo");
                formapago = request.getParameter("pago");
                excenta = request.getParameter("excent");
                adicional = request.getParameter("adic");
                comentario = request.getParameter("coment");
                secuencia = Integer.parseInt(request.getParameter("secuencia"));
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1,var);
                    sp_usu.setInt(2,fact);
                    sp_usu.setString(3,fechaEmision);
                    sp_usu.setString(4,cliente);
                    sp_usu.setString(5,ejecutivo);
                    sp_usu.setString(6,formapago);
                    sp_usu.setString(7,excenta);
                    sp_usu.setString(8,adicional);
                    sp_usu.setString(9,comentario);
                    sp_usu.setInt(10,0);
                    sp_usu.setInt(11,secuencia);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
                    sp_usu.execute();
                    String resp = sp_usu.getString(1);
                    
                    out.print(resp);
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            }else if(flag.equals("eliminaTmp")) {
                var = "ELIMINA_TMP_GUIA";
                
                secuencia = Integer.parseInt(request.getParameter("secuencia"));
                guia = Integer.parseInt(request.getParameter("nroGuia"));
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    CallableStatement sp_usu = _connMy.prepareCall("{call sp_factura(?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1,var);
                    sp_usu.setInt(2,0);
                    sp_usu.setString(3,null);
                    sp_usu.setString(4,null);
                    sp_usu.setString(5,null);
                    sp_usu.setString(6,null);
                    sp_usu.setString(7,null);
                    sp_usu.setString(8,null);
                    sp_usu.setString(9,null);
                    sp_usu.setInt(10,guia);
                    sp_usu.setInt(11,secuencia);
                    sp_usu.execute();
                    
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            }else if(flag.equals("selectClientes")) {
                String rcliente = request.getParameter("rcliente");
                cliente = request.getParameter("cliente");
                try {
                    _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
                    Statement stmt = _connMy.createStatement();
                    String q="SELECT concat(rut,'-',dv) rut, razon_social,replace(concat(rpad(concat(rut,'-',dv),20,' '),''),' ','&nbsp;') rut_pad FROM svm_mae_clientes WHERE 1=1 ";
                    if(rcliente != null && !rcliente.trim().isEmpty()){
                        q += " AND rut LIKE ('%"+rcliente+"%') ";
                    }
                    
                    if(cliente != null && !cliente.trim().isEmpty()){
                        q += " AND razon_social LIKE ('%"+cliente+"%') ";
                    }
                    ResultSet rsQuery = stmt.executeQuery(q);

                    while(rsQuery.next())
                    {
                        out.println("<option value='"+rsQuery.getString("rut")+"'>"+rsQuery.getString("rut_pad")+rsQuery.getString("razon_social")+"</option>");
                    }
                } catch (Exception e) {
                    System.out.println("Error: "+e.getMessage());
                }
            }else {
                    out.print("Opcion invalida");
            }
        }
            
    }
                      
     

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

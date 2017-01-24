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
import java.sql.ResultSet;
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
 * @author Ivan
 */
@WebServlet(name = "ServletSPOrdenTaller", urlPatterns = {"/ServletSPOrdenTaller"})
public class ServletSPOrdenTaller extends HttpServlet {

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
            SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
            String opcion = request.getParameter("opcion");

            String numeroOrden = request.getParameter("txt_orden_numero").isEmpty()? "0": request.getParameter("txt_orden_numero");
            String numeroCotiza = request.getParameter("txt_cotizacion_numero").isEmpty()? "0": request.getParameter("txt_cotizacion_numero");
            String fechaEmision = request.getParameter("txt_ordentaller_fecha") == null ? "0" : request.getParameter("txt_ordentaller_fecha");
            String fechaTermino = request.getParameter("txt_ordentaller_fechatermino") == null ? "0" : request.getParameter("txt_ordentaller_fechatermino");
            String fechaDespacho = request.getParameter("txt_ordentaller_fechadespacho") == null ? "0" : request.getParameter("txt_ordentaller_fechadespacho");
            String detalle = request.getParameter("txt_detalle");
            String nroFactura = request.getParameter("txt_factura_numero").isEmpty()? "0": request.getParameter("txt_factura_numero");
            String nroGuia = request.getParameter("txt_guia_despacho").isEmpty()? "0": request.getParameter("txt_guia_despacho");
            String especial = request.getParameter("txt_especial");
            String aceptaCon = request.getParameter("txt_acepta_con");
            String rutCli = request.getParameter("txt_rutcli").isEmpty()? "0": request.getParameter("txt_rutcli");            
            String sequencia = request.getParameter("sequencia").equals("undefined") ? "0" : request.getParameter("sequencia");
            String desde = request.getParameter("fecha_desde");
            String hasta = request.getParameter("fecha_hasta");

            String estado=request.getParameter("estado").isEmpty()?"Ingresada":request.getParameter("estado");            
            //estado = request.getParameter("estado").equals("X_X") ? "" : request.getParameter("estado");
            estado= "Ingresada";
            rutCli=rutCli.contains("-")?rutCli.substring(0,rutCli.indexOf("-")):rutCli;
            
            try {
                _connMy = conexionBD.Conectar((String) s.getAttribute("organizacion"));
                CallableStatement sp_usu = null;

                /*try {
                 sp_usu = _connMy.prepareCall("{call sp_historial(?,?,?)}");
                 sp_usu.setString(1, opcion);
                 sp_usu.setLong(2, Long.parseLong(sequencia));
                 sp_usu.setString(3, estado);
                 sp_usu.execute();
                 } catch (Exception e) {
                 System.out.println(e.toString());
                 }*/

                if (opcion.equals("select_all")) {
                
                    sp_usu = _connMy.prepareCall("{call sp_ordentaller(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1, opcion);
                    sp_usu.setInt(2, 0);
                    sp_usu.setInt(3, 0);
                    sp_usu.setDate(4, null);
                    sp_usu.setDate(5, null);
                    sp_usu.setDate(6, null);
                    sp_usu.setString(7, "");
                    sp_usu.setInt(8, 0);
                    sp_usu.setInt(9, 0);
                    sp_usu.setString(10, "");
                    sp_usu.setString(11, "");
                    sp_usu.setInt(12, 0);
                    sp_usu.setString(13, "");
                    sp_usu.setInt(14, 0);
                    sp_usu.setString(15, desde);
                    sp_usu.setString(16, hasta);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
                    sp_usu.execute();
                }

                if (opcion.equals("select")) {
                
                    sp_usu = _connMy.prepareCall("{call sp_ordentaller(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1, opcion);
                    sp_usu.setInt(2, 0);
                    sp_usu.setInt(3, 0);
                    sp_usu.setDate(4, null);
                    sp_usu.setDate(5, null);
                    sp_usu.setDate(6, null);
                    sp_usu.setString(7, "");
                    sp_usu.setInt(8, 0);
                    sp_usu.setInt(9, 0);
                    sp_usu.setString(10, "");
                    sp_usu.setString(11, "");
                    sp_usu.setInt(12, 0);
                    sp_usu.setString(13, "");
                    sp_usu.setInt(14, Integer.parseInt(sequencia));
                    sp_usu.setString(15, desde);
                    sp_usu.setString(16, hasta);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    
                    sp_usu.execute();
                }                
                
                if ((opcion.equals("insert")) || (opcion.equals("update"))) {
                    
                    Date fecEmision = new Date(formato.parse(fechaEmision).getTime());
                    Date fecTermino = new Date(formato.parse("1900-01-01").getTime());
                    Date fecDespacho = new Date(formato.parse("1900-01-01").getTime());


                    sp_usu = _connMy.prepareCall("{call sp_ordentaller(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                    sp_usu.setString(1, opcion);
                    sp_usu.setInt(2, Integer.parseInt(numeroOrden));
                    sp_usu.setInt(3, Integer.parseInt(numeroCotiza));
                    sp_usu.setDate(4, fecEmision);
                    sp_usu.setDate(5, fecTermino);
                    sp_usu.setDate(6, fecDespacho);
                    sp_usu.setString(7, detalle);
                    sp_usu.setInt(8, Integer.parseInt(nroFactura));
                    sp_usu.setInt(9, Integer.parseInt(nroGuia));
                    sp_usu.setString(10, especial);
                    sp_usu.setString(11, aceptaCon);
                    sp_usu.setInt(12, Integer.parseInt(rutCli));
                    sp_usu.setString(13, estado);
                    sp_usu.setInt(14, Integer.parseInt(sequencia));
                    sp_usu.setString(15, desde);
                    sp_usu.setString(16, hasta);
                    sp_usu.registerOutParameter(1, Types.VARCHAR);

                    sp_usu.execute();
                    String valorSalida = sp_usu.getString(1);
                    
                if (valorSalida.equalsIgnoreCase("error ejecucion")) {
                    out.println("Ya existe");
                }

                if (!opcion.contains("select")) {
                    out.println(valorSalida);
                }                    
                }

                final ResultSet rs = sp_usu.getResultSet();

             
                String salida = "";
                if (opcion.equals("select")) {              
                    while(rs.next())
                    {
                        salida += rs.getString("numero_ordentaller") + "|";
                        salida += rs.getString("numero_cotizacion") + "|";
                        salida += rs.getString("fecha_emision") + "|";
                        salida += rs.getString("estado") + "|";
                        salida += rs.getString("secuencia") + "|";
                        salida += rs.getString("rut_cli") + "|";
                        salida += rs.getString("razon_social") + "|";
                        salida += rs.getString("numero_factura") + "|";
                        salida += rs.getString("numero_guiadespacho") + "|";
                        salida += rs.getString("detalle") + "|";
                        salida += rs.getString("fecha_termino") + "|";                        
                        salida += rs.getString("fecha_despacho") + "|";                        
                        salida += rs.getString("especial") + "|";                                                
                        salida += rs.getString("acepta_con") + "|";
                    }
                    out.println(salida);
                } else if (opcion.equals("select_all")) {
                    String cla = "";
                    int cont = 0;
                    while (rs.next()) {
                        if (cont % 2 == 0) {
                            cla = "alt";
                        } else {
                            cla = "";

                        }
                        
                        salida += "<tr id='filaTablaOrdenTaller" + cont + "' class='" + cla + "'>";
                        salida += "<td>";
                        salida += "<a href=\"javascript: onclick=ModificaOrdenTaller(" + cont + ")\"> >></a>";
                        salida += "<input type=\"hidden\" value=\"0\" id=\"habilitaActCom\" name=\"habilitaActCom\" />";
                        salida += "<input type=\"hidden\" value=\"\" id=\"corrOT\" />";
                        salida += "</td>";
                        salida += "<td id=\"numero_ot" + cont + "\">" + rs.getString("numero_ordentaller") + "</td>";
                        salida += "<td id=\"num_cotizacion" + cont + "\">" + rs.getString("numero_cotizacion") + "</td>";
                        salida += "<td id=\"fecha_emision" + cont + "\">" + rs.getString("fecha_emision") + "</td>";
                        salida += "<td id=\"cliente" + cont + "\">" + rs.getString("razon_social") + "</td>";                        
                        salida += "<td id=\"estado" + cont + "\">" + rs.getString("estado") + "</td>";
                        salida += "<td style=\"display: none\" id=\"secuencia" + cont + "\">" + rs.getString("secuencia") + "</td>";
                        salida += "</tr>";

                        cont++;
                    }
                    out.println(salida);
                }

            } catch (Exception e) {
                //_connMy.rollback();
                e.printStackTrace();
                System.out.println("ERROR " + e.getMessage());
            } finally {
                try {
                    _connMy.close();
                } catch (Exception e) {

                }
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

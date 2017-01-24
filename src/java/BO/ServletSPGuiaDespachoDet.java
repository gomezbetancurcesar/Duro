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

@WebServlet(name = "ServletSPGuiaDespachoDet", urlPatterns = {"/ServletSPGuiaDespachoDet"})
public class ServletSPGuiaDespachoDet extends HttpServlet {
    
    
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
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
            
            String opcion=request.getParameter("opcion");

            String correlativo=request.getParameter("correlativo").isEmpty()?"0":request.getParameter("correlativo");
            
            String numeroGuiaDespacho = request.getParameter("txt_guia_numero").isEmpty()? "0":request.getParameter("txt_guia_numero");
            String numeroOrdenTaller = request.getParameter("txt_OT_numero").isEmpty()? "0":request.getParameter("txt_OT_numero");            
            String itemGuia = request.getParameter("txt_guia_item");
            String cantidad = request.getParameter("txt_guia_cantidad").isEmpty()? "0":request.getParameter("txt_guia_cantidad");
            String detalleGuia = request.getParameter("txt_guia_detalle");
            String valor = request.getParameter("txt_guia_valor").isEmpty()? "0":request.getParameter("txt_guia_valor");
            String totalItem = request.getParameter("txt_guia_totalitem").isEmpty()? "0":request.getParameter("txt_guia_totalitem");
            String itemOT = request.getParameter("txt_guia_nroitem").isEmpty()? "0":request.getParameter("txt_guia_nroitem");
            
            String sequencia = request.getParameter("sequencia").equals("undefined") ? "0" : request.getParameter("sequencia");
            
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion")); 
                CallableStatement sp_usu=null;
                                           
                sp_usu = _connMy.prepareCall("{call sp_guiadespacho_det(?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1, opcion);
                sp_usu.setInt(2, Integer.parseInt(numeroGuiaDespacho));
                sp_usu.setInt(3,Integer.parseInt(correlativo));
                sp_usu.setInt(4, Integer.parseInt(numeroOrdenTaller));                
                sp_usu.setInt(5, Integer.parseInt(itemOT));                
                sp_usu.setInt(6, Integer.parseInt(cantidad));
                sp_usu.setString(7, detalleGuia);
                sp_usu.setInt(8, Integer.parseInt(valor));
                sp_usu.setInt(9, Integer.parseInt(totalItem));
                sp_usu.setInt(10,Integer.parseInt(sequencia));                
                sp_usu.registerOutParameter(1, Types.VARCHAR);
                
                sp_usu.execute();
                
                if (opcion.equals("insert")) {
                    String valorSalida = sp_usu.getString(1);
                
                    if(valorSalida.equalsIgnoreCase("error ejecucion"))
                    {
                        out.println("Ya existe");
                    }
                }
                
                final ResultSet rs = sp_usu.getResultSet();
                String cla = "";
                int cont = 0;

                String salida = "";
                if(opcion.equals("select") || opcion.equals("select_detalle") ){
                    while(rs.next())
                    {
                        if(cont % 2 == 0)
                        {                    
                            cla = "alt";
                        }else
                        {  
                            cla = "";                    
                        }
                        salida += "<tr id='filaTablaDetalle"+cont+"' class='"+cla+"'>";

                        salida += "<td><a id=\"seleccion"+cont+"\" href=\"javascript: onclick=ModificaDetalleGuia("+cont+")\"> >></a>\n" +
                                    "<input type=\"hidden\" value=\"0\" id=\"habilitaDetCom\" name=\"habilitaDetCom\" />\n" +
                                    "</td> ";
                        salida += "<td id =\"guiadespachoDet_correlativo"+cont+"\">"+rs.getString("correlativo")+"</td>";   
                        salida += "<td id =\"guiadespachoDet_OT"+cont+"\">"+rs.getString("numero_ordentaller")+"</td>";   
                        salida += "<td id =\"guiadespachoDet_Item"+cont+"\">"+rs.getString("itemOT")+"</td>";   
                        salida += "<td id =\"guiaDet_cantidad"+cont+"\">"+rs.getString("cantidad")+"</td>"; 
                        salida += "<td id =\"guiaDet_detalleguia"+cont+"\">"+rs.getString("detalle_guia")+"</td>"; 
                        salida += "<td id =\"guiaDet_valorunit"+cont+"\">"+rs.getString("valor_unitario")+"</td>"; 
                        salida += "<td id =\"guiaDet_totalitem"+cont+"\">"+rs.getString("total_item")+"</td>"; 
                        salida += "</tr>";
                        salida += "<input type=\"hidden\" id=\"cantidad_detalle\" value="+(cont+1)+"></input>";
                        cont++;
                    }
                    out.println(salida);
                }
            }catch(Exception e){
                //_connMy.rollback();
                e.printStackTrace();
                System.out.println("ERROR "+e.getMessage());
            }
            finally{
                try {
                    _connMy.close();
                } catch (Exception e) {
                    
                }
            }
            
        }
    }

    
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


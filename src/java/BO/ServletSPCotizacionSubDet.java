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
 * @author Felix
 */
@WebServlet(name = "ServletSPCotizacionSubDet", urlPatterns = {"/ServletSPCotizacionSubDet"})
public class ServletSPCotizacionSubDet extends HttpServlet {

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
            
            String opcion=request.getParameter("opcion");
            
            String numeroCotiza=request.getParameter("txt_cotizacion_numero").isEmpty()? "0":request.getParameter("txt_cotizacion_numero");
            String valor=request.getParameter("txt_cotizacion_valor");
            String margen=request.getParameter("txt_cotizacion_margen");
            String totalmaterial=request.getParameter("txt_cotizacion_totalmaterial");
            String subitem=request.getParameter("subitem").isEmpty()?"0":request.getParameter("subitem");
            String sequencia=request.getParameter("sequencia");
            String correlativo=request.getParameter("correlativo").isEmpty()?"0":request.getParameter("correlativo");
            
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion")); 
                CallableStatement sp_usu=null;
                           
                sp_usu = _connMy.prepareCall("{call sp_cotizaciones_subdet(?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,opcion);
                sp_usu.setInt(2,Integer.parseInt(numeroCotiza));
                sp_usu.setInt(3,Integer.parseInt(correlativo));
                sp_usu.setInt(4,Integer.parseInt(subitem));
                sp_usu.setInt(5,Integer.parseInt(valor));
                sp_usu.setFloat(6,Float.parseFloat(margen.replace("," , ".")));
                sp_usu.setInt(7,Integer.parseInt(totalmaterial));
                sp_usu.setInt(8,Integer.parseInt(sequencia));
                sp_usu.registerOutParameter(1, Types.VARCHAR);
                
                sp_usu.execute();
                String valorSalida = sp_usu.getString(1);                
                
                if(valorSalida.equalsIgnoreCase("error ejecucion"))
                {
                    out.println("Ya existe");
                }
                
                final ResultSet rs = sp_usu.getResultSet();            
                String cla = "";
                int cont = 0;
                String salida = "";
                if(opcion.equals("select_detalle")){
                    while(rs.next())
                    {
                        if(cont % 2 == 0)
                        {                    
                            cla = "alt";
                        }else
                        {  
                            cla = "";                    
                        }
                        
                        salida += "<tr id='filaTablaSubDetalle"+cont+"' class='"+cla+"'>";
                        salida += "<td><a id=\"seleccion"+cont+"\" href=\"javascript: onclick=ModificaSubDetalleComercial("+cont+")\"> >></a>\n" +
                                    "<input type=\"hidden\" value=\"0\" id=\"habilitaSubDetCom\" name=\"habilitaSubDetCom\" />\n" +
                                    "</td> ";
                        salida += "<td id =\"cotazacionSubDet_numero"+cont+"\">"+rs.getString("correlativo")+"</td>";                         
                        salida += "<td id =\"cotazacionSubDet_item"+cont+"\">"+rs.getString("sub_item")+"</td>"; 
                        salida += "<td id =\"cotazacionSubDet_valor"+cont+"\">"+rs.getString("valor_material")+"</td>"; 
                        salida += "<td id =\"cotazacionSubDet_margen"+cont+"\">"+rs.getString("margen").replace(".", ",")+"</td>"; 
                        salida += "<td id =\"cotazacionSubDet_total"+cont+"\">"+rs.getString("totalmaterial_pesos")+"</td>"; 
                        salida += "</tr>";
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

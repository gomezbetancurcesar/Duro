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
@WebServlet(name = "ServletSPCotizacionDet", urlPatterns = {"/ServletSPCotizacionDet"})
public class ServletSPCotizacionDet extends HttpServlet {

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
            
            String opcion=request.getParameter("opcion");
            
            String numeroCotiza=request.getParameter("txt_cotizacion_numero").isEmpty()? "0":request.getParameter("txt_cotizacion_numero");
            String codPieza=request.getParameter("select_cotizacion_pieza");
            String descPieza=".";
            String cantidad=request.getParameter("txt_cotizacion_cantidad");
            String valorDM=request.getParameter("txt_cotizacion_dm");
            String diametro=request.getParameter("txt_cotizacion_diametro");
            String largo=request.getParameter("txt_cotizacion_largo");
            String valorUniCrom=request.getParameter("txt_cotizacion_valUniCrom");
            String valorTotalCrom=request.getParameter("txt_cotizacion_totalCrom");
            String sequencia=request.getParameter("sequencia");
            String correlativo=request.getParameter("correlativo").isEmpty()?"0":request.getParameter("correlativo");
            
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion")); 
                CallableStatement sp_usu=null;
                           
                sp_usu = _connMy.prepareCall("{call sp_cotizaciones_det(?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,opcion);
                sp_usu.setInt(2,Integer.parseInt(numeroCotiza));
                sp_usu.setInt(3,Integer.parseInt(correlativo));
                sp_usu.setString(4,codPieza);
                sp_usu.setString(5,descPieza);
                sp_usu.setInt(6,Integer.parseInt(cantidad));
                sp_usu.setString(7,valorDM);
                sp_usu.setDouble(8,Double.parseDouble(diametro));
                sp_usu.setDouble(9,Double.parseDouble(largo));
                sp_usu.setInt(10,Integer.parseInt(valorUniCrom));
                sp_usu.setInt(11,Integer.parseInt(valorTotalCrom));
                sp_usu.setInt(12,Integer.parseInt(sequencia));
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
                if(opcion.equals("select")){
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

                        salida += "<td><a id=\"seleccion"+cont+"\" href=\"javascript: onclick=ModificaDetalleComercial("+cont+")\"> >></a>\n" +
                                    "<input type=\"hidden\" value=\"0\" id=\"habilitaDetCom\" name=\"habilitaDetCom\" />\n" +
                                    "</td> ";
                        salida += "<td id =\"cotazacionDet_correlativo"+cont+"\">"+rs.getString("correlativo")+"</td>";   
                        salida += "<td id =\"cotazacionDet_codPieza"+cont+"\">"+rs.getString("cod_pieza")+"</td>";   
                        salida += "<td id =\"cotazacionDet_pieza"+cont+"\">"+rs.getString("desc_pieza")+"</td>"; 
                        salida += "<td id =\"cotazacionDet_cantidad"+cont+"\">"+rs.getString("cantidad")+"</td>"; 
                        salida += "<td id =\"cotazacionDet_valorDm"+cont+"\">"+rs.getString("valor_dm")+"</td>"; 
                        salida += "<td id =\"cotazacionDet_diametro"+cont+"\">"+rs.getString("diametro")+"</td>"; 
                        salida += "<td id =\"cotazacionDet_largo"+cont+"\">"+rs.getString("largo")+"</td>"; 
                        salida += "<td id =\"cotazacionDet_valUniCrom"+cont+"\">"+rs.getString("valor_uni_crom")+"</td>"; 
                        salida += "<td id =\"cotazacionDet_totalCrom"+cont+"\">"+rs.getString("total_cromado")+"</td>"; 
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

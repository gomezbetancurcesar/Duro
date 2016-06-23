/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BO;

import DAL.conexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author User
 */
@WebServlet(name = "ServletExcelComision", urlPatterns = {"/ServletExcelComision"})
public class ServletExcelComision extends HttpServlet {

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
           throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession s = request.getSession(); 
            Connection _connMy = null;                                            
            String fechaInicio = request.getParameter("hid_comision_fechaInicial");
            String fechaFinal = request.getParameter("hid_comision_fechaFinal");                 
        try{      
            _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
            Statement stmt = null;
            ResultSet rs = null;                                       
            stmt = _connMy.createStatement();
            String query= "select * from svm_actcomercial_tot total, svm_actcomercial_det detalle where"
                    + "  total.fecha between '"+fechaInicio+"' and '"+fechaFinal+"' "
                    + "and total.nro_negocio = detalle.nro_negocio order by total.nro_negocio";
            rs = stmt.executeQuery(query);                                                                                                
            String salida = "";
            int cont = 0;            
            while(rs.next())
            {               
                salida += "<tr>";
                salida += "<td>"+rs.getString("rut_eje")+"</td>";
                salida += "<td>"+rs.getString("nombre_eje")+"</td>";  
                salida += "<td>"+rs.getString("fecha")+"</td>";     
                salida += "<td>"+rs.getString("rut_cli")+"</td>";                
                salida += "<td>"+rs.getString("nombre_cli")+"</td>";                
                salida += "<td>"+rs.getString("caso")+"</td>"; 
                salida += "<td>"+rs.getString(1)+"</td>";
                salida += "<td>"+rs.getString("nro_movil")+"</td>";   
                salida += "<td>"+rs.getString("tipo_servicio")+"</td>";
                salida += "<td>"+rs.getString("servicios_moviles")+"</td>";
                salida += "<td>"+rs.getString("port_pp_hab")+"</td>";
                salida += "<td>"+rs.getString("tipo_plan_ant")+"</td>";
                salida += "<td>"+rs.getString("plan_antiguo")+"</td>";                                                                                                                        
                salida += "<td>"+rs.getString("cargo_fijo_ant")+"</td>";
                salida += "<td>"+rs.getString("tipo_plan_nue")+"</td>";   
                salida += "<td>"+rs.getString("plan_nuevo")+"</td>";   
                salida += "<td>"+rs.getString("cargo_fijo_nue")+"</td>";   
                salida += "<td>"+rs.getString("arpu")+"</td>";   
                salida += "<td>"+rs.getString("uf")+"</td>";   
                salida += "<td>"+rs.getString("estado")+"</td>";   
                salida += "<td>"+rs.getString("crm")+"</td>";   
                salida += "<td>"+rs.getString("comentario")+"</td>";
                salida += "<td>"+rs.getString("supervisor")+"</td>";   
                salida += "<td>"+rs.getString("estado_cierre")+"</td>";   
                salida += "</tr>";
                cont ++;                
            }                
            s.setAttribute("dataExcel", salida);
        }catch(Exception e){
            _connMy.rollback();
            e.printStackTrace();
        }
        finally{
            _connMy.close();
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletSPEscritorio.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletSPEscritorio.class.getName()).log(Level.SEVERE, null, ex);
        }
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

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
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
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
 * @author Blas Muñoz
 */
@WebServlet(name = "ServletCargaRv", urlPatterns = {"/ServletCargaRv"})
public class ServletCargaRv extends HttpServlet {

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
            String nomEjecutivo = request.getParameter("ejecutivo");
            String tipoUser = request.getParameter("tipoUser");
            String rut = request.getParameter("rut");
            
            try{
                String tipoNegocio = "";
                String rutEjecutivo = "";
                String supervisor ="";
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));             
                CallableStatement sp_usu = _connMy.prepareCall("{call sp_CargaNomEjecutivo(?,?,?,?,?,?,?)}");                  
                sp_usu.setString(1, tipoUser);
                sp_usu.setString(2,nomEjecutivo);
                sp_usu.setString(3,rut);
                sp_usu.setString(4,tipoNegocio);
                sp_usu.setString(5,rutEjecutivo);
                sp_usu.setString(6,supervisor);
                sp_usu.setString(7,supervisor);
                sp_usu.registerOutParameter(4,java.sql.Types.VARCHAR);
                sp_usu.registerOutParameter(5,java.sql.Types.VARCHAR);
                sp_usu.registerOutParameter(6,java.sql.Types.VARCHAR);
                sp_usu.registerOutParameter(7,java.sql.Types.VARCHAR);
                sp_usu.execute();
                rutEjecutivo = sp_usu.getString(4);
                tipoNegocio = sp_usu.getString(5);
                supervisor = sp_usu.getString(6);                
                out.println(rutEjecutivo+"|"+tipoNegocio+"|"+supervisor);                                                
            }catch(Exception e){
                System.out.println("ERROR "+e.getMessage());
//                _connMy.rollback();
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
            Logger.getLogger(ServletCargaRv.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletCargaRv.class.getName()).log(Level.SEVERE, null, ex);
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

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
@WebServlet(name = "ServletSPGeneraOT", urlPatterns = {"/ServletSPGeneraOT"})
public class ServletSPGeneraOT extends HttpServlet {

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
            String numeroCotiza = request.getParameter("txt_cotizacion_numero").isEmpty()? "0": request.getParameter("txt_cotizacion_numero");
            
            try {
                _connMy = conexionBD.Conectar((String) s.getAttribute("organizacion"));
                CallableStatement sp_usu = null;
                
                sp_usu = _connMy.prepareCall("{call sp_gerenaordentaller(?,?)}");
                sp_usu.setString(1, "");
                sp_usu.setString(2, numeroCotiza);
                sp_usu.registerOutParameter(1, Types.VARCHAR);

                sp_usu.execute();
                String valorSalida = sp_usu.getString(1);
                    
                if (valorSalida.equalsIgnoreCase("error ejecucion")) {
                    out.println("Error");
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

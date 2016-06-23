/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package BO;

import DAL.conexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

/**
 *
 * @author User
 */
@WebServlet(name = "ServletValidaLogin", urlPatterns = {"/ServletValidaLogin"})
public class ServletValidaLogin extends HttpServlet 
{

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
            throws ServletException, IOException 
    {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) 
        {
            /* TODO output your page here. You may use following sample code. */
            try  
            {
                HttpSession s = request.getSession();               
                Connection con = null;
                s.setMaxInactiveInterval(-1);
                String nombre = null;
                String tipoUser = "";
                String supervisor = "";
                String tipoNegocio = "";
                String rut= request.getParameter("rut");
                String pass= request.getParameter("pass");
                String org = request.getParameter("org");
                try
                {
                    con = conexionBD.Conectar(org.toLowerCase());
                }
                catch(Exception e)
                {
                    out.print("ERROR BASE DE DATOS "+"("+org+")");
                }
                if (con != null)
                {
                    CallableStatement sp_usu = con.prepareCall("{call sp_mae_usuarios(?,?,?,?,?,'','')}");
                    sp_usu.setString(1,"login");
                    sp_usu.setString(2,rut);
                    sp_usu.setString(3,"");
                    sp_usu.setString(4,pass);
                    sp_usu.setString(5,"");
                    sp_usu.registerOutParameter(1, Types.VARCHAR);
                    sp_usu.execute();
                    String valorSalida = sp_usu.getString(1);
                    s.setAttribute("organizacion", org.toLowerCase());
                    out.print(valorSalida);
                    sp_usu = con.prepareCall("{call sp_mae_usuarios(?,?,'','','','','')}");
                    sp_usu.setString(1,"consulta");
                    sp_usu.setString(2,rut);
                    sp_usu.execute();
                    final ResultSet rs = sp_usu.getResultSet();
                    
                    while (rs.next())
                    {
                        nombre = rs.getString("nombre_user");
                        tipoUser = rs.getString("tipo");
                        supervisor = rs.getString("supervisor");
                        tipoNegocio = rs.getString("tipo_negocio");
                        
                    }
                    System.out.println("supervisor");
                    s.setAttribute("nom", nombre);
                    s.setAttribute("rut", rut);
                    s.setAttribute("tipo", tipoUser);
                    s.setAttribute("supervisor", supervisor);
                    s.setAttribute("tipoNegocio", tipoNegocio);
                    s.setAttribute("organizacion", "Durocrom");
                }
                else
                {
                    out.print("ERROR BASE DE DATOS "+"("+org+")");
                }                
                    con.close();
            }
            
            catch (Exception e)
            {
                System.out.print(e.getMessage());
                response.sendRedirect("login.jsp");
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

    private void alert(String el_nombre_es_obligatorio)
    {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}

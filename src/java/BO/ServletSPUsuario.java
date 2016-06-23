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
 * @author User
 */
@WebServlet(name = "ServletSPUsuario", urlPatterns = {"/ServletSPUsuario"})
public class ServletSPUsuario extends HttpServlet {

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
            throws ServletException, IOException,SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            HttpSession s = request.getSession();
            Connection _connMy = null;
            String opcion_Usuario = request.getParameter("opcion_Usuario");
            String rut = request.getParameter("txt_usr_rut");
            String nom = request.getParameter("txt_usr_nom");
            String tipo = request.getParameter("slt_usr_tipo");
            String pass = request.getParameter("txt_usr_pass");
            String tipNegocio = request.getParameter("slt_usr_tipoNegocio");
            String supervisor = request.getParameter("slt_usr_supervisor");
        try{           
            _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));
            System.out.println("Variables "+tipNegocio);
            CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_usuarios(?,?,?,?,?,?,?)}");
            sp_usu.setString(1,opcion_Usuario);
            sp_usu.setString(2,rut);
            sp_usu.setString(3,nom);
            sp_usu.setString(4,pass);
            sp_usu.setString(5,tipo);
            sp_usu.setString(6,tipNegocio);
            sp_usu.setString(7,supervisor);
            sp_usu.registerOutParameter("op", Types.VARCHAR);
            sp_usu.execute();
            
            String respuesta = sp_usu.getString("op");
            System.out.println("Salida: "+respuesta);
            
            out.print(respuesta);
            
            //response.sendRedirect("svm_Mantencion_Configuracion.jsp");
            
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
            Logger.getLogger(ServletSPUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
            throws ServletException, IOException{
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ServletSPUsuario.class.getName()).log(Level.SEVERE, null, ex);
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

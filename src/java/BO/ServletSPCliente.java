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
 * @author Sistemas-ltda
 */
@WebServlet(name = "ServletSPCliente", urlPatterns = {"/ServletSPCliente"})
public class ServletSPCliente extends HttpServlet {

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
            HttpSession s = request.getSession();
            Connection _connMy = null;
            
            String variable = request.getParameter("mod");
            
            String rutCli=request.getParameter("txt_cliente_rut");
             
            String razonSocial=request.getParameter("txt_cliente_nombre");
            String contacto=request.getParameter("txt_cliente_contacto");
            String direccion=request.getParameter("txt_cliente_direccion");
            String ejecutivo=request.getParameter("txt_cliente_ejecutivo");
            String estado=request.getParameter("txt_cliente_estado");
            String codigo=request.getParameter("txt_cliente_codigo");
            String sigla=request.getParameter("txt_sigla_cliente");
            String comuna=request.getParameter("txt_cliente_comuna");
            String ciudad=request.getParameter("txt_cliente_ciudad");
            String fono1=request.getParameter("txt_cliente_fono1");
            String fono2=request.getParameter("txt_cliente_fono2");
            String fax=request.getParameter("txt_cliente_fax");
            String rubro=request.getParameter("txt_cliente_rubro");
            String casilla=request.getParameter("txt_cliente_casilla");
            
            String dv="";
            try{
                dv=rutCli.substring(rutCli.indexOf("-")+1,rutCli.length());
                rutCli=rutCli.substring(0,rutCli.indexOf("-"));
            }catch(Exception e){
                dv="0";
            }
            estado=estado.replace("NaN", "");
            String estadoSend=estado.equals("X_X")?"":estado;
            
            //System.out.println("opcion: "+variable+" rut: "+rutCli+" nombre: "+razonSocial+" estado: "+estadoSend);
            
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion"));             
                CallableStatement sp_usu = _connMy.prepareCall("{call sp_mae_cliente(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,variable);
                sp_usu.setString(2, "");
                sp_usu.setString(3,"");
                sp_usu.setString(4,ejecutivo);
                sp_usu.setString(5, rutCli);
                sp_usu.setString(6,razonSocial);               
                sp_usu.setString(7,contacto);
                sp_usu.setString(8,direccion);                
                sp_usu.setString(9,estadoSend);
                sp_usu.setString(10,dv);
                sp_usu.setString(11,codigo);
                sp_usu.setString(12,sigla);
                sp_usu.setString(13,comuna);
                sp_usu.setString(14,ciudad);
                sp_usu.setString(15,fono1);
                sp_usu.setString(16,fono2);
                sp_usu.setString(17,fax);
                sp_usu.setString(18,rubro);
                sp_usu.setString(19,casilla);
                sp_usu.registerOutParameter(1, Types.VARCHAR);
                
                sp_usu.execute();  
                String valorSalida = sp_usu.getString(1);                
                
                final ResultSet rs = sp_usu.getResultSet();
                
                String salida="";
                int cont = 0;
                String estilo = "";
                if(variable.equals("select_all")){
                    while(rs.next()){
                        if(!estado.isEmpty()){
                            if(cont % 2 == 0)
                            {                    
                                estilo = "alt";
                            }else
                            {  
                                estilo = "";                    
                            }
                            salida += "<tr id='filaTablaCliente"+cont+"' class='"+estilo+"'>";

                            salida += "<td><a id=\"seleccion"+cont+"\" href=\"javascript: onclick=ModificaCliente("+cont+")\"> >></a>\n" +
                                        " <input type=\"hidden\" value=\"0\" id=\"habilitaCliente\" name=\"habilitaCliente\" />\n" +
                                        "<input type=\"hidden\" value=\"\" id=\"rut\" /></td> ";
                            salida += "<td id =\"Cliente_rut"+cont+"\">"+rs.getString("rut")+"</td>";
                            salida += "<td id =\"Cliente_Nombre"+cont+"\">"+rs.getString("nombre")+"</td>"; 
                            salida += "<td id =\"Cliente_Contacto"+cont+"\">"+rs.getString("contacto")+"</td>"; 
                            salida += "<td id =\"Cliente_Direccion"+cont+"\">"+rs.getString("direccion")+"</td>"; 
                            salida += "<td id =\"Cliente_Ejecutivo"+cont+"\">"+rs.getString("ejecutivo")+"</td>";   
                            salida += "<td id =\"Cliente_Estado"+cont+"\">"+rs.getString("estado")+"</td>";   


                            salida += "</tr>";
                            cont++;
                            salida += "<input type=\"hidden\" id=\"contador\" value=\""+cont+"\"/>";
                        }else{
                            salida+="<option value='"+rs.getString("rut")+"'>"+rs.getString("rut_pad")+rs.getString("nombre")+"</option>";
                        }
                    }
                    out.println(salida);
                }else if(variable.equals("insert")){
                    salida=valorSalida;
                    out.println(salida);
                }
                
            }catch(Exception e){
                //_connMy.rollback();
                e.printStackTrace();
                System.out.println("ERROR "+e.getMessage());
            }
            finally{
                _connMy.close();
            }
        }
        finally{
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
            Logger.getLogger(ServletSPCliente.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletSPCliente.class.getName()).log(Level.SEVERE, null, ex);
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

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
@WebServlet(name = "ServletSPGuiaDespacho", urlPatterns = {"/ServletSPGuiaDespacho"})
public class ServletSPGuiaDespacho extends HttpServlet {

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

            String numeroGuia=request.getParameter("txt_guiadespacho_numero").isEmpty()?"0":request.getParameter("txt_guiadespacho_numero");
            String fechaEmision=request.getParameter("txt_guiadespacho_fecha");
            String rutCli=request.getParameter("txt_guiadespacho_rutcli");
            String numeroCotizacion=request.getParameter("txt_cotizacion_numero");
            String guiaEspecial=request.getParameter("txt_guiadespacho_especial");
            String aceptoCot=request.getParameter("txt_guiadespacho_aceptoCOT");
            String condicionPago=request.getParameter("txt_guiadespacho_condicion_pago");
            String total=request.getParameter("txt_guiadespacho_total");
            String sequencia=request.getParameter("sequencia").equals("undefined")?"0":request.getParameter("sequencia");
            String desde=request.getParameter("fecha_desde");
            String hasta=request.getParameter("fecha_hasta");
            
            rutCli=rutCli.contains("-")?rutCli.substring(0,rutCli.indexOf("-")):rutCli;
            
            //String estado=request.getParameter("estado").isEmpty()?"Ingresada":request.getParameter("estado");
            //estado=request.getParameter("estado").equals("X_X")?"":request.getParameter("estado");
            String estado = "Ingresada";
            
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion")); 
                CallableStatement sp_usu=null;
                
                /*try{
                    sp_usu = _connMy.prepareCall("{call sp_historial(?,?,?,?)}");
                    sp_usu.setString(1,opcion);
                    sp_usu.setLong(2,Long.parseLong(sequencia));
                    sp_usu.setString(3,estado);
                    sp_usu.setString(4,""+rutEje);
                    sp_usu.execute();
                }catch(Exception e){
                    System.out.println(e.toString());
                }*/
                
                Date sqlDate= new Date(formato.parse(fechaEmision).getTime());               
                sp_usu = _connMy.prepareCall("{call sp_guiadespacho(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1, opcion);
                sp_usu.setInt(2,Integer.parseInt(numeroGuia));                
                sp_usu.setInt(3,Integer.parseInt(numeroCotizacion));                                
                sp_usu.setDate(4,sqlDate);                                                
                sp_usu.setString(5,rutCli);
                sp_usu.setString(6,guiaEspecial);                
                sp_usu.setInt(7,Integer.parseInt(total));
                sp_usu.setString(8,condicionPago);
                sp_usu.setString(9,aceptoCot);
                sp_usu.setString(10,desde);
                sp_usu.setString(11,hasta);
                sp_usu.setString(12,estado);
                sp_usu.setInt(13,Integer.parseInt(sequencia));
                sp_usu.registerOutParameter(1, Types.VARCHAR);

                sp_usu.execute();
                String valorSalida = sp_usu.getString(1);
                    
                if (valorSalida.equalsIgnoreCase("error ejecucion")) {
                    out.println("Ya existe");
                }

                if (!opcion.contains("select")) {
                    out.println(valorSalida);
                }                    
                
                if(valorSalida.equalsIgnoreCase("error ejecucion"))
                {
                    out.println("Ya existe");
                }
                
                final ResultSet rs = sp_usu.getResultSet();
                String salida = "";
                if(opcion.equals("select")){
                    while(rs.next())
                    {
                        salida += rs.getString("numero_guia")+"|";  
                        salida += rs.getString("fecha_emision")+"|";   
                        salida += rs.getString("rut_cliente")+"|"; 
                        salida += rs.getString("razon_social")+"|"; 
                        salida += rs.getString("numero_cotizacion")+"|"; 
                        salida += rs.getString("guiadespacho_especial")+"|"; 
                        salida += rs.getString("cond_pago")+"|"; 
                        salida += rs.getString("aceptoCOT")+"|";
                        salida += rs.getString("total")+"|";
                        salida += rs.getString("estado")+"|";
                    }
                }else if(opcion.equals("select_all")){
                    String cla = "";
                    int cont =0; 
                    while(rs.next())
                    {
                        if(cont % 2 == 0)
                        {
                            cla = "alt";
                        }else
                        {  
                            cla = "";

                        }
                        
                        salida += "<tr id='filaTablaGuiaDespacho"+cont+"' class='"+cla+"'>";
                        salida +="<td>";
                        salida +="<a href=\"javascript: onclick=ModificaGuiaDespacho("+cont+")\"> >></a>";
                        salida +="<input type=\"hidden\" value=\"0\" id=\"habilitaGuiaDesp\" name=\"habilitaGuiaDesp\" />";
                        salida +="<input type=\"hidden\" value=\"\" id=\"corrGuia\" />";
                        salida +="</td>";
                        salida +="<td id=\"numero_guia"+cont+"\">"+rs.getString("numero_guia")+"</td>";
                        salida +="<td id=\"fecha_emision"+cont+"\">"+rs.getString("fecha_emision")+"</td>";
                        salida +="<td id=\"razon_social"+cont+"\">"+rs.getString("razon_social")+"</td>";
                        salida +="<td id=\"especial"+cont+"\">"+rs.getString("guiadespacho_especial")+"</td>";
                        salida +="<td id=\"total"+cont+"\">"+rs.getString("total")+"</td>";
                        salida +="<td id=\"estado"+cont+"\">"+rs.getString("estado")+"</td>";
                        salida +="<td style=\"display: none\" id=\"secuencia"+cont+"\">"+rs.getString("secuencia")+"</td>";
                        salida +="</tr>";
                        
                        cont ++;                                    
                    }
                    
                }
                out.println(salida);
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

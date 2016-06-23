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
@WebServlet(name = "ServletSPCotizacion", urlPatterns = {"/ServletSPCotizacion"})
public class ServletSPCotizacion extends HttpServlet {

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
            String fechaEmision=request.getParameter("txt_cotizacion_fecha");
            String antencion=request.getParameter("txt_cotizacion_atencion");
            String rutEje=request.getParameter("txt_cotizacion_emitida_por").replace("NaN", "").isEmpty()?"0":request.getParameter("txt_cotizacion_emitida_por").replace("NaN", "");
            String rutCli=request.getParameter("txt_cotizacion_rutcli");
            String cotizacion=request.getParameter("select_cotizacion_especial");
            String moneda=request.getParameter("select_cotizacion_moneda");
            String presupuesto=request.getParameter("select_cotizacion_presupuesto_valido");
            String plazoEntrego=request.getParameter("select_cotizacion_plazo_entrega");
            String condicionPago=request.getParameter("select_cotizacion_condicion_pago");
            String sequencia=request.getParameter("sequencia").equals("undefined")?"0":request.getParameter("sequencia");
            String desde=request.getParameter("fecha_desde");
            String hasta=request.getParameter("fecha_hasta");
            
            rutCli=rutCli.contains("-")?rutCli.substring(0,rutCli.indexOf("-")):rutCli;
            
            String estado=request.getParameter("estado").isEmpty()?"Ingresada":request.getParameter("estado");
            estado=request.getParameter("estado").equals("X_X")?"":request.getParameter("estado");
            
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion")); 
                CallableStatement sp_usu=null;
                
                try{
                    sp_usu = _connMy.prepareCall("{call sp_historial(?,?,?,?)}");
                    sp_usu.setString(1,opcion);
                    sp_usu.setLong(2,Long.parseLong(sequencia));
                    sp_usu.setString(3,estado);
                    sp_usu.setString(4,""+rutEje);
                    sp_usu.execute();
                }catch(Exception e){
                    System.out.println(e.toString());
                }
                
                Date sqlDate= new Date(formato.parse(fechaEmision).getTime());               
                
                sp_usu = _connMy.prepareCall("{call sp_cotizacion(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1,opcion);
                sp_usu.setInt(2,Integer.parseInt(numeroCotiza));
                sp_usu.setDate(3,sqlDate);
                sp_usu.setString(4,estado);
                sp_usu.setInt(5,Integer.parseInt(rutEje));
                sp_usu.setInt(6,Integer.parseInt(rutCli));
                sp_usu.setString(7,antencion);
                sp_usu.setString(8,moneda);
                sp_usu.setString(9,cotizacion);
                sp_usu.setString(10,presupuesto);
                sp_usu.setString(11,plazoEntrego);
                sp_usu.setString(12,condicionPago);
                sp_usu.setInt(13,Integer.parseInt(sequencia));
                sp_usu.setString(14,desde);
                sp_usu.setString(15,hasta);
                sp_usu.registerOutParameter(1, Types.VARCHAR);
                
                sp_usu.execute();
                String valorSalida = sp_usu.getString(1);                

                if(valorSalida.equalsIgnoreCase("error ejecucion"))
                {
                    out.println("Ya existe");
                }
                
                if(!opcion.contains("select")){
                    out.println(valorSalida);
                }
                
                final ResultSet rs = sp_usu.getResultSet();
                String salida = "";
                if(opcion.equals("select")){
                    while(rs.next())
                    {
                        salida += rs.getString("numero_cotizacion")+"|";   
                        salida += rs.getString("fecha_emision")+"|";   
                        salida += rs.getString("atencion")+"|"; 
                        salida += rs.getString("emitida_por")+"|"; 
                        salida += rs.getString("moneda")+"|"; 
                        salida += rs.getString("cotizacion_especial")+"|"; 
                        salida += rs.getString("presupuesto_valido")+"|"; 
                        salida += rs.getString("plazo_entrega")+"|"; 
                        salida += rs.getString("condiciones_pago")+"|"; 
                        salida += rs.getString("rut_cli")+"|"; 
                        salida += rs.getString("razon_social")+"|"; 
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
                        
                        salida += "<tr id='filaTablaActComercial"+cont+"' class='"+cla+"'>";
                        salida +="<td>";
                        salida +="<a href=\"javascript: onclick=ModificaActComercial("+cont+")\"> >></a>";
                        salida +="<input type=\"hidden\" value=\"0\" id=\"habilitaActCom\" name=\"habilitaActCom\" />";
                        salida +="<input type=\"hidden\" value=\"\" id=\"corrCotiza\" />";
                        salida +="</td>";
                        salida +="<td id=\"num_cotizacion"+cont+"\">"+rs.getString("numero_cotizacion")+"</td>";
                        salida +="<td id=\"emititda_por"+cont+"\">"+ rs.getString("emitida_por")+"</td>";
                        salida +="<td id=\"fecha_emision"+cont+"\">"+rs.getString("fecha_emision")+"</td>";
                        salida +="<td id=\"rut_cli"+cont+"\">"+ rs.getString("rut_cli")+"</td>";
                        salida +="<td id=\"razon_cli"+cont+"\">"+rs.getString("razon_social")+"</td>";
                        salida +="<td id=\"pieza"+cont+"\">"+rs.getString("pieza")+"</td>";
                        salida +="<td id=\"cot_especial"+cont+"\">"+rs.getString("cotizacion_especial")+"</td>";
                        salida +="<td id=\"estado"+cont+"\">"+rs.getString("estado")+"</td>";
                        salida +="<td id=\"total"+cont+"\">"+rs.getString("total")+"</td>";
                        salida +="<td id=\"moneda"+cont+"\">"+rs.getString("moneda")+"</td>";
                        salida +="<td style=\"display: none\" id=\"secuencia"+cont+"\">"+rs.getString("secuencia")+"</td>";
                        salida +="</tr>";
                        
                        cont ++;                                    
                    }
                    System.out.println("salida = " + salida );
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

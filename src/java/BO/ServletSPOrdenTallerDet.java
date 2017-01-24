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
@WebServlet(name = "ServletSPOrdenTallerDet", urlPatterns = {"/ServletSPOrdenTallerDet"})
public class ServletSPOrdenTallerDet extends HttpServlet {

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

            String correlativo=request.getParameter("correlativo").isEmpty()?"0":request.getParameter("correlativo");
            
            String numeroOrdenTaller = request.getParameter("txt_orden_numero").isEmpty()? "0":request.getParameter("txt_orden_numero");
            String codPieza = request.getParameter("txt_cotizacion_pieza");
            String cantidad = request.getParameter("txt_cotizacion_cantidad").isEmpty()?"0":request.getParameter("txt_cotizacion_cantidad");
            String medida1 = request.getParameter("txt_medidas1_pieza").isEmpty()?"0":request.getParameter("txt_medidas1_pieza");
            String medida2 = request.getParameter("txt_medidas2_pieza").isEmpty()?"0":request.getParameter("txt_medidas2_pieza");
            String largo = request.getParameter("txt_largo_pieza").isEmpty()?"0":request.getParameter("txt_largo_pieza");
            String planos = request.getParameter("txt_planos_pieza");
            String trabajoRealizar = request.getParameter("txt_trabajo_realizar");
            String rectificadoPrevio = request.getParameter("select_rectificado_previo");
            String rectificadoPrevioen = request.getParameter("txt_rectificadoprevio_en");
            String medidaobtenidarectificadoPrevio = request.getParameter("txt_medida_obtenida_rectprevio").isEmpty()?"0":request.getParameter("txt_medida_obtenida_rectprevio");
            String rectificadoPreviotorno = request.getParameter("txt_torno_rect_previo");
            String rectificadoPreviopor = request.getParameter("txt_tornopor_previo");
            String cromado = request.getParameter("select_cromado");
            String cromadoEn = request.getParameter("txt_cromado_en");
            String cromadoSuperficie = request.getParameter("txt_superficie").isEmpty()?"0":request.getParameter("txt_superficie");
            String cromadoCorriente = request.getParameter("txt_corriente").isEmpty()?"0":request.getParameter("txt_corriente");
            String cromadoTiempo = request.getParameter("txt_tiempo").isEmpty()?"0":request.getParameter("txt_tiempo");
            String cromadoOtroBano = request.getParameter("txt_otro_tratamiento");
            String espesorPedido = request.getParameter("txt_espesor_pedido").isEmpty()?"0":request.getParameter("txt_espesor_pedido");
            String rectificadoFinal = request.getParameter("select_rectificado_final");
            String rectificadoFinalen = request.getParameter("txt_rectificadofinal_en");
            String medidaobtenidarectificadoFinal = request.getParameter("txt_medida_obtenida_rectfinal").isEmpty()?"0":request.getParameter("txt_medida_obtenida_rectfinal");
            String rectificadoFinaltorno = request.getParameter("select_torno_rect_final");
            String rectificadoFinalpor = request.getParameter("txt_tornopor_final");
            String observaciones = request.getParameter("txt_observaciones");
            String inspeccionFinal = request.getParameter("txt_inspeccion_final");
            String tratamientoFinaltermico = request.getParameter("txt_tratamientofinaltermico");
            String codMetalBase = request.getParameter("select_metalbase_piezas");
            String tratamientoTermico = request.getParameter("select_tratamiento_termico");
            String superficieDureza = request.getParameter("select_superficiedureza");
            String superficieEstado = request.getParameter("select_superficieestado");
            String superficieSoldadura = request.getParameter("select_superficiesoldadura");
            String cromadosAnteriores = request.getParameter("txt_cromados_anteriores");
            String presion = request.getParameter("txt_presion");
            String medio = request.getParameter("txt_medio");
            String desgaste = request.getParameter("txt_desgaste");
            String temperatura = request.getParameter("txt_temperatura");
            String suspensionPieza = request.getParameter("txt_suspension");
            String conexionElectrica = request.getParameter("txt_conexion_electrica");
            String piezaMetalbase = request.getParameter("select_metalbase");
            String estado = request.getParameter("txt_estado_piezas");            
            
            String sequencia = request.getParameter("sequencia").equals("undefined") ? "0" : request.getParameter("sequencia");
            
            try{
                _connMy = conexionBD.Conectar((String)s.getAttribute("organizacion")); 
                CallableStatement sp_usu=null;
                                           
                sp_usu = _connMy.prepareCall("{call sp_ordentaller_det(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
                sp_usu.setString(1, opcion);
                sp_usu.setInt(2, Integer.parseInt(numeroOrdenTaller));
                sp_usu.setInt(3,Integer.parseInt(correlativo));
                sp_usu.setString(4, codPieza);
                sp_usu.setInt(5, Integer.parseInt(cantidad));
                sp_usu.setFloat(6, Float.parseFloat(medida1));
                sp_usu.setFloat(7, Float.parseFloat(medida2));
                sp_usu.setFloat(8, Float.parseFloat(largo));
                sp_usu.setString(9, planos);
                sp_usu.setString(10, trabajoRealizar);
                sp_usu.setString(11, rectificadoPrevio);
                sp_usu.setString(12, rectificadoPrevioen);
                sp_usu.setFloat(13, Float.parseFloat(medidaobtenidarectificadoPrevio));
                sp_usu.setString(14, rectificadoPreviotorno);
                sp_usu.setString(15, rectificadoPreviopor);
                sp_usu.setString(16, cromado);
                sp_usu.setString(17, cromadoEn);
                sp_usu.setFloat(18, Float.parseFloat(cromadoSuperficie));
                sp_usu.setFloat(19, Float.parseFloat(cromadoCorriente));
                sp_usu.setString(20, cromadoTiempo);
                sp_usu.setString(21, cromadoOtroBano);
                sp_usu.setFloat(22, Float.parseFloat(espesorPedido));
                sp_usu.setString(23, rectificadoFinal);
                sp_usu.setString(24, rectificadoFinalen);
                sp_usu.setFloat(25, Float.parseFloat(medidaobtenidarectificadoFinal));
                sp_usu.setString(26, rectificadoFinaltorno);
                sp_usu.setString(27, rectificadoFinalpor);
                sp_usu.setString(28, observaciones);
                sp_usu.setString(29, inspeccionFinal);
                sp_usu.setString(30, tratamientoFinaltermico);
                sp_usu.setString(31, codMetalBase);
                sp_usu.setString(32, tratamientoTermico);
                sp_usu.setString(33, superficieDureza);
                sp_usu.setString(34, superficieEstado);
                sp_usu.setString(35, superficieSoldadura);
                sp_usu.setString(36, cromadosAnteriores);
                sp_usu.setString(37, presion);
                sp_usu.setString(38, medio);
                sp_usu.setString(39, desgaste);
                sp_usu.setString(40, temperatura);
                sp_usu.setString(41, suspensionPieza);
                sp_usu.setString(42, conexionElectrica);
                sp_usu.setString(43, estado);
                sp_usu.setString(44, piezaMetalbase);
                sp_usu.setInt(45,Integer.parseInt(sequencia));                
                sp_usu.registerOutParameter(1, Types.VARCHAR);
                
                sp_usu.execute();
                
                if (opcion.equals("insert")) {
                    String valorSalida = sp_usu.getString(1);
                
                    if(valorSalida.equalsIgnoreCase("error ejecucion"))
                    {
                        out.println("Ya existe");
                    }
                }
                
                final ResultSet rs = sp_usu.getResultSet();
                String salida = "";
                if (opcion.equals("select")) {
                    while(rs.next())
                    {
                        salida += rs.getString("cod_pieza") + "|";
                        salida += rs.getString("cantidad") + "|";
                        salida += rs.getString("medida1") + "|";
                        salida += rs.getString("medida2") + "|";
                        salida += rs.getString("largo") + "|";
                        salida += rs.getString("planos") + "|";
                        salida += rs.getString("trabajo_realizar") + "|";
                        salida += rs.getString("rectificado_previo") + "|";
                        salida += rs.getString("rectificado_previo_en") + "|";
                        salida += rs.getString("medida_rectificado_previo") + "|";
                        salida += rs.getString("rectificado_previo_torno") + "|";
                        salida += rs.getString("rectificado_previo_por") + "|";
                        salida += rs.getString("cromado") + "|";
                        salida += rs.getString("cromado_en") + "|";
                        salida += rs.getString("cromado_superficie") + "|";
                        salida += rs.getString("cromado_corriente") + "|";
                        salida += rs.getString("cromado_tiempo") + "|";
                        salida += rs.getString("cromado_otro_bano") + "|";
                        salida += rs.getString("espesor_pedido") + "|";
                        salida += rs.getString("rectificado_final") + "|";
                        salida += rs.getString("rectificado_final_en") + "|";
                        salida += rs.getString("medida_rectificado_final") + "|";
                        salida += rs.getString("rectificado_final_torno") + "|";
                        salida += rs.getString("rectificado_final_por") + "|";
                        salida += rs.getString("observacion") + "|";
                        salida += rs.getString("inspeccion_final") + "|";
                        salida += rs.getString("tratamiento_final_termico") + "|";
                        salida += rs.getString("cod_metalbase") + "|";
                        salida += rs.getString("tratamiento_termico") + "|";
                        salida += rs.getString("superficie_dureza") + "|";
                        salida += rs.getString("superficie_estado") + "|";
                        salida += rs.getString("superficie_soldadura") + "|";
                        salida += rs.getString("cromados_anteriores") + "|";
                        salida += rs.getString("presion") + "|";
                        salida += rs.getString("medio") + "|";
                        salida += rs.getString("desgaste") + "|";
                        salida += rs.getString("temperatura") + "|";
                        salida += rs.getString("suspension_pieza") + "|";
                        salida += rs.getString("conexion_electrica") + "|";
                        salida += rs.getString("pieza_estado") + "|";
                        salida += rs.getString("desc_pieza") + "|";
                        salida += rs.getString("metalbase") + "|";
                        //salida += rs.getString("nombre") + "|";                        
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

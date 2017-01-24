function ModificaFactura(id)
{
    desmarca_registro_factura();
    if($("#habilitaFactura").val() == 0)
    {
        $("#filaFactura"+id).css("background-color","#58FAF4").removeClass("alt");        
        $("#habilitaFactura").val("1");
        $("#nroFactura").val($("#numFactura"+id).text());
    }
}
function desmarca_registro_factura()
{
    $("#corrCotiza").val("");
    var td = $('#tblFactura').children('tbody').children('tr').length;           
    for(var i = 0; i<=td;i++)
    {                
        if(i % 2 === 0)
        {
            $("#filaFactura"+i).addClass("alt");
        }
        if(i % 2 != 0)
        {                    
            $("#filaFactura"+i).css("background-color","white");
        }
    }
    $("#btn_actComercial_Modifica").show();
    $("#habilitaFactura").val("0");
}

function CargaClienteFactura()
{
    var text = $("#select_cliente_filter option:selected").text();    
    var nomCli= text.substring(20,text.length);
    var cliente = "";
    cliente = $("#select_cliente_filter").val();
    $("#txt_factura_rutcli").val(cliente);
    $("#txt_factura_cli").val(nomCli);
}

function CargaTMPGD()
{
    var flag = "";
    var nroGuia = "";
    var nroFilas = "";
    var Secuencia = $('#secuencia').val();
    
    $('.checkboxguias').each(function () {
        nroGuia = $(this).attr("name");
        flag = "cargaTMPGD";
        
        if(this.checked){
            $.ajax({
                url : 'ServletFacturaGDtmp', 
                data: "flag="+flag+"&nroGuia="+nroGuia+"&secuencia="+Secuencia,
                type : 'POST',
                dataType : "html",
                success : function(data) {
                    nroFilas = $("#tblGuiaDespTMP").children('tbody').children('tr').length;
                    if (nroFilas%2 == 0)            
                        $("#tblGuiaDespTMP").append(data);
                    else
                        $("#tblGuiaDespTMP").append(data);
                }
            });
        
            flag = "cargaDetalleFactura";
            $.ajax({
                url : 'ServletFacturaGDtmp', 
                data: "flag="+flag+"&nroGuia="+nroGuia,
                type : 'POST',
                dataType : "html",
                success : function(data) {
                    nroFilas = $("#tblDetalleFactura").children('tbody').children('tr').length;
                    $("#tblDetalleFactura").append(data);               
                }
            });
        }
    });
}

function selectAllchk(){
    
    if($("#select_all").is(':checked')) {
        $(".checkboxguias").prop('checked', true);
    } else {
        $(".checkboxguias").prop('checked', false);
    }
}

function CargaTMPGDModifica(nroGuia)
{
    var flag = "cargaTMPGD";
    
    var nroFilas = "";    
    $.ajax({
        url : 'ServletFacturaGDtmp', 
        data: "flag="+flag+"&nroGuia="+nroGuia,
        type : 'POST',
        dataType : "html",
        success : function(data) {            
            nroFilas = $("#tblGuiaDespTMP").children('tbody').children('tr').length;
            $("#select_factura_tmpGuia_filter").children('option').remove();
            if (nroFilas%2 == 0)            
                $("#tblGuiaDespTMP").append("<tr id='filaGD"+nroGuia+"'>"+data+"</tr>");
            else
                $("#tblGuiaDespTMP").append("<tr id='filaGD"+nroGuia+"'>"+data+"</tr>");
            
        }
    });
    flag = "cargaDetalleFactura";
    $.ajax({
        url : 'ServletFacturaGDtmp', 
        data: "flag="+flag+"&nroGuia="+nroGuia,
        type : 'POST',
        dataType : "html",
        success : function(data) {            
            nroFilas = $("#tblDetalleFactura").children('tbody').children('tr').length;
                $("#tblDetalleFactura").append(data);                        
        }
    });
}


function SeleccionGD(nroGuia)
{
    desSeleccionGD(nroGuia);
    if($("#hid"+nroGuia).val() == 0)
    {
        $("#filaGD"+nroGuia).css("background-color","#58FAF4");        
        $("#hid"+nroGuia).val("1");
        $("#btnTmpGD").hide();
        $("#btnCancelarGD").show();
        $("#eliminaGD").show();
        $("#guiaDespachoHid").val(nroGuia);        
    }
}

function desSeleccionGD(nroGuia)
{
    var td = $('#tblGuiaDespTMP').children('tbody').children('tr').length;    
    $('#tblGuiaDespTMP').children('tbody').children('tr').css("background-color","white");        
    $("#eliminaGD").hide();
    $("#btnCancelarGD").hide();
    $("#btnTmpGD").show();
    $("#hid"+nroGuia).val("0");
}

function eliminaGD()
{
    var nroGuia = $("#guiaDespachoHid").val();
    var secuencia = $("#secuencia").val();
    var flag = "eliminaTmp";
    $('#filaGD'+nroGuia).remove();
    $(".filaDetalle"+nroGuia).each(function() {
        $( this ).remove();
    });
    
    $.ajax({
        url : 'ServletFacturaGDtmp', 
        data: "flag="+flag+"&secuencia="+secuencia+"&nroGuia="+nroGuia,
        type : 'POST',
        dataType : "html",
        success : function(data) {
        }
    });
    
    $("#eliminaGD").hide();
    $("#btnCancelarGD").hide();
    $("#btnTmpGD").show();
}

function cargaGuiasI(){
    
    var cliente = $("#txt_factura_rutcli").val();
    var secuencia = $("#secuencia").val();
    var guia = $("#txt_factura_filtro_guia").val();
    var arr = cliente.split('-');
    
    var flag = "guiasNofactI";
    $.ajax({
        url : 'ServletFacturaGDtmp', 
        data: "flag="+flag+"&cliente="+arr[0]+"&secuencia="+secuencia+"&guia="+guia,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tblGuiaDespSelec tbody tr").remove();
            $("#tblGuiaDespSelec tbody").html(data);
        }
    });
}

function cargaGuiasM(){
    
    var cliente = $("#txt_factura_rutcli").val();
    var secuencia = $("#secuencia").val();
    var nrofactura = $("#txt_factura_numero").val();
    var guia = $("#txt_factura_filtro_guia").val();
    var arr = cliente.split('-');
    
    var flag = "guiasNofact";
    $.ajax({
        url : 'ServletFacturaGDtmp', 
        data: "flag="+flag+"&cliente="+arr[0]+"&secuencia="+secuencia+"&nroFact="+nrofactura+"&guia="+guia,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#tblGuiaDespSelec tbody tr").remove();
            $("#tblGuiaDespSelec tbody").html(data);
        }
    });
}

function grabar(){
    
    var nrofact = "";
    var fechfact = $("#txt_factura_fecha" ).val();
    var formpago = $("#slt_factura_formaPago" ).val();
    var excenta = $("#slt_factura_excenta" ).val();
    var adicional = $("#select_factura_adicional" ).val();
    var coment = $("#txt_factura_comentario" ).val();
    var rutclientetmp = $("#txt_factura_rutcli" ).val();
    var nombcliente = $("#txt_factura_cli" ).val();
    
    var arrcliente = rutclientetmp.split("-");
    var rutcliente = arrcliente[0];
    
    if(coment == ""){
        $("#txt_factura_comentario").focus();
        openDialog("Debe ingresar un comentario");
        return false;
    }
    
    var guia = "";
    var flag = "validGuia";
    var rowCount = $('#tblGuiaDespTMP tbody tr').length;
    var secuencia = $('#secuencia').val();
    
    if(rowCount <= 0){
        openDialog("Debe al menos seleccionar una guia de despacho");
        return false;
    }
    
    var valida = true;
    
    $('#tblGuiaDespTMP tbody tr').each(function () {
        guia = $(this).find("input").val();
        $.ajax({
            url : 'ServletFacturaGDtmp', 
            data: "flag="+flag+"&nroGuia="+guia,
            type : 'POST',
            dataType : "html",
            success : function(data) {
                if(data != "OK"){
                    valida = false;
                }
            }
        });
    });
    
    if(!valida){
        openDialog("La guia de despacho, ya se encuentra asociada a una factura");
        return false;
    }
    
    flag = "ingresofact";
    
    $.ajax({
        url : 'ServletFacturaGDtmp', 
        data: "flag="+flag+"&fecha_emision="+fechfact+"&pago="+formpago+"&excent="+excenta+"&adic="+adicional+"&coment="+coment+"&rcliente="+rutcliente+"&ncliente="+nombcliente+"&secuencia="+secuencia,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            
            nrofact = data;
            
            if (nrofact != ""){
                flag = "ingresoGuiaFact";
    
                $.ajax({
                    url : 'ServletFacturaGDtmp', 
                    data: "flag="+flag+"&nroFact="+nrofact+"&secuencia="+secuencia,
                    type : 'POST',
                    dataType : "html",
                    success : function(data) {
                    }
                });
                
                alert("Ingreso OK, Factura numero: "+nrofact);
                location.href = "svm_Seleccion_Factura.jsp";
            }
        }
    });
}

function grabarActualiza(){
        
    var nrofact = $("#txt_factura_numero" ).val();
    var fechfact = $("#txt_factura_fecha" ).val();
    var formpago = $("#slt_factura_formaPago" ).val();
    var excenta = $("#slt_factura_excenta" ).val();
    var adicional = $("#select_factura_adicional" ).val();
    var coment = $("#txt_factura_comentario" ).val();
    var rutclientetmp = $("#txt_factura_rutcli" ).val();
    var nombcliente = $("#txt_factura_cli" ).val();
    
    var arrcliente = rutclientetmp.split("-");
    var rutcliente = arrcliente[0];
    
    if(coment == ""){
        $("#txt_factura_comentario").focus();
        openDialog("Debe ingresar un comentario");
        return false;
    }
    
    var guia = "";
    var flag = "validGuiaActualiza";
    var secuencia = $('#secuencia').val();
    var rowCount = $('#tblGuiaDespTMP tbody tr').length;
    
    if(rowCount <= 0){
        openDialog("Debe al menos seleccionar una guia de despacho");
        return false;
    }
    
    var valida = true;
    
    $('#tblGuiaDespTMP tbody tr').each(function () {
        guia = $(this).find("input").val();
        $.ajax({
            url : 'ServletFacturaGDtmp', 
            data: "flag="+flag+"&nroGuia="+guia+"&secuencia="+secuencia,
            type : 'POST',
            dataType : "html",
            success : function(data) {
                if(data != "OK"){
                    valida = false;
                }
            }
        });
    });
    
    if(!valida){
        openDialog("La guia de despacho, ya se encuentra asociada a una factura");
        return false;
    }

    flag = "actulizafact";
    
    $.ajax({
        url : 'ServletFacturaGDtmp', 
        data: "flag="+flag+"&fecha_emision="+fechfact+"&pago="+formpago+"&excent="+excenta+"&adic="+adicional+"&coment="+coment+"&rcliente="+rutcliente+"&ncliente="+nombcliente+"&nroFact="+nrofact+"&secuencia="+secuencia,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            
            flag = "ingresoGuiaFact";
            $.ajax({
                url : 'ServletFacturaGDtmp', 
                data: "flag="+flag+"&nroFact="+nrofact+"&secuencia="+secuencia,
                type : 'POST',
                dataType : "html",
                success : function(data) {
                }
            });

            alert("Actualizado correctamente, Factura numero: "+nrofact);
            location.href = "svm_Seleccion_Factura.jsp";
        }
    });
}

function goBack(){
    location.href='svm_Seleccion_Factura.jsp';
}
function loadDialogGuias(){
    $( '#dialog_guias' ).dialog( "open" );
}
function loadDialogClientes(){
    $( '#dialog_clientes' ).dialog( "open" );
}

function openDialog(msg){
    $('#dialog_msg').html("");
    $('#dialog_msg').html("<p>"+msg+"</p>");
    $('#dialog_msg').dialog('option', 'position', 'center');
    $('#dialog_msg').dialog( "open" );
}

function cargaClientes(){
    
    var flag = "selectClientes";
    var rcliente = $("#txt_filtro_cliente_rut").val();
    var cliente = $("#txt_filtro_cliente_nombre").val();
    $.ajax({
        url : 'ServletFacturaGDtmp', 
        data: "flag="+flag+"&rcliente="+rcliente+"&cliente="+cliente,
        type : 'POST',
        dataType : "html",
        success : function(data) {
            $("#select_cliente_filter option").remove();
            $("#select_cliente_filter").html(data);
        }
    });
}
$('.data-table').dataTable({
	"bStateSave": true,
	"language": {
    	"decimal": ",",
    	"sSearch": "Buscar:",
    	"thousands": ".",
    	"lengthMenu": "Mostrando _MENU_ registros por página",
    	"zeroRecords": "Nada foi encontrado - Desculpe",
    	"info": "Mostrando página _PAGE_ de _PAGES_",
    	"infoEmpty": "Não há registros disponíveis",
    	"infoFiltered": "(Filtrando de _MAX_ total de registros)"            
	},
	"columnDefs": [{ "targets": [ 0, 1, 2 ], "orderable": false }],
	"aoColumnDefs": [{ 'bSortable': false, 'aTargets': [ 0,1,2 ] }],
	"displayLength": 50
});

$('#participante_cpf').inputmask("999.999.999-99");
$('#participante_telefone_residencial').inputmask("(99)9999-9999");
$('#participante_telefone_celular').inputmask("(99)9999-99999");
$('#participante_cep').inputmask("99.999-999");
$(".form-horizontal .form-group").css( { marginLeft : "0px", marginRight : "0px" } );

$(document).on('nested:fieldAdded', function(event){
    var field = event.field;
    var data_nascimento = field.find('.datepicker');

    data_nascimento.datepicker();

    $(".form-horizontal .form-group").css( { marginLeft : "0px", marginRight : "0px" } );
});
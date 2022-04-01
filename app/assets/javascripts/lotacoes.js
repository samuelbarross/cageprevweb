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
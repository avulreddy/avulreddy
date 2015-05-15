$(document).ready(function(){
	$('input[name="paymentType"]').click(function(){
		if($.trim($(this).val())!=""){
			$('div[class*="div_"]:not(div[class*="div_'+$.trim($(this).val())+'"])').addClass('hide');
			$('div[class*="div_'+$.trim($(this).val())+'"]').removeClass('hide');
		}
	});	
});
	
	
function submitForm(button) {
	var form = $("#formId");
	var url = form.attr('action');
	var method = form.attr('method');
	method = method ? method : "GET";
	var param = {};
	$(form).find('input').each(function() {
		var value = $(this).val();
		var name = $(this).attr("name");
		var restful = $(this).attr("restful");
		if (restful) {
			console.log("restful:" + restful)
			url = url.replace('{' + restful + '}', value);
		}
		else {
			param[name] = value;
		}
	});
	$.ajax({
		type : method,
		url : url,
		data : param,
		dataType : "text",
		success : function(data) {
			console.log(data);
			$(form).find(".result_div").width(400);
			$(form).find(".result_div").text(data);
		}
	});
}



function fileTypeChange(value,fileId) {
	$("#"+ fileId).val(value);
}
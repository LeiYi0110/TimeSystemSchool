$(function(){
	if(sessionStorage.getItem('tabId')){
		sessionStorage.removeItem('tabId');
	}
	
	 var urlstr = location.href.split('/');
	  var urlstatus=false;
	  $(".NavTxt li a").each(function () {
		  var active = $(this).attr('href').split('/');
		  if(urlstr[urlstr.length-1] === active[active.length-1]){
			  if(active[active.length-1] !== 'development'){
				  $(this).addClass('hover');
			  } 
		  }
	  });
	
	$(".NavTit").click(function(){
		var i = $(".NavTit").index(this);
	    $(".NavTxt").eq(i).toggle('300');
	});	
	
	$(".valid-form").Validform({
		tiptype:4,
		showAllError:false
	});
	
	var datatype = $(".valid-form [datatype]").prev('label,span');
	for(var i=0; i<datatype.length; i++){
		datatype.eq(i).prepend('<span class="need">*</span>');
	};
	var datatypeParent = $(".valid-form [datatype]").parent();
	for(var i=0; i<datatypeParent.length; i++){
		if( datatypeParent.eq(i).is('label') === true ){
			datatypeParent.eq(i).prepend('<span class="need">*</span>');
		}
	};
	
	
	$('[data-dismiss="modal"]').click(function(){
		var tool = new toolCtrl();
		tool.clearForm();
	});
	
	
	$(".dropdown, .dropdown > .dropdown-ul").hover(function(){
		$(this).addClass('hover');
		$(this).children('.dropdown-ul').slideDown(300);
	},function(){
		$(this).removeClass('hover');
		$(this).children('.dropdown-ul').slideUp(300);
	})
	
	if($(window).scrollTop() > 61){
		$(".select-top").css('top','0px');
	}else{
		$(".select-top").css('top',61-$(window).scrollTop()+'px');
	};

	
	
	if($(".select-top").length !== 0){
		$(window).scroll(function(){
			var sTop = $(this).scrollTop();
			if( sTop < 58 ){
				$(".select-top").css('top',61-sTop+'px');
			}else{
				$(".select-top").css('top','0px');
			}
		})
	}
	

});


// 工具类的集合
function toolCtrl(){
	return{
		// 清除表单中的值
		clearForm: function(){
			$('input[type="text"],input[type="password"],input[type="file"],textarea').val("");
			$('input[type="checkbox"]').each(function(){
				$(this).prop("checked",false);
			});
			$(".valid-form").Validform().resetForm();
			$(".Validform_checktip").html("");
			
			
		},
		
		//清除选单行
		clearRow: function(){
			$(".gri_tr_clicked").removeClass('gri_tr_clicked');
			sessionStorage.removeItem('tabId');
		}
	}
};




/**     
* 对Date的扩展，将 Date 转化为指定格式的String     
* 月(M)、日(d)、12小时(h)、24小时(H)、分(m)、秒(s)、周(E)、季度(q) 可以用 1-2 个占位符     
* 年(y)可以用 1-4 个占位符，毫秒(S)只能用 1 个占位符(是 1-3 位的数字)     
* eg:     
* (new Date()).pattern("yyyy-MM-dd hh:mm:ss.S") ==> 2006-07-02 08:09:04.423     
* (new Date()).pattern("yyyy-MM-dd E HH:mm:ss") ==> 2009-03-10 二 20:09:04     
* (new Date()).pattern("yyyy-MM-dd EE hh:mm:ss") ==> 2009-03-10 周二 08:09:04     
* (new Date()).pattern("yyyy-MM-dd EEE hh:mm:ss") ==> 2009-03-10 星期二 08:09:04     
* (new Date()).pattern("yyyy-M-d h:m:s.S") ==> 2006-7-2 8:9:4.18     
*/   
Date.prototype.pattern=function(fmt) {         
    var o = {         
    "M+" : this.getMonth()+1, //月份         
    "d+" : this.getDate(), //日         
    "h+" : this.getHours()%12 == 0 ? 12 : this.getHours()%12, //小时         
    "H+" : this.getHours(), //小时         
    "m+" : this.getMinutes(), //分         
    "s+" : this.getSeconds(), //秒         
    "q+" : Math.floor((this.getMonth()+3)/3), //季度         
    "S" : this.getMilliseconds() //毫秒         
    };         
    var week = {         
    "0" : "/u65e5",         
    "1" : "/u4e00",         
    "2" : "/u4e8c",         
    "3" : "/u4e09",         
    "4" : "/u56db",         
    "5" : "/u4e94",         
    "6" : "/u516d"        
    };         
    if(/(y+)/.test(fmt)){         
        fmt=fmt.replace(RegExp.$1, (this.getFullYear()+"").substr(4 - RegExp.$1.length));         
    }         
    if(/(E+)/.test(fmt)){         
        fmt=fmt.replace(RegExp.$1, ((RegExp.$1.length>1) ? (RegExp.$1.length>2 ? "/u661f/u671f" : "/u5468") : "")+week[this.getDay()+""]);         
    }         
    for(var k in o){         
        if(new RegExp("("+ k +")").test(fmt)){         
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));         
        }         
    }         
    return fmt;         
}



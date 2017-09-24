/**
 * @description MTA 全局对象，负责前端的交互组织
 * @namespace 全局的命名空间
 */
MTA = window.MTA || {};

MTA.Page = MTA.Page || {};
//页面条件
MTA.Page.Condition = MTA.Page.Condition || {};
//渠道、版本等选择器
MTA.Page.Options = MTA.Page.Options || {};
//页面需要额外传递的url参数
MTA.Page.Params = MTA.Page.Params || {};

MTA.Page.Variable = MTA.Page.Variable || {};

/*
 * MTA常量配置
 */
MTA.Constant = {
    DOMAIN_TYPE_INTRANET: 1,        //内网环境
    DOMAIN_TYPE_INTERNET: 2         //外网环境
};

/**
 * @namespace MTA配置对象,定义全局变量
 */
MTA.Config = {
	RootPath : '',
    	DomainType: MTA.Constant.DOMAIN_TYPE_INTRANET,  //网站类型，为内网或外网
	//全部渠道，全部版本，全部浏览器等selector的选项的值是0，对应关系配置
	Selector : {
		allSuffix : '0',
		map : {
			'channel' : '渠道',
			'version' : '版本'
		}
	},
	//设置图例 & 设置表格 选择器
	optsGroup : {
		'channel' : {
			'chart' : {
				'chart_channel_group' : {
					main : 'split',
					minor : 'other'
				},
				main_name : 'chart_channel_group_split',
				minor_name : 'chart_channel_group_other'
			},
			'table' : {
				'table_channel_group' : {
					main : 'split',
					minor : 'other'
				},
				main_name : 'table_channel_group_split',
				minor_name : 'table_channel_group_other'
			}
		},
		'version' : {
			'chart' : {
				'chart_version_group' : {
					main : 'split',
					minor : 'other'
				},
				main_name : 'chart_version_group_split',
				minor_name : 'chart_version_group_other'
			},
			'table' : {
				'table_version_group' : {
					main : 'split',
					minor : 'other'
				},
				main_name : 'table_version_group_split',
				minor_name : 'table_version_group_other'
			}
		},
		//需要激活的选择器ID
		need_trigger : 'chart_calc_sum'
	},
	//菜单样式对应关系配置
	menuClaMap : {
		0 : 'icon_overview',
		1 : 'icon_app',
		2 : 'icon_channel',
		3 : 'icon_run',
		4 : 'icon_user',
		5 : 'icon_setting',
        6 : 'icon_netspeed',
        7 : 'icon_develop',
        8 : 'icon_admin'
	},
	//平台编码与样式的对应关系配置
	platformMap : {
		11 : {
            'icon_css': 'icon-platform-android',
            'icon_class': 'icon_android',
			'css' : 'android',
			'desc' : 'Android',
            'sdkPath': '/resource/download/MTA-android-sdk-1.6.2.zip'
		},
		12 : {
            'icon_css': 'icon-platform-iphone',
            'icon_class': 'icon_ios',
			'css' : 'ios',
			'desc' : 'iOS',
            'sdkPath': '/resource/download/MTA-ios-sdk-1.2.7.zip'
		},
		13 : {
            'icon_css': 'icon-platform-windows',
            'icon_class': 'icon_windows',
			'css' : 'windows',
			'desc' : 'Windows Phone',
            'sdkPath': ''
		},

		31 : {
            'icon_css': 'icon-platform-android',
            'icon_class': 'icon_android',
			'css' : 'android',
			'desc' : 'Android',
            'sdkPath': '/resource/download/MTA-android-sdk-1.6.2.zip'
		},
		32 : {
            'icon_css': 'icon-platform-iphone',
            'icon_class': 'icon_ios',
			'css' : 'ios',
			'desc' : 'iOS',
            'sdkPath': '/resource/download/MTA-ios-sdk-1.2.7.zip'
		},
		33 : {
            'icon_css': 'icon-platform-windows',
            'icon_class': 'icon_windows',
			'css' : 'windows',
			'desc' : 'Windows Phone',
            'sdkPath': ''
		}
	},
	loadPath : function(path) {
		this.RootPath = path;
	},
	systemInfo : [
        {
			seq : '20130907',
			msg : '云标签功能即将开放，请您关注！',
			valid : 1
		},
        {
			seq : '20130905',
			msg : '9.5-9.7实时数据算法优化，将影响活跃用户与QQ用户分布，请您关注。',
			valid : 0
		},
		{
			seq : '20130722',
			msg : '新功能上线！渠道概况，效果跟踪功能发布，欢迎体验！',
			valid : 0
		},
		{
			seq : '20130314',
			msg : '新功能上线！页面分析，用户画像功能发布，欢迎体验。',
			valid : 0
		},
		{
			seq : '2013005',
			msg : '腾讯分析移动统计新鲜出炉，欢迎体验。',
			valid : 0
		}
	],
	wording : {
		staffSelector : '请输入英文名查找'

	},
	theme : 'ta'
};

/**
 * @namespace MTA工具类，获取相关的全局数据变量
 */
MTA.Util = {
	
	/**
	 * @description 增加面包线接口
	 * @param array entity 是一个面包条导航的层级对象数组
	 * @example MTA.Util.navigation([{'name':'自定义事件', 'href':''},{....}]);
	 */
	navigation : function(entity){
		var id = 'sp_navigation', doc ='';
		var first = '<a href="#"><i class="icon_customevt"></i>自定义事件</a>';
		$('#'+id).length > 0 && function(){
			for(var i = 0; i<entity.length; i++){
				if(entity[i].href){
					doc += '<a href="' + entity[i].href +'" id=lnk_event><i class="icon_customevt"></i>'+entity[i].name+'</a>&gt;';
				}
				else
					doc += '&nbsp;<span>'+entity[i].name+'</span>';
			}
			$('#'+id).html(doc).show();
		}();
	},
	
	/**
	 * 判断一个对象是否为空对象
	 */
	isEmptyObj : function(obj){
		for(var name in obj) { 
			return false; 
		} 
			return true; 
	},
	/**
	 * @description 设置图例/设置表格选择器的值拼接成参数。
	 */
	getOptions : function(params, caller) {
		var _opts = MTA.Page.Options, opts = [];
		for(var o in _opts) {
			if(_opts[o].current && _opts[o].bind == caller) {
				opts = _opts[o].optsList;
				break;
			}
			if(_opts[o].bind == caller) {
				opts = _opts[o].optsList;
			}
		}opts.length > 0 && function() {
			for(var i = 0; i < opts.length; i++) {
				var pair = opts[i].split(':');
				params[pair[0]] = pair[1];
			}
		}();
		return params;
	},
	/**
	 * @description 渠道/版本/浏览器等选择器的选中
	 */
	getConditions : function(params) {
		MTA.Page.Condition && function() {
			for(var o in MTA.Page.Condition) {
				params[o + '_list'] = encodeURIComponent(MTA.Page.Condition[o].getValue());
				params[o + '_show'] = encodeURIComponent(MTA.Page.Condition[o].show);
			}
		}();
		return params;
	},
	/**
	 * @description 获取当前appid
	 */
	getAppId : function() {
		//前台接口已经写好
		return (MTA.Page.app && MTA.Page.app.getAppInfo().appId);
		//return '';
	},
    /*
     * @description 判断当前App是否为演示App
     */
    isDemoApp: function(){
        var appId = this.getAppId();
        return appId <= 100;
    },
	/**
	 * @description 获取当前去掉值
	 */
	getPortalId : function() {
		return '';
	},
	/**
	 * @description 点击指定按钮，弹出或隐藏浮层
	 * @param {Object} btn 按钮
	 * @param {Object} ctn 浮层容器（包括按钮+浮层）
	 * @param {Object} wrap 浮层
	 * @example
	 MTA.Util.popup('i_pop_user', 'div_pop_user', 'wrap_pop_user');
	 */
	popup : function(btn, ctn, wrap, css) {
		css = css || 'open';
		var ITEMS_TIMEOUT = null, time_out = 500;

		function hidePop() {
			$('#' + ctn).removeClass(css);
		}

		function showPop() {
			$('#' + ctn).addClass(css);
		}

		function isPopShow() {
			return $('#' + ctn).attr('class') == css;
		}


		$("#" + btn).click(function() {isPopShow() ? hidePop() : showPop();
		}).mouseover(function() {
			clearTimeout(ITEMS_TIMEOUT);
		}).mouseout(function() {
			ITEMS_TIMEOUT = setTimeout(hidePop, time_out);
		});

		$('#' + wrap).mouseover(function() {
			clearTimeout(ITEMS_TIMEOUT);
		}).mouseout(function() {
			ITEMS_TIMEOUT = setTimeout(hidePop, time_out);
		});
	},
	
	/**
	 *  @description 页面内指定按钮统计
	 */
	hotClick : function(hottag, loc) {
		var base = 'http://pinghot.' + (new RegExp(/qq.com/).test(MTA.Util.parse_url().host) ? 'qq' : 'oa') + '.com/pingd?';
		var url = ['dm=' + MTA.Util.parse_url().host + '.hot', 'url=' + MTA.Util.parse_url().path, 'hottag=' + escape(hottag), 'hotx=9999&hoty=9999', 'rand=' + Math.round(Math.random() * 100000)].join('&');
		(new Image(1, 1)).src = base + url;
		//如果有跳转 ， 延迟200ms
		loc && function() {
			setTimeout(function() {
				window.location.href = loc;
				return false;
			}, 200);
		}();

	},
	
	/**
	 * @description 设置额外的url参数接口
	 */
	setParams : function(key, value) {
		// if(MTA.Page.Params[key])
			// MTA.Page.Params[key] = '';
		MTA.Page.Params[key] = value;
	},

	clearParams : function(id){
		if(id){
			delete MTA.Page.Params[id];
			return true;
		}
		MTA.Page.Params = {};
		//MTA.Page.Variable = {};
	},
	
	array2UrlParams : function(params){
	    var paramsArray = [];
	    for (var name in params) {
	        if (paramsArray.length == 0) {
	            paramsArray.push("?");
	        }
	        else {
	            paramsArray.push("&");
	        }
	        paramsArray.push(name);
	        paramsArray.push("=");
	        paramsArray.push(params[name]);
	    }
	    return paramsArray.join("");
	},
	
	/**
	 * @description 消息提示小黄条的内容接口接口
	 */
	tips : {
		conf : {
			container : 'sp_tips_info',
			close : 'a_tips_close',
			close_cla : 'message-close',
			timeout : 1000
		},
		show : function(cont, id) {
			$('#' + this.conf.container).html(cont).parent().show();
			$('#' + this.conf.close).attr('sequence', id).bind('click', this.hide);

		},
		hide : function() {
			$(this).parent().fadeOut(500);
			GRI.Util.cookie.save('_rk_closed_sysmsg', $(this).attr('sequence'), 'Sun, 18 Jan 2038 00:00:00 GMT;');
		}
	},

	/**
	 * @description 所有需要大小图切换的页面使用初始化和事件绑定类
	 * @author johnnyzheng(johnnyzheng@tencent.com)
	 */
	view_switcher : {
		cgi : {},
		hdl : null,
		container : 'div_item_tabs',
		/**
		 * 初始化视图切换初始化方法
		 * @param {Object} 加载视图的cgi地址
		 * @param {Object} 回调函数
		 * @return 
		 */
		init : function(cgi_conf, hdl) {
			this.cgi = cgi_conf; 
			this.hdl = hdl;
			this.tabInit();
			//点击查看大图,初始化选中状态:默认选中第一个
			MTA.Page.Variable.tab_url = cgi_conf[1];
			MTA.Page.Variable.tab_id = 1;
			//eval(this.hdl + '()');
			$('#' + this.container).find('li').first().addClass("active").siblings().removeClass('active');
		},
		
		/**
		 * 图上的小title进行点击切换 老版本中大小图切换的clickAction
		 */
		clickAction : function(id){
			this.activateTab(id);
			eval(this.hdl + '()');
		},
		activateTab:function(id){
			MTA.Page.Variable.tab_url = this.cgi[id];
			MTA.Page.Variable.tab_id = id;
			$('#div_item_tabs a[id="tab_'+ id +'"]').parent().addClass('active').siblings().removeClass('active');
		},
		/**
		 * tab标签的点击事件初始化
		 */
		tabInit : function(){
			var self = this;
			$('#'+ self.container).find('a').each(function() {
				var id = $(this).attr('id').match(/tab_(\d{1,2})/i)[1];
				$(this).bind('click', function() {
					MTA.Page.Variable.tab_url = self.cgi[id];
					MTA.Page.Variable.tab_id = id;
                    $(this).parent().addClass('active').siblings().removeClass('active');
					eval(self.hdl + '()');
				});
			});
		}	
		
	},
	/**
	 *  tab 切换，不做参数设置
	 */
	tab_switcher : {
		cgi : {},
		hdl : null,
		container : 'div_item_tabs',
		active_tab_url:null,
		active_tab_id:1,
		/**
		 * 初始化视图切换初始化方法
		 * @param {Object} 加载视图的cgi地址
		 * @param {Object} 回调函数
		 * @return 
		 */
		init : function(container,cgi_conf, hdl) {
			this.cgi = cgi_conf; 
			this.hdl = hdl;
			this.container = container;
			this.tabInit();
			//点击查看大图,初始化选中状态:默认选中第一个
			this.active_tab_url = cgi_conf[1];
			this.active_tab_id = 1;
			//eval(this.hdl + '()');
			$('#' + this.container).find('li').first().addClass("active").siblings().removeClass('active');
		},
		initTab : function(container,cgi_conf, hdl) {
			this.cgi = cgi_conf; 
			this.hdl = hdl;
			this.container = container;
			this.tabInit();
			//点击查看大图,初始化选中状态:默认选中第一个
			this.active_tab_url = cgi_conf[2];
			this.active_tab_id = 2;
			//eval(this.hdl + '()');
			$('#' + this.container).find('li').last().addClass("active").siblings().removeClass('active');
		},
		/**
		 * 图上的小title进行点击切换 老版本中大小图切换的clickAction
		 */
		clickAction : function(id){
			this.active_tab_url = this.cgi[id];
			this.active_tab_id = id;
			eval(this.hdl + '('+ this.active_tab_id +',\''+ this.active_tab_url +'\')');
			$('#' + this.container + ' a[id="tab_'+ id +'"]').parent().addClass('active').siblings().removeClass('active');
		},
		
		/**
		 * tab标签的点击事件初始化
		 */
		tabInit : function(){
			var self = this;
			$('#'+ self.container).find('a').each(function() {
				var id = $(this).attr('id').match(/tab_(\d{1,2})/i)[1];
				$(this).bind('click', function() {
					self.active_tab_url = self.cgi[id];
					self.active_tab_id = id;
                    $(this).parent().addClass('active').siblings().removeClass('active');
					eval(self.hdl + '('+ self.active_tab_id +',\''+ self.active_tab_url +'\')');
				});
			});
		}	
		
	},
	/**
	 * 创建用户群下拉选择框
	 */
	createUserGroup : function(id, json, callback, extra){
		var source = {}, target = id || 'btn_user_group';
		json && function(){
			for(var o in json){
				source[json[o].value] = json[o].name;
			}
		}();
		$('#'+ target).parent().show();
		var user_group = new GRI.DropdownList(target, 
											  source, 
											  true, 
											  {
											   'footer_link': MTA.Config.RootPath + '/custom/ctr_group/list_all?app_id='+MTA.Page.app.appId, 
											   'footer_text' : '添加更多用户群',
											   'default':{key : 0, name: '全部用户'}
											  }, 
											  function(){
												  	$('#'+target).length > 0 && $('#'+target+' span').text(user_group.selected.name);
												  	MTA.Util.clearParams('group_id');
												  	MTA.Util.setParams('group_id', user_group.selected.key);
												  	callback && callback();
											  }
		);	
	
		MTA.Util.setParams('group_id', user_group.selected.key);	
		$('#'+target).parent().show();
	},
	
	/**
	 * @description 页面的指标信息的展示对象
	 * @author johnnyzheng(johnnyzheng@tencent.com)
	 */
	items_info : {
		conf :{
			container : 'wrap_items_info',
			icon : 'icon_items_info',
			popup : 'pop_items_info',
			footer : 'footer_items_info',
            showType: 'dialog',              //指标说明显示的位置
            dialogWrap: 'wrap_items_info_help',
            dialogIcon: 'icon_items_info_help'
		},
		init : function(items, theme, footerInfo){
			if(!items){
                return;
            }

            if ('wechat' == theme){
                this.showInLayer(items, theme, footerInfo);
            }else if (this.conf.showType == 'dialog'){
                this.showInDialog(items, theme, footerInfo);
            }else{
                this.showInLayer(items, theme, footerInfo);
            }
		},
        getFooterInfo: function(theme, footerInfo){
            return ('wechat' == theme)? '<span class="wechat_data_range">数据从2013年7月1日开始统计。</span>由于服务器缓存，以及指标计算方法和统计时间的差异，数据可能出现微小误差，一般在1%以内。':
            ('game' == theme)? '游戏分析使用游戏内帐号ID而不是设备来判断账号的唯一性。':
            ('qc' == theme)? footerInfo :
            (MTA.Page.app.portalId == 11 || MTA.Page.app.portalId == 31)? '腾讯云分析使用IMEI+网卡MAC地址判断Android用户设备的唯一性。': '腾讯云分析使用IFA(iOS6以下版本使用OpenUDID)+网卡MAC地址判断iOS用户设备的唯一性。';
        },
        showInLayer: function(items, theme, footerInfo){
            $('#'+this.conf.dialogWrap).hide();
 			if(items){
				$('#'+this.conf.container).show();
				var doc = "";
				for(var o in items){
					doc += '<dt>'+ o +'</dt><dd>'+items[o]+'</dd>';
				}
				if ('wechat' == theme){
                    doc += '<div style="margin-top:6px;color: #000;"><b>数据由专业移动应用分析工具<br/><a href="http://MTA.qq.com" target="_blank">腾讯云分析</a>&nbsp;合作提供</b></div>';
                }
				$('#'+this.conf.popup).html(doc);
                footerInfo = this.getFooterInfo(theme, footerInfo);     //获取备注说明
                footerInfo && $('#'+this.conf.footer).html(footerInfo);

				MTA.Util.popup('icon_items_info', 'wrap_items_info', 'pop_items_info');
			}                    
        },
        showInDialog: function(items, theme, footerInfo){
            var _self = this;
            $('#'+this.conf.container).hide();
            $('#'+this.conf.dialogWrap).show();
            $('#' + this.conf.dialogIcon).click(function(){
                var doc = '';
                for (var o in items){
                    doc += '<dt>' + o + '</dt>'
                        + ' <dd><ul class="mod_list_disc">'
                        + '         <li>' + items[o] + '</li>'
                        + '     </ul>'
                        + '</dd>';
                }
                doc = '<dl class="mod_idx_desc">' + doc + '</dl>';

                footerInfo = _self.getFooterInfo(theme, footerInfo);     //获取备注说明
                footerInfo && (doc += '<div class="mod_mark">' + footerInfo + '</div>');
                doc = '<div class="mod_float_ctn">' + doc + '</div>';

                var dialog = new MTA.Dialog({
                    title: '指标说明',
                    btnType: 3,
                    content: doc
                    }); 
            });
        }
	},
	
	/**
	 * @description 页面上出现的功能提示类
	 */
	noticeInfo : {
		/**
		 * 属性初始化
		 */
		closeId : '_info_close',
		contentId : '_info_content',
		wrapperId : '_info_wrapper',
		triggerId : '_info_trigger',
		triggerWrapperId :'_info_trigger_wrapper',
		/**
		 * @param tpl 提示的信息内容html片段
		 * @return null
		 */
		init : function(tpl){
			var that = this;
			$('#'+this.contentId).length>0 && ($('#'+this.contentId).html(tpl));
			$('#'+this.closeId).click(function(){
				that.hide();
			});
			$('#'+this.triggerId).click(function(){
				that.show();
			});
			$('#'+that.wrapperId).show();
			$('#'+that.triggerWrapperId).hide();
		},
		show : function(){
			var that = this;
				$('#'+that.triggerWrapperId).slideUp(200, function(){
					$('#'+that.wrapperId).show();
				});
		},
		hide : function(){
			var that = this;
			$('#'+that.wrapperId).slideUp(200, function(){
				$('#'+that.triggerWrapperId).show();
			});
			
        }
	},
	formatDate:function (date, type){
		if(!date){
			return '';
		}
		var fdate = new Date();
		date = date.replace(/\.\d*$/g, "").replace(/\-/g, "/");
        date = Date.parse(date);
        fdate.setTime(date);
         
        var year = fdate.getFullYear();
        var mon = fdate.getMonth()+1;
        var day = fdate.getDate();
        
        var hour = fdate.getHours();
        var minute = fdate.getMinutes();
        var second = fdate.getSeconds();
        hour = hour <10?'0'+hour : hour;
        minute = minute <10?'0'+minute : minute;
        second = second <10?'0'+second : second;
        mon = mon < 10 ? "0"+mon : mon;
        day = day < 10 ? "0"+day : day;
        if (undefined == type || 1 == type){
            return year+"-"+mon+"-"+day + " " +  hour+":"+minute+":"+second;;
        }else if(2 == type){
            return year+"-"+mon+"-"+day;
        }else if(3==type){
            return hour+":"+minute+":"+second;
        }else {
            return ""+year+mon+day;
        }
    },
    /**
	 * @description 为某一个元素增加数据加载中的遮罩层
	 * example GRI.Util.loading.show('conGRIiner');
	 */
	loading : {
		prefix : 'mask4',
		/**
		 * 显示遮罩层
		 * id : 容器ID
		 * extra : 额外配置数据
		 */
		show : function(id, extra) {
			if(id && $('#' + this.prefix + id).length > 0) {
				return false;
			}
			var that = this;
			var style = function() {
				if($('#' + id).length > 0) {
					return {
						width : $('#' + id).width(),
						height : $('#' + id).height(),
						offset : $('#' + id).offset(),
						padding : $('#' + id).css('padding')
					};
				}
				return null;
			}();
			if(style) {
				$('<div id="' + that.prefix + id + '"><i class="icon-loading"></i>&nbsp;数据加载中...</div>').css({
					height : style.height + 'px',
					left : style.offset.left + 'px',
					position : 'absolute',
					padding : style.padding,
					'padding-top' : '25px',
					top : style.offset.top + 'px',
					'text-align' : 'center',
					width : style.width + 'px',
					background : '#FFF',
					'opacity' : 0.4,
					'z-index' : 98
				}).appendTo('body');
			}
		},
		/**
		 * 清除遮罩层
		 * id : 容器ID
		 */
		clear : function(id) {
			if(id && $('#' + this.prefix + id).length > 0) {
				$('#' + this.prefix + id).remove();
			} else {
				$('div[id^="' + this.prefix + '"]').each(function() {
//					$(this).remove();
				});
			}
		}
	}
    
};

/** =======================================================
 * @description Applist的构造函数，初始化
 * @param {Array} arr applist数组
 * @param {String} target 绑定的容器
 * @param {Object} extra 附加参数
 * @author johnnyzheng(johnnyzheng@tencent.com)
 * @version 2013-01-05 init
 */
MTA.Applist = function(arr, target, defaultAppId) {
	// appId 初始值
	this.appId = '';
	this.appName = '';
	this.appLogo = '';
	this.appList = [];
	this.portalId = '';
	this.portalDesc = '';
	this.TIME_OUT = null;
	this.frontAppList = [];
	//控件内容填充
	var self = this, subMenu = {}; 
	(arr.length > 0) && function() {
		self.appList = arr;
		var doc = '';
		for(var i = 0; i < arr.length; i++) {
			if($.inArray(arr[i].AppName +'##'+ arr[i].RegAccount, self.frontAppList) === -1){
				self.frontAppList.push($.trim(arr[i].AppName)+'##'+arr[i].RegAccount);
			}
		}
		//这里有一个负责的操作，先按照创建人和应用名称分组，然后再追加html代码段
		for(var j= 0 ; j < self.frontAppList.length; j++){
			var name = self.frontAppList[j].split('##')[0];
			var author = self.frontAppList[j].split('##')[1];
			doc += '<li id="'+ self.frontAppList[j].replace(/#/g, '') +'">'+ name +'<div class="sub_menu">';

			for(var i = 0; i < arr.length; i++) {
				if(name == arr[i].AppName && author == arr[i].RegAccount){
					doc += '<a class="'+MTA.Config.platformMap[arr[i].Portal].css+'" href="#" id="' + arr[i].AppId + '">' + arr[i].AppName+ '</a>';
				}
				(defaultAppId == arr[i].AppId) && function() {
				self.appId = arr[i].AppId;
				self.appName = arr[i].AppName;
				self.appLogo = arr[i].AppLogo;
				self.portalId = arr[i].Portal;
				self.portalDesc = MTA.Config.platformMap[arr[i].Portal].desc;
			}();
			}
			doc += '</li></div>';
		}
		
		$('#' + target).length > 0 && ($('#' + target).html(doc));
		$('#' + target).find('li a').each(function(index) {
			$(this).bind('click', function() {
				self.changeApp(this);
			}).hover(function() {index == 0 ? $('#i_selector').addClass('ib-first-hover') : $('#i_selector').removeClass('ib-first-hover');
			}).mouseout(function() {
				$('#i_selector').removeClass('ib-first-hover');
            });
		});
        
        //信息初始化
        self.appLogo && $('#app_logo').length > 0&&$('#app_logo').html('<img src="' + self.appLogo + '">');
        self.portalId && $('#app_name').length > 0&&$('#app_name').html(self.appName)&&$('<i class="icon_'+MTA.Config.platformMap[self.portalId].css+'"></i>').insertAfter($('#app_name'));
	
	}();

	//$('#app_platform').length >0&& $('#app_platform').html(this.portalDesc);
	
	//调用公共气泡层接口
	MTA.Util.popup('btn_pop_app', 'wrap_pop_app', 'ctn_pop_app', 'show');
	//绑定查询接口
	$('#btn_app_search').length > 0 && function(){
		$('#btn_app_search').click(function(){
			var str = ($('#txt_app_search').length > 0 && $('#txt_app_search').val()) || '';
			for(var i=0; i<self.frontAppList.length;i++){
				var id = self.frontAppList[i].replace(/#/g, '');
				$('#' + id).hide();
				if($.trim(str) !== ''){
					self.frontAppList[i].substr(0, self.frontAppList[i].indexOf('##')).indexOf(str) != -1 && $('#'+ id ).show();
				}
				else {
					$('#'+ id).show();
                }
			}
	    });
        $("#txt_app_search").keydown(function(event){
            if (13 == event.keyCode){
                $('#btn_app_search').click();
            }
        });
	}();
	//绑定切换函数
	this.bindChange = function(callback) {
		return true;
	};
	//获取app信息
	this.getAppInfo = function() {
		return {
			'appId' : this.appId,
			'appName' : this.appName,
			'appLogo' : this.appLogo,
			'appPortal' : this.portalDesc
		};
	};
	/**
	 * 根据 AppId 获取应用对象
	 */
	this.getAppObject = function(appId) {
		for(var o in this.appList) {
			if(this.appList[o].AppId === appId) {
				return this.appList[o];
			}
		}
	};

	this.getAppList = function() {
		return this.appList;
	};
	/**
	 * @description 切换应用和平台
	 * @param {Object}
	 * @param {Object} callback 回调函数
	 */
	this.changeApp = function(obj, callback) {
		//切换站点，改变全局变量的属性值
		for(var i = 0; i < this.appList.length; i++) {
			if(obj.id == this.appList[i].AppId) {
				this.appId = this.appList[i].AppId;
				this.appName = this.appList[i].AppName;
				this.appLogo = this.appList[i].AppLogo;
				this.portalId = this.appList[i].Portal;
				this.portalDesc = MTA.Config.platformMap[this.appList[i].Portal].desc;
				parse_r = GRI.Util.parse_url();
				parse_r.param['app_id'] = this.appId;
				window.location.href = parse_r.path + GRI.Util.convert_params(parse_r.param);
				return false;
			}
		}
		//改变界面的值
		$('#app_name').html('<img width="20" height="20" src="' + this.appLogo + '">' + this.appName + '_' + this.portalDesc + '版');
		//如果有回调函数，调用回调函数
		callback && eval(callback + '()');
	};
};

/**==============================================
 * @description MTA的菜单对象
 * @param {Obj} arr 菜单
 * @param {String} target 菜单容器
 * @author 扣子(ouxueying@rockitv.com)
 * @version 2014-01-05 init
 */
MTA.Menu = function(arr, target) {

	this.menuList = {};

	var self = this;
	/**
	 * @description 通过url返回菜单配置信息
	 * @param {String} url
	 */
	this.getMenuInfo = function(url) {

        var matchUrl = function(url, m_url){
			//如果配置中加了参数，则去掉问号后的参数再比较
        	/**
        	var pos = m_url.indexOf('?');
			if (pos >= 0){
				pos && (m_url = m_url.substring(0, pos));
			}
			**/
            return url == m_url;
        };

		//如果是数据概览，则处理相应的菜单状态
		if(this.menuList.main['0'] && matchUrl(url, this.menuList.main['0'].m_url)){
				return {
					'm_id' : this.menuList.main['0'].m_id,
					'm_name' : this.menuList.main['0'].m_name,
					'p_name' : '茶联'
				};
		}
		for(var o in this.menuList.sub) {
			if(matchUrl(url, this.menuList.sub[o].m_url)) {
				//获得父级菜单的名称       2015-3-2 modify by dengpengfei
				var p_name = function() {
					if(self.menuList.sub[o].m_is_child) {
						return self.menuList.sub[self.menuList.sub[o].p_id].m_name;
					}
					
					var flag = false;
				
					for(var i in self.menuList.main) {
						if(self.menuList.sub[o].p_id == self.menuList.main[i].m_id ) {
							flag = true;					
							break;
						}
					}
					
					if(flag) {
						return self.menuList.main[i].m_name;
					} else {
						return "";
					}

				}();
				//将其与子菜单信息合并成一个对象
				return $.extend(true, this.menuList.sub[o], {
					'p_name' : p_name
				});
			}
		}
	};
	/**
	 * @description 菜单点击切换功能时，传递appId
	 * @param {String} appId 应用ID
	 */
	this.changeFuc = function(loc, appId) {
		//执行数据统计
		// window.location.href = loc + (appId ? '?app_id=' + appId : '');
		 window.location.href = loc;
		return false;
	};
	
	arr && function() {
		self.menuList = arr;
		//构造html代码
		var html = '';
		var appId =  MTA.Util.getAppId();
		for(var o in arr.main) {

				arr.main[o].m_display && function() {
					html += '<div class="mod_sidemenu' + (arr.main[o].m_is_expanded == 0 ? ' collapsibe':'') + '">'+
								'<h3 class="title" id="parent_menu_'+arr.main[o].m_id+'">'+
									'<a href="javascript:;">'+
                    							'<i class="' + arr.main[o].m_icon_css + '"></i>'+ arr.main[o].m_name +
									'<i id="i_menu_'+arr.main[o].m_id+'" class="icon_menu"></i></a>'+
								'</h3><div id="child_menu_'+arr.main[o].m_id+'" style="position:relative;zoom:1' + (arr.main[o].m_is_expanded == 0 ? ';display:none':'') + '">';
					for(var p in arr.sub) {
						if(arr.sub[p].p_id == arr.main[o].m_id && arr.sub[p].m_display) {
                            var url =  arr.sub[p].m_url;
                            appId && (url += GRI.Util.convert_params({app_id: appId}, url));
							html += '<ul class="menu_content"><li>'+
									'<a id="menu_' + arr.sub[p].m_id + '" href="' + url + '">' + arr.sub[p].m_name +(arr.sub[p].m_is_new ? '<i class="icon_new">新</i>' : '')+'</a>'+
									'</li></ul>';
						}
					}
					html += '</div></div>';
				}();

		}
		$('#' + target).html(html);
	}();

	//子菜单的点击事件
	$('#' + target).find('a[id^="menu_"]').each(function() {
		$(this).bind('click', function() {
			var appId =  MTA.Util.getAppId();
			//如果有自定义函数，则依赖此回调。
			if (MTA.Function && typeof (MTA.Function.setMenuParams) == 'function'){
                var href = $(this).attr("href");
                params = MTA.Function.setMenuParams();
                //href += GRI.Util.convert_params(params, href) + "&app_id=" + appId;
                href += GRI.Util.convert_params(params, href);
                window.location.href = href;
                return false;
            }
            
			return self.changeFuc($(this).attr('href'), appId);
		})
	});
	//菜单的收折效果
	$('#' + target).find('h3[id^="parent_menu_"]').each(function() {
		$(this).unbind('click').bind('click', function() {
			child = 'child_menu_' + $(this).attr('id').match(/parent_menu_(\d{1})/i)[1];
			if($('#' + child).is(':hidden')) {
				$(this).parent().removeClass('collapsibe');
				$('#' + child).slideDown(300, function(){
                    self.saveMenuStatus();
                });
			} else {
				$('#' + child).slideUp(300, function(){
                    $(this).parent().addClass('collapsibe');
                    self.saveMenuStatus();
                });
			}
		});
	});

    //记录闭合的菜单id到cookie
    this.saveMenuStatus = function(){
        var closeMenuId = '';
        $('div[id^=child_menu_]').each(function(){
            if($(this).is(':hidden')) {
                var menuId = $(this).attr('id').replace('child_menu_', '');
                closeMenuId += menuId + ',';
            }
        });
        //#表示没有闭合菜单
        (closeMenuId.length == 0) && (closeMenuId = '#');
        GRI.Util.cookie.save('rkCloseMenuId', closeMenuId);
    };
    //从cookie恢复菜单状态
    this.recoverMenuStatus = function(){
        var closeMenuId = GRI.Util.cookie.get('rkCloseMenuId');
        if(closeMenuId){
            $('div[id^=child_menu_]').each(function(){
                var menuId = $(this).attr('id').replace('child_menu_', '');
                if(closeMenuId.indexOf(menuId) > -1){
                    $(this).parent().addClass('collapsibe');
                    $(this).hide();
                }
                else
                {
                    $(this).parent().removeClass('collapsibe');
                    $(this).show();
                }
            });
        }
    };
}
/**
 * MTA的菜单对象 ： END
 * ========================================================
 */

/**
 * @namespace MTA管理器，用于页面初始化、创建查询条件区域
 */
MTA.Report = {

	condition : {},

	initialize : function(dateObj, func) {
		//初始化APP选择器对象
		//MTA.Page.app = new MTA.Applist(MTA.Page.app_list, 'app_list', func);
		//页面全局使用的app对象
		this.condition = new MTA.Condition();
		if(dateObj){
			this.condition.createQueryRange(dateObj, func);
		}else{
			func && eval(func + '()');
		}
	},

    /**
     * 初始化报表下拉列表：小时报、日报、周报、月报
     * @param data  可选选项，如[{'name':'日报','value':'day'},{'name':'小时报','value':'hour'}];
     * @param defaultValue 默认值，如hour
     */
    initReportList : function(data, defaultValue){
        var id = "report_list";
        var opts = {'data':data,'container':id,'callback':MTA.Report.changeReportType,'defaultValue':defaultValue};
        new MTA.HoverDownList(opts);
    },

    changeReportType : function(selected){
        var url = location.href;
        url = url.replace(/&time_type=(hour|day|week|month)/,"");
        url = url.replace(/time_type=(hour|day|week|month)&*/,"");
        url +=  GRI.Util.convert_params({'time_type':selected['value']}, url);
        location.href = url;
	}
}


/*
 * @namespace 报表展示页面的条件选择区域抽象对象
 */
MTA.Condition = function() {

	/**
	 * 查询条件: 日期对象
	 */
	this._date = {};

	/**
	 * 查询条件: 版本
	 */
	this._version = {};

	/**
	 * 查询条件: 渠道
	 */
	this._channel = {};
}

MTA.Condition.prototype = {

	/**
	 * @description 根据用户选择的版本、日期、平台等构造查询参数对象
	 */
	getQueryParams : function(caller) {
		//表格数据查询
		var params = {};
		/**
		 * ========================================================================
		 * 需要解除注释
		params.start_date = this._dateObj.startDate;
		//日期选择器的开始日期
		params.end_date = this._dateObj.endDate;
		//日期寻择期的结束
		params.need_compare = this._dateObj.needCompare;
		params.start_compare_date = this._dateObj.startCompareDate;
		params.end_compare_date = this._dateObj.endCompareDate;
		params.app_id = MTA.Util.getAppId();
		//获取当前的appId
		//params.portalId = MTA.Util.getPortalId(); //获得当前平台名称
		// params.channel = encodeURIComponent(MTA.Page.Condition.channel.getValue()); // 获得当前渠道
		// params.version = MTA.Page.Condition.version.getValue(); //版本

		params = MTA.Util.getConditions(params);

		params = MTA.Util.getOptions(params, caller);
		**/
		return params;
	},
	//构造查询表单、包括版本、平台等
	createQueryRange : function(dateObj, func) {
		var self = this;
		//将版本和渠道的选择放到页面上去，由各个自主完成初始化
		// this._version = new MTA.Selector('#div_version','version',jsonVer,func);
		// this._channel = new MTA.Selector('#div_channel','channel',jsonChl,func);
		this._date = new pickerDateRange(dateObj.inputId, {
			theme : 'ta', // 日期选择器TA主题
			autoCommit : true, //自动提交，完成日期初始化，以及图表的展示拉取
			isTodayValid : dateObj.isTodayValid,
			startDate : dateObj.startDate,
			endDate : dateObj.endDate,
			needCompare : dateObj.needCompare,
			startCompareDate : dateObj.startCompareDate,
			endCompareDate : dateObj.endCompareDate,
			singleCompare : dateObj.singleCompare,
			defaultText : dateObj.defaultText,
			autoSubmit : dateObj.autoSubmit || false ,
			shortOpr : dateObj.shortOpr || false,
			target : dateObj.target,
			calendars : dateObj.calendars || 2,
			inputTrigger : dateObj.inputTrigger || 'input_trigger',
			validStartTime : dateObj.validStartTime,
            minValidDate:dateObj.minValidDate,
            stopToday:dateObj.stopToday,
            startDateId : dateObj.startDateId,  
            suffix : dateObj.suffix,
            endDateId : dateObj.endDateId,
            needCompare : dateObj.needCompare,
            aYesterday:dateObj.aYesterday,
			success : function(obj) {
				self._dateObj = obj;
				//在 MTA.Page的命名空间内 增加 DatePicker 属性 方便在页面周期内取得自主控制权
				MTA.Page.DatePicker = obj;
				/**
				if(obj.needCompare == '1') {
					MTA.Options.Util.ctrlAllActive();
					$('#short_opt').hide();
				} else {
					MTA.Options.Util.ctrlAllActive(true);
					$('#short_opt').show();
				}**/
				func && eval(func + '()');
			}
		});
	}
}


/**
 * 数据加载 图表或 列表
 * 
 */
MTA.Data = {
		/**
		 * 
		 */
		tableData:{},
		/**
		 * 图的拉取数据的地址
		 */
		chartCgi : '',
		/**
		 * 表拉取数据的地址
		 */
		tableCgi : '',

		/**
		 * @description 拉取基础数据
		 * @param {String} cgi 地址
		 * @param {Object} 回调函数
		 * @param {Boolean} 是否使用日期
		 * @param {Object} 待扩展的参数
		 */
		loadBasic : function(cgi, hdl, useDate, extra){
			var params =  {
				'app_id' : MTA.Util.getAppId()
			},
			_extra = {
				useMask : true // 是否使用遮罩层
			};
			_extra = $.extend(true, _extra, extra);
			//如果默认使用类库提供的日期拼接，则设置为true
			useDate && function(){
				params.start_date = MTA.Report.condition._dateObj.startDate;
	            params.end_date = MTA.Report.condition._dateObj.endDate;
			}();
			
			params = $.extend(true, params, MTA.Page.Params);
			//added by johnnyzheng 2013-07-12追加其它信息
			var _conditions = {};
			!MTA.Util.isEmptyObj(MTA.Report.condition) && (_conditions = MTA.Report.condition.getQueryParams());
			params = $.extend(true, params, _conditions);
			var url = MTA.Config.RootPath + cgi + GRI.Util.convert_params(params, cgi)+"&rnd="+(+new Date());
			if(_extra['useMask']){
				GRI.Util.loading.show('main');
			}
			return $.getJSON(url, function(data){
				//调用回调函数
				hdl(data);
				GRI.Util.loading.clear('main');
			});
		},
		
		/**
		 * @description 加载图的数据
		 * @params {String} cgi webservice 地址
		 * @params {Obj} 配置对象
		 * @params {String} 容器ID
		 */
		loadChart : function(cgi, chartOpt, container, height, callback) {
			var caller = MTA.Data.loadChart.caller.toString().match(/function\s(\w+)\(\s*|\w*\)/i)[1];
			var params = MTA.Report.condition.getQueryParams(caller);
			params = $.extend(true, params, MTA.Page.Params);
			var url = MTA.Config.RootPath + cgi + GRI.Util.convert_params(params, cgi)+"&rnd="+(+new Date());

			GRI.Util.loading.show('main');
			$.getJSON(url, function(data) {
	            if (data['is_session_expire'] && data['type']=='wechat'){
	                MTA.Weixin.Util.expire();
	                return;
	            }
				var containerId = '#' + container;
				$(containerId).empty();

				if(height == undefined) {
					height = 300;
				}
				var options = {};
				if(data.chartOptions != null) {
					options = {
						chartOptions : data.chartOptions
					};
				}

				if(data.enableLegend != null) {
					options['enableLegend'] = data.enableLegend;
				}
				options = $.extend(true, options, chartOpt);
				//如果自定义title
				if(chartOpt.title){
					options.title = {text : data.title + chartOpt.title, useHTML : true};
				}
	            var isCompare = url.indexOf("need_compare=1") >= 0  ? 1 : 0;
	            var autoStep = true;
	            if (data.autoStep === false)
	            {
	                autoStep = false;
	            }
				var _opt = {
	                autoStep: autoStep,
					chartType : data.chartType || 'line',
					categories : data.categories,
					series : data.series,
					title : data.title,
					height : height,
	                isCompareSeries:isCompare,
					dataFormat: data.dataFormat || '1',
					labelFormat: data.labelFormat || 0
				};

				_opt = $.extend(true, _opt, options);
				$(containerId).createChart(_opt);
				GRI.Util.loading.clear('main');

	            callback && callback();
			});
		},
		/**
		 * @description 加载图的数据
		 * @params {String} cgi webservice 地址
		 * @params {Obj} 配置对象
		 * @params {String} 容器ID
		 */
		loadBar : function(cgi, chartOpt, container) {
			var caller = MTA.Data.loadBar.caller.toString().match(/function\s(\w+)\(\s*|\w*\)/i)[1];
			var params = MTA.Report.condition.getQueryParams(caller);
			params = $.extend(true, params, MTA.Page.Params);
			var url = MTA.Config.RootPath + cgi + GRI.Util.convert_params(params, cgi)+"&rnd="+(+new Date());

			$.getJSON(url, function(data) {
				var containerId = '#' + container;
				$(containerId).empty();
				data.chartOptions = data.chartOptions || {};
				data.chartOptions.chart = data.chartOptions.chart || {};
				data.chartOptions.chart.marginright = 150;
	            var cateLen = data.categories ? data.categories.length + 1 : 1;
				//只显示一个图
				var _opt = {
					chartType : 'bar',
					height : cateLen * 45 + 50,
					xAxisLabelStep : 1,
					enableLegend : false,
					labelFormat : 2,
					categories : data.categories,
					series : data.series,
					title : data.title,
					chartOptions : data.chartOptions
				};
				_opt = $.extend(true, _opt, chartOpt);
				$(containerId).createChart(_opt);
			});
		},
		/**
		 * @description 加载图的数据
		 * @params {String} cgi webservice 地址
		 * @params {Obj} 配置对象
		 * @params {String} 容器ID
		 */
		loadTable : function(cgi, container, hdl) {

			var caller = MTA.Data.loadTable.caller.toString().match(/function\s(\w+)\(\s*|\w*\)/i)[1];
			var params = MTA.Report.condition.getQueryParams(caller);
			params = $.extend(true, params, MTA.Page.Params);
			var url = MTA.Config.RootPath + cgi + GRI.Util.convert_params(params, cgi)+"&rnd="+(+new Date());
			GRI.Util.loading.show('main');
			$.getJSON(url, {}, function(result) {
	            if (result['is_session_expire'] && result['type']=='wechat'){
	                MTA.Weixin.Util.expire();
	                return;
	            }
				var spanColIndex = result.spanColIndex == false ? null : '0';
				var dt = Gri.initDataTable({
					tableId : container,
					data : result.data,
					allFields : result.fields,
	                complexHeader:result.complexHeader,
					layout : 'auto',
					spanColIndex : spanColIndex,
					page : result.page || false,
					noPage : result.noPage,
					fixedRow : result.fixedRow,
					//cssSetting:result.cssSetting,
					callback : function() {
						hdl && hdl();
					}
				});
				GRI.Util.loading.clear('main');
			});
		},
	    /**
	     *
	     * @param data_url
	     * @param container
	     * @param chartOpts
	     */
	    loadKeyIndex : function(data_url,container, chartOpts) {
	        if (undefined === chartOpts){
	            chartOpts = {'theme':'wechat'};
	        }
	        var caller = MTA.Data.loadKeyIndex.caller.toString().match(/function\s(\w+)\(\s*|\w*\)/i)[1];
	        var params = MTA.Report.condition.getQueryParams(caller);
	        params = $.extend(true, params, MTA.Page.Params);
	        var url = MTA.Config.RootPath + data_url + GRI.Util.convert_params(params, data_url)+"&rnd="+(+new Date());

	        $.getJSON(url, {}, function(result) {
	            if (result['is_session_expire'] && result['type']=='wechat'){
	                MTA.Weixin.Util.expire();
	                return;
	            }
	            if (result['data'].length == 0){
	                return;
	            }
	            var obj = $("#"+container).parent().parent().children(".title");
	            obj.children(".key_index_title").remove();
	            //obj.append('<span class="key_index_title text">'+result.end_day.substr(5)+'</span>');

	            var con = $("#" + container);
	            con.addClass("ui_trendgrid_" + result['data'].length);
			
	            html = "<tbody><tr>";
	            for (var i = 0; i < result['data'].length; i++){
	                var v = result['data'][i];
	                var c = 0 == i ? "class='first'" : (result['data'].length-1 == i ? "class='last'" : "");
	                var chart_con = "key_index_chart_"+v['key'];
	                html += "<td "+c+"><div class='ui_trendgrid_item'>";
	                html += "<div class='ui_trendgrid_chart' id='"+chart_con+"'></div>";
	                html += "<dl>";
	                html += "<dt><b>"+v['name']+"</b></dt>";

	                var is_qc_page = chartOpts.isQc || 0;

	                if(is_qc_page){
	                    html += formatNum(v, 1);
	                }else{
	                    html += formatNum(v);
	                }
	                for (var j = 0; j < v['rate'].length; j++){
	                    html += "<dd>"+v['rate'][j]['name']+formatRate(v['rate'][j]['num'])+"</dd>";
	                }
	                html += "</dl>";
	                //html += "<div class='ui_trendgrid_time'>"+result.begin_day+"至"+result.end_day+"</div>";
	                html += "</div></td>";

	            }
	            html += "</tr></tbody>";
	            con.html(html);

	            var margin = 0;
	            switch (result['data'].length){//左右两边空隙的补丁
	                case 2:
	                    margin = -13;
	                    break;
	                case 3:
	                    margin = -8;
	                    break;
	                case 4:
	                    margin = -6;
	                    break;
	                case 5:
	                    margin = -5;
	                    break;
	            }
	            chartOpts = $.extend({chartOptions:{chart:{spacingLeft:margin-1,spacingRight:margin}}},chartOpts);
	            if (chartOpts['theme'] != 'wechat'){
	                for (var k in result['chart']){
	                    var chart_con = "key_index_chart_"+k;
	                    MTA.Data.showKeyIndexChart(result['chart'][k], chartOpts, chart_con);
	                }
	            }
	            if (typeof(MTA.key_index_ad) == 'function'){
	                MTA.key_index_ad();
	            }
	        });

	        function formatRate(rate){
	            if (null == rate || isNaN(rate)){
	                return "&nbsp;&nbsp;&nbsp;-- ";
	            }
	            var html = "";
	            if (rate < 0){
	                html += "<i class='icon_down' title='下降'></i>";
	                rate = -rate;
	            }else{
	                html += "<i class='icon_up' title='上升'></i>";
	            }
	            rate = accMul(rate, 100);
	            html += rate + "%";
	            return html;
	        }

	        function addCommas(nStr) {
	            nStr += '';
	            var x = nStr.split('.');
	            var x1 = x[0];
	            var x2 = x.length > 1 ? '.' + x[1] : '';
	            var rgx = /(d+)(d{3})/;
	            while (rgx.test(x1)) {
	                x1 = x1.replace(rgx, '$1' + ',' + '$2');
	            }

	            return x1 + x2;
	        }

	        function formatNum(v, ignore){
	            v['num'] += "";
	            if(v['format'] && v['format'] == "percent"){
	                v['num'] = Math.round(v['num'] * 10000) / 100 + "%";
	            }

	            if ( null == v['num'] || (v['num'].indexOf("%") < 0 && isNaN(v['num'])) ){
	            	  if (MTA.Config.theme == 'wechat') {
	                	return "<dd class='ui_trendgrid_number' style='font-size:14px;'><strong>暂无数据</strong><em class='ui_trendgrid_unit'></em></dd>";
	            	  } else {
	                	return "<dd class='ui_trendgrid_number' style='font-size:12px;'><strong>无数据或计算中...</strong><em class='ui_trendgrid_unit'></em></dd>";
	            	  }
	            }
	            if (v['num'].indexOf("%") >= 0){//如果是百分比，原样输出
	                num = v['num'];
	                var unit = v['unit'] || "";
	            }else{
	                if(ignore){
	                    var num = parseInt(v['num']);
	                    var unit = v['unit'] || "";
	                }else{
	                    var num = parseFloat(v['num']);
	                    var unit = v['unit'] || "";
	                    if (num >= 1000000000){
	                        num = parseInt(num / 1000000);
	                        unit = "M" + unit;
	                    }else if (num >= 1000000){
	                        num = parseInt(num / 1000);
	                        unit = "K" + unit;
	                    }else if (num >= 1000){
	                        //num = parseInt(num);
	                        num = v['num'];
	                    }
	                }

	                num += '';
	                var n = num.split('.');
	                var n1 = n[0];
	                var n2 = n.length > 1 ? '.' + n[1] : '';
	                var rgx = /(\d+)(\d{3})/;
	                while (rgx.test(n1)) {
	                    n1 = n1.replace(rgx, '$1' + ',' + '$2');
	                }
	                num = n1 + n2;
	            }

	            var html = "<strong>"+num+"</strong><em class='ui_trendgrid_unit'>"+unit+"</em>";
	            html = "<dd class='ui_trendgrid_number'>"+html+"</dd>";
	            return html;
	        }

	        function accMul(arg1,arg2)
	        {
	            var m=0,s1=arg1.toString(),s2=arg2.toString();
	            try{m+=s1.split(".")[1].length}catch(e){}
	            try{m+=s2.split(".")[1].length}catch(e){}
	            return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m)
	        }
	    },
	    /**
	     *
	     * @param data 图的数据
	     * @param chartOpt 图的特殊配置，暂时未用
	     * @param container 容器id
	     * @param height 高度
	     */
	    showKeyIndexChart:function(data, chartOpt, container, height){
	        height = height ? height : 75;
	        var min = false;
	        for (var i = 0; i < data['series'][0]['data'].length; i++){
	            if (data['series'][0]['data'][i]['y'] === null){
	                continue;
	            }
	            //data['series'][0]['data'][i]['y'] *= 100;
	            if (false===min  || data['series'][0]['data'][i]['y'] < min){
	                min = data['series'][0]['data'][i]['y'];
	            }
	        }
	        min = false===min ? 0 : min;
	        //min -= min > 10 ? min/10 : 1;

	        var elem = $("#"+container);
	        var color = chartOpt['theme'] == 'wechat' ? '#F7F7F7' : '#FFFFFF';
	        elem.empty();
	        var _opt = {
	            chartType: 'line',
	            chartOptions:
	            {
	                chart:{
	                    'height':height,
	                    marginBottom: -1,
	                    borderWidth:0,
	                    spacingLeft:0,
	                    spacingRight:0,
	                    spacingBottom:0,
	                    backgroundColor:color
	                },
	                xAxis: {
	                    labels : {
	                        enabled : false
	                    }
	                },
	                yAxis:{
	                    labels : {
	                        enabled : false
	                    },
	                   // 'min': min,
	                    gridLineWidth :0
	                },
	                legend : {
	                    enabled : false
	                },
	                tooltip :{
	                    enabled : false
	                },
	                plotOptions:{
	                    series: {
	                        lineWidth:1,
	                        enableMouseTracking: false,
	                        animation: false,
	                        marker: {
	                            enabled: false,
	                            states: {
	                                hover: {
	                                    enabled: false
	                                }
	                            }
	                        }
	                    }
	                }
	            },
	            enableLegend:false,
	            categories: data.categories,
	            series : data.series,
	            title : data.title,
	            'height':height+"px"
	        };
	        _opt = $.extend(true, {}, _opt, chartOpt);
	        elem.createChart(_opt);
	    },
	    /**
	     * @description 加载图的数据
	     * @params {String} cgi webservice 地址
	     * @params {Obj} 配置对象
	     * @params {String} 容器ID
	     */
	    exportTable : function(cgi) {
	        var caller = MTA.Data.exportTable.caller.toString().match(/function\s(\w+)\(\s*|\w*\)/i)[1];
	        var params = MTA.Report.condition.getQueryParams('buildDataTable');
	        params['export'] = 1; // 标识导出
	        params = $.extend(true, params, MTA.Page.Params);
	        var url = MTA.Config.RootPath + cgi + GRI.Util.convert_params(params, cgi)+"&rnd="+(+new Date());
	        window.open(url,'new');
	    },
		/**
		 * @description 加载表的数据，分页
		 * @params {String} cgi webservice 地址
		 * @params {Obj} 配置对象
		 * @params {String} 容器ID
		 */
		loadPageTable : function(config) {
			var caller = MTA.Data.loadPageTable.caller.toString().match(/function\s(\w+)\(\s*|\w*\)/i)[1];
			var params = MTA.Report.condition.getQueryParams(caller);
			params = $.extend(true, params, MTA.Page.Params);
			//var url = MTA.Config.RootPath + cgi + GRI.Util.convert_params(params, cgi)+"&rnd="+(+new Date());
			GRI.Util.loading.show('main');
			$.getJSON(config.page.url, {}, function(result) {
			 var spanColIndex = config.spanColIndex == false ? null : '0';
				var dt = Gri.initDataTable({
					tableId : config.container,
					data : result.data,
					allFields : config.allFields,
					complexHeader:config.complexHeader,
					//layout:'auto',
					spanColIndex : spanColIndex,
					page : {
						ifRealPage : config.page.ifRealPage,
						size : config.page.size > 0 ? config.page.size : (MTA.Config.theme == 'wechat' ? 14 : config.page.size),
						autoHide:true,
						theme: MTA.Config.theme == 'wechat' ? 'lite' : 'full'
					},
					callback : function() {
						//hdl && hdl(result);
					}
				});
				GRI.Util.loading.clear('main');
			});
		},
		/**
		 * @description 加载表的数据，分页
		 * @params {String} cgi webservice 地址
		 * @params {Obj} 配置对象
		 * @params {String} 容器ID
		 */
		loadAjaxPageTable : function(config) {
			var caller = MTA.Data.loadAjaxPageTable.caller.toString().match(/function\s(\w+)\(\s*|\w*\)/i)[1];
			var params = MTA.Report.condition.getQueryParams(caller);
			params = $.extend(true, params, MTA.Page.Params);
			//var url = MTA.Config.RootPath + cgi + GRI.Util.convert_params(params, cgi)+"&rnd="+(+new Date());
			 var spanColIndex = config.spanColIndex  ?  '0' :null;
				var dataTable = Gri.initDataTable({
					tableId : config.container,
					thAlign:config.thAlign,
					data : [],
					allFields : config.allFields,
					complexHeader:config.complexHeader,
					keyIndex:config.keyIndex,
					checkAll:config.checkAll,
					//layout:'auto',
					spanColIndex : spanColIndex,
					page : {
						params:params,
						rowCount:config.page.size+1,
						url:config.page.url,
						ifRealPage : config.page.ifRealPage,
						size : config.page.size > 0 ? config.page.size : (MTA.Config.theme == 'wechat' ? 14 : config.page.size),
						autoHide:true,
						theme: MTA.Config.theme == 'wechat' ? 'lite' : 'full'
					},
					callback : function() {
						//hdl && hdl(result);
						if(config.callback){
							config.callback();
						}
					}
				});
				dataTable.loadData();
				/**
				 Gri.ajaxGet(config.page.url,params,function(result,config){
				 	MTA.Data.tableData = result;
				 
			 },config);
			 **/
			 return dataTable;
		},
	    /**
	     * @description 加载表的数据，分页
	     * @params {String} cgi webservice 地址
	     * @params {Obj} 配置对象
	     * @params {String} 容器ID
	     */
	    loadSimpleTable : function(cgi, container) {
	        GRI.Util.loading.show('main');
	        $.getJSON(cgi, {}, function(result) {
	            var dt = Gri.initDataTable({
	                tableId : container,
	                data : result.data,
	                allFields : result.fields,
	                //layout:'auto',
	                spanColIndex : "0",
	                page : {
	                    ifRealPage : 0,
	                    size : result.size,
	                    autoHide: false,
	                    theme: MTA.Config.theme == 'wechat' ? 'lite' : 'full'
	                },
	                callback : function() {

	                }
	            });
	            GRI.Util.loading.clear('main');
	        });
	    }
};



//分页组件
MTA.Page.Pagination= {
		'pageSize':10,
		'pageIndex':0,
		fun:null,
		render:function(target,total,fun){
			$('#'+target).empty();
			if(total <= MTA.Page.Pagination.pageSize){
				return;
			}
			this.fun = fun;
			var pg = this.builder(total);
			if(pg){
				$('#'+target).html(pg);
			}
			
			$('nav .pagination li a').each(function(){
				if($(this).attr('index') != undefined){
					var index = $(this).attr('index');
					$(this).click(function(){
						MTA.Page.Pagination.goPage(index);
					});
				}
			});
		},
		builder:function(total){
			if(!total || total == 0){
				return null;
			}
			var pg = [];
			pg.push('<nav>');
			pg.push('<ul class="pagination">');
			//总页数
			var count = Math.ceil(total/MTA.Page.Pagination.pageSize);
			//大于总页数时取最后一页
			if(MTA.Page.Pagination.pageIndex > count){
				MTA.Page.Pagination.pageIndex = count-1;
			}
			
			// 最大展现页码数量
			var maxShowPageNum = 10;
			// 高亮位置默认值
			var highLightIndexDefault = 6;
			// 当前页码
			var pageNum = new Number(MTA.Page.Pagination.pageIndex) + 1;
			// 页码数组
			var pageNumArr = [];
			if(pageNum <= highLightIndexDefault) {
				var realShowPageNum = Math.min(maxShowPageNum, count);
				for(var i = 0 ; i < realShowPageNum; i++) {
					pageNumArr.push(i+1);
				}
			}else {
				var rightTotal = maxShowPageNum - highLightIndexDefault;
				if(pageNum + rightTotal >= count) {
					var startIndex = count - maxShowPageNum;
					startIndex = startIndex < 0 ? 0 : startIndex;
					for(;startIndex < count; startIndex++) {
						pageNumArr.push(startIndex+1);
					}
				}else {
					var startIndex = pageNum - highLightIndexDefault;
					var endIndex = pageNum + rightTotal;
					while(startIndex < endIndex) {
						pageNumArr.push(startIndex+1);
						startIndex++;
					}
				}
			}
			
			if(pageNum == 1){
				pg.push(' <li class="disabled"><a href="javascript:;" ><<</a></li>');
				pg.push(' <li class="disabled"><a href="javascript:;" ><</a></li>');
			}else {
				pg.push(' <li><a href="javascript:;" index="0" ><<</a></li>');
				pg.push(' <li><a href="javascript:;" index="-1" ><</a></li>');
			}
			
			for(var i = 0; i < pageNumArr.length; i++) {
				var page = pageNumArr[i];
				if(pageNum == page){
					pg.push(' <li class="active">');
				}else{
					pg.push(' <li>');
				}
				pg.push(' <a href="#" index="' + (page-1) + '">');
				pg.push(page);
				pg.push('</a></li>');
			}
			
			if(pageNum == count){
				pg.push(' <li class="disabled"><a href="javascript:;" >></a></li>');
				pg.push(' <li class="disabled"><a href="javascript:;" >>></a></li>');
			}else {
				pg.push(' <li><a href="javascript:;" index="+1" >></a></li>');
				pg.push(' <li><a href="javascript:;" index="'+(count-1)+'" >>></a></li>');
			}
			
			pg.push('</ul>');
			pg.push('</nav>');
			return pg.join('');
		},
		goPage:function(page){
			if(page == '+1'){
				MTA.Page.Pagination.pageIndex++;
			}else if(page == '-1'){
				MTA.Page.Pagination.pageIndex--;
			}else{
				MTA.Page.Pagination.pageIndex = page;
			}
			if(MTA.Page.Pagination.fun){
				MTA.Page.Pagination.fun();
			}
			
		}
};

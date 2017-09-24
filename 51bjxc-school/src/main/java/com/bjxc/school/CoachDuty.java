package com.bjxc.school;

import java.util.Date;

public class CoachDuty {
	private Integer id;
	private Integer coachId;
	private String name;
	private Date day;

	private Integer f6;
	private String f6s;
	private String f6m;
	private Integer f6i;
	private String f6o;//操作人
	private Integer f6r;//预约角色/1学员/2教练/3驾校
	
	private Integer f7;
	private String f7s;
	private String f7m;
	private Integer f7i;
	private String f7o;
	private Integer f7r;
	
	private Integer f8;
	private String f8s;
	private String f8m;
	private Integer f8i;
	private String f8o;
	private Integer f8r;
	
	private Integer f9;
	private String f9s;
	private String f9m;
	private Integer f9i;
	private String f9o;
	private Integer f9r;
	
	private Integer f10;
	private String f10s;
	private String f10m;
	private Integer f10i;
	private String f10o;
	private Integer f10r;
	
	private Integer f11;
	private String f11s;
	private String f11m;
	private Integer f11i;
	private String f11o;
	private Integer f11r;
	
	private Integer f12;
	private String f12s;
	private String f12m;
	private Integer f12i;
	private String f12o;
	private Integer f12r;
	
	private Integer f13;
	private String f13s;
	private String f13m;
	private Integer f13i;
	private String f13o;
	private Integer f13r;
	
	private Integer f14;
	private String f14s;
	private String f14m;
	private Integer f14i;
	private String f14o;
	private Integer f14r;
	
	private Integer f15;
	private String f15s;
	private String f15m;
	private Integer f15i;
	private String f15o;
	private Integer f15r;
	
	private Integer f16;
	private String f16s;
	private String f16m;
	private Integer f16i;
	private String f16o;
	private Integer f16r;
	
	private Integer f17;
	private String f17s;
	private String f17m;
	private Integer f17i;
	private String f17o;
	private Integer f17r;
	
	private Integer f18;
	private String f18s;
	private String f18m;
	private Integer f18i;
	private String f18o;
	private Integer f18r;
	
	private Integer f19;
	private String f19s;
	private String f19m;
	private Integer f19i;
	private String f19o;
	private Integer f19r;
	
	private Integer f20;
	private String f20s;
	private String f20m;
	private Integer f20i;
	private String f20o;
	private Integer f20r;
	
	private Integer f21;
	private String f21s;
	private String f21m;
	private Integer f21i;
	private String f21o;
	private Integer f21r;
	
	private Integer rest;
	private Integer subject;
	
	public Integer publish;
	
	private Long dayTimeStamps;//day的时间截
	
	public Integer getSubject() {
		return subject;
	}
	public void setSubject(Integer subject) {
		this.subject = subject;
	}
	public Integer getRest() {
		return rest;
	}
	public void setRest(Integer rest) {
		this.rest = rest;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getCoachId() {
		return coachId;
	}
	public void setCoachId(Integer coachId) {
		this.coachId = coachId;
	}
	public Date getDay() {
		return day;
	}
	public void setDay(Date day) {
		this.day = day;
	}
	public Integer getF6() {
		return f6;
	}
	public void setF6(Integer f6) {
		this.f6 = f6;
	}
	public Integer getF7() {
		return f7;
	}
	public void setF7(Integer f7) {
		this.f7 = f7;
	}
	public Integer getF8() {
		return f8;
	}
	public void setF8(Integer f8) {
		this.f8 = f8;
	}
	public Integer getF9() {
		return f9;
	}
	public void setF9(Integer f9) {
		this.f9 = f9;
	}
	public Integer getF10() {
		return f10;
	}
	public void setF10(Integer f10) {
		this.f10 = f10;
	}
	public Integer getF11() {
		return f11;
	}
	public void setF11(Integer f11) {
		this.f11 = f11;
	}
	public Integer getF12() {
		return f12;
	}
	public void setF12(Integer f12) {
		this.f12 = f12;
	}
	public Integer getF13() {
		return f13;
	}
	public void setF13(Integer f13) {
		this.f13 = f13;
	}
	public Integer getF14() {
		return f14;
	}
	public void setF14(Integer f14) {
		this.f14 = f14;
	}
	public Integer getF15() {
		return f15;
	}
	public void setF15(Integer f15) {
		this.f15 = f15;
	}
	public Integer getF16() {
		return f16;
	}
	public void setF16(Integer f16) {
		this.f16 = f16;
	}
	public Integer getF17() {
		return f17;
	}
	public void setF17(Integer f17) {
		this.f17 = f17;
	}
	public Integer getF18() {
		return f18;
	}
	public void setF18(Integer f18) {
		this.f18 = f18;
	}
	public Integer getF19() {
		return f19;
	}
	public void setF19(Integer f19) {
		this.f19 = f19;
	}
	public Integer getF20() {
		return f20;
	}
	public void setF20(Integer f20) {
		this.f20 = f20;
	}
	public Integer getF21() {
		return f21;
	}
	public void setF21(Integer f21) {
		this.f21 = f21;
	}
	
	
	public String getF6s() {
		if(this.f6==1){
			return "空闲 ";
		}else if(this.f6==0||this.f6 == -1){
			return "休息 ";
		}else {
			return f6s;
		}
	}
	public void setF6s(String f6s) {
		this.f6s = f6s;
	}
	public String getF7s() {
		if(this.f7==1){
			return "空闲 ";
		}else if(this.f7==0||this.f7 == -1){
			return "休息 ";
		}else {
			return f7s;
		}
	}
	public void setF7s(String f7s) {
		this.f7s = f7s;
	}
	public String getF8s() {
		if(this.f8==1){
			return "空闲 ";
		}else if(this.f8==0||this.f8 == -1){
			return "休息 ";
		}else {
			return f8s;
		}
	}
	public void setF8s(String f8s) {
		this.f8s = f8s;
	}
	public String getF9s() {
		if(this.f9==1){
			return "空闲 ";
		}else if(this.f9==0||this.f9 == -1){
			return "休息 ";
		}else {
			return f9s;
		}
	}
	public void setF9s(String f9s) {
		this.f9s = f9s;
	}
	public String getF10s() {
		if(this.f10==1){
			return "空闲 ";
		}else if(this.f10==0||this.f10 == -1){
			return "休息 ";
		}else {
			return f10s;
		}
	}
	public void setF10s(String f10s) {
		this.f10s = f10s;
	}
	public String getF11s() {
		if(this.f11==1){
			return "空闲 ";
		}else if(this.f11==0||this.f11 == -1){
			return "休息 ";
		}else {
			return f11s;
		}
	}
	public void setF11s(String f11s) {
		this.f11s = f11s;
	}
	public String getF12s() {
		if(this.f12==1){
			return "空闲 ";
		}else if(this.f12==0||this.f12 == -1){
			return "休息 ";
		}else {
			return f12s;
		}
	}
	public void setF12s(String f12s) {
		this.f12s = f12s;
	}
	public String getF13s() {
		if(this.f13==1){
			return "空闲 ";
		}else if(this.f13==0||this.f13 == -1){
			return "休息 ";
		}else {
			return f13s;
		}
	}
	public void setF13s(String f13s) {
		this.f13s = f13s;
	}
	public String getF14s() {
		if(this.f14==1){
			return "空闲 ";
		}else if(this.f14==0||this.f14 == -1){
			return "休息 ";
		}else {
			return f14s;
		}
	}
	public void setF14s(String f14s) {
		this.f14s = f14s;
	}
	public String getF15s() {
		if(this.f15==1){
			return "空闲 ";
		}else if(this.f15==0||this.f15 == -1){
			return "休息 ";
		}else {
			return f15s;
		}
	}
	public void setF15s(String f15s) {
		this.f15s = f15s;
	}
	public String getF16s() {
		if(this.f16==1){
			return "空闲 ";
		}else if(this.f16==0||this.f16 == -1){
			return "休息 ";
		}else {
			return f16s;
		}
	}
	public void setF16s(String f16s) {
		this.f16s = f16s;
	}
	public String getF17s() {
		if(this.f17==1){
			return "空闲 ";
		}else if(this.f17==0||this.f17 == -1){
			return "休息 ";
		}else {
			return f17s;
		}
	}
	public void setF17s(String f17s) {
		this.f17s = f17s;
	}
	public String getF18s() {
		if(this.f18==1){
			return "空闲 ";
		}else if(this.f18==0||this.f18 == -1){
			return "休息 ";
		}else {
			return f18s;
		}
	}
	public void setF18s(String f18s) {
		this.f18s = f18s;
	}
	public String getF19s() {
		if(this.f19==1){
			return "空闲 ";
		}else if(this.f19==0||this.f19 == -1){
			return "休息 ";
		}else {
			return f19s;
		}
	}
	public void setF19s(String f19s) {
		this.f19s = f19s;
	}
	public String getF20s() {
		if(this.f20==1){
			return "空闲 ";
		}else if(this.f20==0||this.f20 == -1){
			return "休息 ";
		}else {
			return f20s;
		}
	}
	public void setF20s(String f20s) {
		this.f20s = f20s;
	}
	public String getF21s() {
		if(this.f21==1){
			return "空闲 ";
		}else if(this.f21==0||this.f21 == -1){
			return "休息 ";
		}else {
			return f21s;
		}
	}
	public void setF21s(String f21s) {
		this.f21s = f21s;
	}
	public String getF6m() {
		return f6m;
	}
	public void setF6m(String f6m) {
		this.f6m = f6m;
	}
	public Integer getF6i() {
		return f6i;
	}
	public void setF6i(Integer f6i) {
		this.f6i = f6i;
	}
	public String getF7m() {
		return f7m;
	}
	public void setF7m(String f7m) {
		this.f7m = f7m;
	}
	public Integer getF7i() {
		return f7i;
	}
	public void setF7i(Integer f7i) {
		this.f7i = f7i;
	}
	public String getF8m() {
		return f8m;
	}
	public void setF8m(String f8m) {
		this.f8m = f8m;
	}
	public Integer getF8i() {
		return f8i;
	}
	public void setF8i(Integer f8i) {
		this.f8i = f8i;
	}
	public String getF9m() {
		return f9m;
	}
	public void setF9m(String f9m) {
		this.f9m = f9m;
	}
	public Integer getF9i() {
		return f9i;
	}
	public void setF9i(Integer f9i) {
		this.f9i = f9i;
	}
	public String getF10m() {
		return f10m;
	}
	public void setF10m(String f10m) {
		this.f10m = f10m;
	}
	public Integer getF10i() {
		return f10i;
	}
	public void setF10i(Integer f10i) {
		this.f10i = f10i;
	}
	public String getF11m() {
		return f11m;
	}
	public void setF11m(String f11m) {
		this.f11m = f11m;
	}
	public Integer getF11i() {
		return f11i;
	}
	public void setF11i(Integer f11i) {
		this.f11i = f11i;
	}
	public String getF12m() {
		return f12m;
	}
	public void setF12m(String f12m) {
		this.f12m = f12m;
	}
	public Integer getF12i() {
		return f12i;
	}
	public void setF12i(Integer f12i) {
		this.f12i = f12i;
	}
	public String getF13m() {
		return f13m;
	}
	public void setF13m(String f13m) {
		this.f13m = f13m;
	}
	public Integer getF13i() {
		return f13i;
	}
	public void setF13i(Integer f13i) {
		this.f13i = f13i;
	}
	public String getF14m() {
		return f14m;
	}
	public void setF14m(String f14m) {
		this.f14m = f14m;
	}
	public Integer getF14i() {
		return f14i;
	}
	public void setF14i(Integer f14i) {
		this.f14i = f14i;
	}
	public String getF15m() {
		return f15m;
	}
	public void setF15m(String f15m) {
		this.f15m = f15m;
	}
	public Integer getF15i() {
		return f15i;
	}
	public void setF15i(Integer f15i) {
		this.f15i = f15i;
	}
	public String getF16m() {
		return f16m;
	}
	public void setF16m(String f16m) {
		this.f16m = f16m;
	}
	public Integer getF16i() {
		return f16i;
	}
	public void setF16i(Integer f16i) {
		this.f16i = f16i;
	}
	public String getF17m() {
		return f17m;
	}
	public void setF17m(String f17m) {
		this.f17m = f17m;
	}
	public Integer getF17i() {
		return f17i;
	}
	public void setF17i(Integer f17i) {
		this.f17i = f17i;
	}
	public String getF18m() {
		return f18m;
	}
	public void setF18m(String f18m) {
		this.f18m = f18m;
	}
	public Integer getF18i() {
		return f18i;
	}
	public void setF18i(Integer f18i) {
		this.f18i = f18i;
	}
	public String getF19m() {
		return f19m;
	}
	public void setF19m(String f19m) {
		this.f19m = f19m;
	}
	public Integer getF19i() {
		return f19i;
	}
	public void setF19i(Integer f19i) {
		this.f19i = f19i;
	}
	public String getF20m() {
		return f20m;
	}
	public void setF20m(String f20m) {
		this.f20m = f20m;
	}
	public Integer getF20i() {
		return f20i;
	}
	public void setF20i(Integer f20i) {
		this.f20i = f20i;
	}
	public String getF21m() {
		return f21m;
	}
	public void setF21m(String f21m) {
		this.f21m = f21m;
	}
	public Integer getF21i() {
		return f21i;
	}
	public void setF21i(Integer f21i) {
		this.f21i = f21i;
	}
	public String getF6o() {
		return f6o;
	}
	public void setF6o(String f6o) {
		this.f6o = f6o;
	}
	public Integer getF6r() {
		return f6r;
	}
	public void setF6r(Integer f6r) {
		this.f6r = f6r;
	}
	public String getF7o() {
		return f7o;
	}
	public void setF7o(String f7o) {
		this.f7o = f7o;
	}
	public Integer getF7r() {
		return f7r;
	}
	public void setF7r(Integer f7r) {
		this.f7r = f7r;
	}
	public String getF8o() {
		return f8o;
	}
	public void setF8o(String f8o) {
		this.f8o = f8o;
	}
	public Integer getF8r() {
		return f8r;
	}
	public void setF8r(Integer f8r) {
		this.f8r = f8r;
	}
	public String getF9o() {
		return f9o;
	}
	public void setF9o(String f9o) {
		this.f9o = f9o;
	}
	public Integer getF9r() {
		return f9r;
	}
	public void setF9r(Integer f9r) {
		this.f9r = f9r;
	}
	public String getF10o() {
		return f10o;
	}
	public void setF10o(String f10o) {
		this.f10o = f10o;
	}
	public Integer getF10r() {
		return f10r;
	}
	public void setF10r(Integer f10r) {
		this.f10r = f10r;
	}
	public String getF11o() {
		return f11o;
	}
	public void setF11o(String f11o) {
		this.f11o = f11o;
	}
	public Integer getF11r() {
		return f11r;
	}
	public void setF11r(Integer f11r) {
		this.f11r = f11r;
	}
	public String getF12o() {
		return f12o;
	}
	public void setF12o(String f12o) {
		this.f12o = f12o;
	}
	public Integer getF12r() {
		return f12r;
	}
	public void setF12r(Integer f12r) {
		this.f12r = f12r;
	}
	public String getF13o() {
		return f13o;
	}
	public void setF13o(String f13o) {
		this.f13o = f13o;
	}
	public Integer getF13r() {
		return f13r;
	}
	public void setF13r(Integer f13r) {
		this.f13r = f13r;
	}
	public String getF14o() {
		return f14o;
	}
	public void setF14o(String f14o) {
		this.f14o = f14o;
	}
	public Integer getF14r() {
		return f14r;
	}
	public void setF14r(Integer f14r) {
		this.f14r = f14r;
	}
	public String getF15o() {
		return f15o;
	}
	public void setF15o(String f15o) {
		this.f15o = f15o;
	}
	public Integer getF15r() {
		return f15r;
	}
	public void setF15r(Integer f15r) {
		this.f15r = f15r;
	}
	public String getF16o() {
		return f16o;
	}
	public void setF16o(String f16o) {
		this.f16o = f16o;
	}
	public Integer getF16r() {
		return f16r;
	}
	public void setF16r(Integer f16r) {
		this.f16r = f16r;
	}
	public String getF17o() {
		return f17o;
	}
	public void setF17o(String f17o) {
		this.f17o = f17o;
	}
	public Integer getF17r() {
		return f17r;
	}
	public void setF17r(Integer f17r) {
		this.f17r = f17r;
	}
	public String getF18o() {
		return f18o;
	}
	public void setF18o(String f18o) {
		this.f18o = f18o;
	}
	public Integer getF18r() {
		return f18r;
	}
	public void setF18r(Integer f18r) {
		this.f18r = f18r;
	}
	public String getF19o() {
		return f19o;
	}
	public void setF19o(String f19o) {
		this.f19o = f19o;
	}
	public Integer getF19r() {
		return f19r;
	}
	public void setF19r(Integer f19r) {
		this.f19r = f19r;
	}
	public String getF20o() {
		return f20o;
	}
	public void setF20o(String f20o) {
		this.f20o = f20o;
	}
	public Integer getF20r() {
		return f20r;
	}
	public void setF20r(Integer f20r) {
		this.f20r = f20r;
	}
	public String getF21o() {
		return f21o;
	}
	public void setF21o(String f21o) {
		this.f21o = f21o;
	}
	public Integer getF21r() {
		return f21r;
	}
	public void setF21r(Integer f21r) {
		this.f21r = f21r;
	}
	public Integer getPublish() {
		return publish;
	}
	public void setPublish(Integer publish) {
		this.publish = publish;
	}
	public Long getDayTimeStamps() {
		return day.getTime();
	}
	public void setDayTimeStamps(Long dayTimeStamps) {
		this.dayTimeStamps = dayTimeStamps;
	}
}

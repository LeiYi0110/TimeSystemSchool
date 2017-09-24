package com.bjxc.school;

import java.util.Date;

import javax.xml.crypto.Data;

/**
 * 班型
 * @author fwq
 */
public class ClassType {
	private Integer id;			// primary key,
	private Integer insId;		//'驾校ID',
	private String classcurr;		//'班型',
	private String vehicletype;	//'驾照类型',
	private Integer shuttle;	//'接送车0-定点，1-上门',
	private Integer resRegular;	//'一周能约几个小时课程',
	private Double price;		//'价格',
	private Integer coachType;	//'教练选择方式1-择优选择',
	private Integer drvingType;	//'练车方式1-自主选择',
	private Integer status;		//'状态 1-有效，0-取消',
	private String photo;		//封面图',
	private String description;	//'描述'
	private Integer paymode;	//班型支付类型
	private Integer seq;	//收费标准编号
	private Date uptime;	//更新时间
	private Integer subject;	//1:第一部分集中教学；2:第一部分网络教学；3:第四部分集中教学；4:第四部分网络教学；5:模拟器教学；6:第二部分普通教学；7:第二部分智能教学；8:第三部分普通教学；9:第三部分智能教学',
	private Integer trainningtime;	//1:普通时段；2:高峰时段；3:节假日时段
	private Integer trainningmode;	//培训模式
	private Integer chargemode;	//收费模式
	private String service;	//服务内容
	/**
	 * 是否省备案 (1 已备案)
	 */
	private Integer isProvince;

	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getInsId() {
		return insId;
	}
	public void setInsId(Integer insId) {
		this.insId = insId;
	}
	public Integer getShuttle() {
		return shuttle;
	}
	public void setShuttle(Integer shuttle) {
		this.shuttle = shuttle;
	}
	public Integer getResRegular() {
		return resRegular;
	}
	public void setResRegular(Integer resRegular) {
		this.resRegular = resRegular;
	}
	public Double getPrice() {
		if(price != null || new Double(0.0).equals(price)){
			return price/100.0;
		}
		return price/100;
	}
	public void setPrice(Double price) {
		this.price = price;
	}
	public Integer getCoachType() {
		return coachType;
	}
	public void setCoachType(Integer coachType) {
		this.coachType = coachType;
	}
	public Integer getDrvingType() {
		return drvingType;
	}
	public void setDrvingType(Integer drvingType) {
		this.drvingType = drvingType;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getClasscurr() {
		return classcurr;
	}
	public void setClasscurr(String classcurr) {
		this.classcurr = classcurr;
	}
	public String getVehicletype() {
		return vehicletype;
	}
	public void setVehicletype(String vehicletype) {
		this.vehicletype = vehicletype;
	}
	public Integer getPaymode() {
		return paymode;
	}
	public void setPaymode(Integer paymode) {
		this.paymode = paymode;
	}
	public Integer getSeq() {
		return seq;
	}
	public void setSeq(Integer seq) {
		this.seq = seq;
	}
	public Date getUptime() {
		return uptime;
	}
	public void setUptime(Date uptime) {
		this.uptime = uptime;
	}
	public Integer getSubject() {
		return subject;
	}
	public void setSubject(Integer subject) {
		this.subject = subject;
	}
	public Integer getTrainningtime() {
		return trainningtime;
	}
	public void setTrainningtime(Integer trainningtime) {
		this.trainningtime = trainningtime;
	}
	public Integer getTrainningmode() {
		return trainningmode;
	}
	public void setTrainningmode(Integer trainningmode) {
		this.trainningmode = trainningmode;
	}
	public Integer getChargemode() {
		return chargemode;
	}
	public void setChargemode(Integer chargemode) {
		this.chargemode = chargemode;
	}
	public String getService() {
		return service;
	}
	public void setService(String service) {
		this.service = service;
	}
	public Integer getIsProvince() {
		return isProvince;
	}
	public void setIsProvince(Integer isProvince) {
		this.isProvince = isProvince;
	}
	
}

package com.bjxc.school.mapper;

import org.apache.ibatis.annotations.Update;

import com.bjxc.school.TeachOutline;
import com.bjxc.school.TeachOutlineSubjectFour;
import com.bjxc.school.TeachOutlineSubjectOne;
import com.bjxc.school.TeachOutlineSubjectThree;
import com.bjxc.school.TeachOutlineSubjectTwo;

/**  
* @author huangjr  
* @date 2016年11月28日  创建  
*/
public interface TeachOutlineMapper {
	/**
	 * 添加教学大纲
	 * @param one
	 * @return
	 */
	Integer add(TeachOutline one);
	/**
	 * 更新教学大纲
	 * @param one
	 * @return
	 */
	@Update("UPDATE `teachoutline` SET  `courseNum`=#{courseNum} WHERE (`cartype`=#{cartype} and `subjectId`=#{subjectId} and `insId`=#{insId});")
	Integer update(TeachOutline one);
	
	/**
	 * 添加教学大纲 科目一学时表
	 * @param one
	 * @return
	 */
	Integer addSubjectOne(TeachOutlineSubjectOne one);
	/**
	 * 更新教学大纲 科目一学时表
	 * @param one
	 * @return
	 */
	@Update("UPDATE `teachoutlinesubjectone` SET `licenseAndUse`=#{licenseAndUse}, `trafficRules`=#{trafficRules}, `drivingBehavior`=#{drivingBehavior}, `illegalPunishment`=#{illegalPunishment}, `vehicleRegistration`=#{vehicleRegistration},"
			+ " `trafficAccident`=#{trafficAccident}, `localRegulations`=#{localRegulations}, `vehicleStructure`=#{vehicleStructure}, `vehicleMainSafety`=#{vehicleMainSafety}, `operatingMechanism`=#{operatingMechanism}, `vehiclePerformance`=#{vehiclePerformance},"
			+ " `inspectionMaintenance`=#{inspectionMaintenance}, `vehicleMaterial`=#{vehicleMaterial}, `lawsRegulations`=#{lawsRegulations} WHERE (`subPeriodId`=#{subPeriodId} and `cartype`=#{cartype} and `insId`=#{insId});")
	Integer updateSubjectOne(TeachOutlineSubjectOne one);
	
	/**
	 * 添加教学大纲 科目二学时表
	 * @param one
	 * @return
	 */
	Integer addSubjectTwo(TeachOutlineSubjectTwo one);
	/**
	 * 更新教学大纲 科目二学时表
	 * @param one
	 * @return
	 */
	@Update("UPDATE `teachoutlinesubjecttwo` SET `basistheoryKnowledge`=#{basistheoryKnowledge}, `drivingPosition`=#{drivingPosition}, `operationSpecification`=#{operationSpecification}, `inspectionAdjustment`=#{inspectionAdjustment}, `boardingActions`=#{boardingActions},"
			+ " `checkUpFront`=#{checkUpFront}, `startStop`=#{startStop}, `shiftAstern`=#{shiftAstern}, `positionRoute`=#{positionRoute}, `drivingtheoryKnowledge`=#{drivingtheoryKnowledge}, `treasury`=#{treasury}, `parkingStarted`=#{parkingStarted},"
			+ " `sideParking`=#{sideParking}, `curve`=#{curve}, `rightAngleBend`=#{rightAngleBend}, `drivingCityStreets`=#{drivingCityStreets}, `withCarDriving`=#{withCarDriving}, `independentDriving`=#{independentDriving}, `basisDrivingField`=#{basisDrivingField}"
			+ " WHERE (`subPeriodId`=#{subPeriodId} and `cartype`=#{cartype} and `insId`=#{insId});")
	Integer updateSubjectTwo(TeachOutlineSubjectTwo one);
	
	/**
	 * 添加教学大纲 科目三学时表
	 * @param one
	 * @return
	 */
	Integer addSubjectThree(TeachOutlineSubjectThree one);
	/**
	 * 更新教学大纲 科目三学时表
	 * @param one
	 * @return
	 */
	@Update("UPDATE `teachoutlinesubjectthree` SET `carDrivingThree`=#{carDrivingThree}, `changeLanes`=#{changeLanes}, `pullOver`=#{pullOver}, `turnAround`=#{turnAround}, `intersection`=#{intersection}, `pedestrianCrossing`=#{pedestrianCrossing}, `schoolArea`=#{schoolArea},"
			+ " `busStop`=#{busStop}, `passing`=#{passing}, `overtaking`=#{overtaking}, `drivingAtNight`=#{drivingAtNight}, `badDriving`=#{badDriving}, `drivingAndTested`=#{drivingAndTested}, `mountain`=#{mountain}, `highwayDriving`=#{highwayDriving},"
			+ " `routeChoice`=#{routeChoice} WHERE (`subPeriodId`=#{subPeriodId} and `cartype`=#{cartype} and `insId`=#{insId});")
	Integer updateSubjectThree(TeachOutlineSubjectThree one);
	
	/**
	 * 添加教学大纲 科目四学时表
	 * @param one
	 * @return
	 */
	Integer addSubjectFour(TeachOutlineSubjectFour one);
	/**
	 * 更新教学大纲 科目四学时表
	 * @param one
	 * @return
	 */
	@Update("UPDATE `teachoutlinesubjectfour` SET `civilizedDrivingKnow`=#{civilizedDrivingKnow}, `hazardsDistinguishes`=#{hazardsDistinguishes}, `emergencyTreatment`=#{emergencyTreatment}, `dangerousChemicals`=#{dangerousChemicals}, `drivingSafetyKnow`=#{drivingSafetyKnow},"
			+ " `caseAnalysis`=#{caseAnalysis}, `reviewAssessment`=#{reviewAssessment}, `badWeather`=#{badWeather} WHERE (`subPeriodId`=#{subPeriodId} and `cartype`=#{cartype} and `insId`=#{insId});")
	Integer updateSubjectFour(TeachOutlineSubjectFour one);
}

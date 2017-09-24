package com.bjxc.school.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.bjxc.school.DrivingField;



public interface DrivingFieldMapper {
	
	/**
	 * 搜索栏
	 * @return 
	 */
	List<DrivingField> list(@Param("searchText")String searchText,@Param("insId")Integer insId,
			@Param("start")Integer start,@Param("size")Integer size);
	
	@Select("select * from tdrivingField where areaId=#{area}")
	List<DrivingField> getByArea(@Param("area")Integer area);
	/**
	 * 得到总条数
	 * @param searchText
	 * @param insId
	 * @return
	 */
	Integer total(@Param("searchText")String searchText,@Param("insId")Integer insId);
	
	/**
	 * 增加练车场地信息
	 * @return 
	 */
	void add(DrivingField drivingField);
	
	/**
	 * 删除练车场地信息
	 * @return 
	 */
	@Delete("delete from TDrivingField where id = #{id}")
	Integer delete(Integer id);
	
	/**
	 * 停用练车场地信息
	 * @return 
	 */
	@Delete("update TDrivingField set status = #{status}  where id = #{id}")
	Integer updateDrivingFieldStatus(@Param("id")Integer id,@Param("status")Integer status);

	/**
	 * 根据(id)查询练车场地信息
	 * @return 
	 */
	@Select("select * from  TDrivingField where id = #{id}")
	DrivingField get(Integer id);
	
	/**
	 * 根据教练员查询练车场地信息
	 * @return 
	 */
	@Select("select td.* from TDrivingField td left join tcoach t on t.drivingfieldid = td.id  left join trainingrecord tr on tr.coachid=t.id where tr.id=#{recordid}")
	DrivingField findByCoach(Integer recordid);
	
	/**
	 * 修改练车场地信息
	 * @return 
	 */
	Integer update(DrivingField drivingField);

     /**
      * 练车场地导出
      */
	List<DrivingField> carlist(@Param("insId")Integer insId);
	
	/**
	 * 根据地点查询服务网点（通用）
	 */
	@Select("select dr.* from TDrivingField dr left join tteacharea te on te.id=dr.areaId where te.name=#{name} and te.insid=#{insId} and dr.Status=1")
	List<DrivingField> findByDriving(@Param("name")String name,@Param("insId")Integer insId);
	
	void updatestatus(DrivingField drivingField);
	
	/**
	 * 根据地点查询服务网点（通用）
	 */
	@Select("select * from TDrivingField  where id=#{id} and insid=#{insId} and status=1")
	List<DrivingField> findByIdDriving(@Param("id")Integer id,@Param("insId")Integer insId);
	
	DrivingField Incrementselect(@Param("insId")Integer insId);
	
	@Update("update TDrivingField set isProvince=#{type}  where seq=#{seq} and insid=(select id from TInstitution where inscode=#{inscode});")
	Integer updateIsprovince(@Param("seq")Integer seq,@Param("inscode")String inscode,@Param("type")Integer type);
	
	@Update("update TDrivingField set isNotice=1 where seq=#{seq} and insid=(select id from TInstitution where inscode=#{inscode});")
	Integer updateIsnotice(@Param("seq")Integer seq,@Param("inscode")String inscode);
}

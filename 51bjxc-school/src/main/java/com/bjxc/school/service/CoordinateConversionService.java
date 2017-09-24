package com.bjxc.school.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.SimpleFormatter;
import java.util.stream.Collectors;

import org.apache.commons.lang.StringUtils;
import org.apache.http.HttpEntity;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.bjxc.json.JacksonBinder;
import com.bjxc.school.AmapConversionResult;

@Service
public class CoordinateConversionService {
	
	private static final Logger logger = LoggerFactory.getLogger(CoordinateConversionService.class);
	
	@Value("${bjxc.amap.webServiceKey}")
	private String webServiceKey; 
	
	/**
	 * 标准坐标转化为高德坐标
	 * @param list
	 * @return
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 */
	public List<Map> conversion(List<Map> fullList) throws Exception{

		if(fullList.size() < 1){
			return fullList;
		}
		
		logger.info(String.valueOf(fullList.size()));
		int groupSize = 100;//超过100个，按100分组处理
		
		List<Map> resultlist = new ArrayList<>();
		//按100个分组
		for (int i = 0; i < fullList.size() + groupSize; i += groupSize) {
			int toIndex = i + groupSize > fullList.size() ? fullList.size() : i + groupSize;
			if(i > toIndex){
				continue;
			}
			List<Map> list = fullList.subList(i, toIndex);
			
			String coordinateString = StringUtils.join(
					list.stream().filter(f -> f.get("longtitude") != null && f.get("latitude") != null)
							.map(m -> (m.get("longtitude") + "," + m.get("latitude"))).collect(Collectors.toList()),
					";");
			String url = String.format(
					"http://restapi.amap.com/v3/assistant/coordinate/convert?key=%s&locations=%s&coordsys=gps",
					webServiceKey, coordinateString);
			
			logger.info(url);
			
			CloseableHttpClient client = HttpClients.createDefault();
			HttpGet httpGet = new HttpGet(url);
			CloseableHttpResponse response = client.execute(httpGet);

			
			try{
				HttpEntity entity = response.getEntity();
				String bodyContent = EntityUtils.toString(entity);
				
				logger.info(bodyContent);
				AmapConversionResult result = JacksonBinder.buildNonNullBinder().fromJson(bodyContent, AmapConversionResult.class);
				if(result.getInfocode().equals(10000)){
					String amapLocations = result.getLocations();
					for (String item : result.getLocations().split(";")) {
						Map map = new HashMap<>();
						map.put("longtitude", item.split(",")[0]);
						map.put("latitude", item.split(",")[1]);
						resultlist.add(map);
					}
				}
				EntityUtils.consume(entity);
			}finally{
				response.close();
			}
			if(resultlist.size() < 1){
				Map map = new HashMap<>();
				resultlist.add(map);
			}
		}

		return resultlist;
	}
	
}

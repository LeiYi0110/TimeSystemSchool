package com.bjxc.school.service;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpDelete;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bjxc.Result;
import com.bjxc.json.JacksonBinder;

@Service
public class HttpClientService {
	private static final Logger logger = LoggerFactory .getLogger(HttpClientService.class);

	@Autowired
	private CloseableHttpClient httpClient;
	@Autowired
	private RequestConfig requestConfig;
	

	/**
	 * 执行GET请求
	 * 
	 * @param url
	 * @return
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	public Result doGet(String url) throws ClientProtocolException, IOException {
		
		logger.info("get url:" + url);
		
		// 创建http GET请求
		HttpGet httpGet = new HttpGet(url);
		httpGet.setConfig(this.requestConfig);
		Result result = new Result();
		CloseableHttpResponse response = null;
		try {
			// 执行请求
			response = httpClient.execute(httpGet);
			/*
			// 判断返回状态是否为200
			if (response.getStatusLine().getStatusCode() == 200) {
				return EntityUtils.toString(response.getEntity(), "UTF-8");
			}
			*/
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode == HttpStatus.SC_OK) {
				String responseText = EntityUtils.toString(response.getEntity(), "UTF-8");
				//insertService.addHttpLog(responseText);
				logger.info("responseText:"+responseText);
				Map<String, String> responseMap = JacksonBinder
						.buildNonDefaultBinder().fromJson(responseText,
								Map.class);
				result.putAll(responseMap);
			} else {
				result.error(statusCode, response.getStatusLine()
						.getReasonPhrase());
			}
		} finally {
			if (response != null) {
				response.close();
			}
		}
		return result;
	}

	/**
	 * 带有参数的GET请求
	 * 
	 * @param url
	 * @param params
	 * @return
	 * @throws URISyntaxException
	 * @throws IOException
	 * @throws ClientProtocolException
	 */
	public Result doGet(String url, Map<String, String> params)
			throws ClientProtocolException, IOException, URISyntaxException {
		URIBuilder uriBuilder = new URIBuilder(url);
		for (String key : params.keySet()) {
			uriBuilder.addParameter(key, params.get(key));
		}
		return this.doGet(uriBuilder.build().toString());
	}

	/**
	 * 执行POST请求
	 * 
	 * @param url
	 * @param params
	 * @return
	 * @throws IOException
	 */
	public Result doPost(String url, Map<String, String> params)
			throws IOException {
		
		logger.info("post url:"+url);
		
		// 创建http POST请求
		HttpPost httpPost = new HttpPost(url);
		httpPost.setConfig(this.requestConfig);
		Result result = new Result();
		if (params != null) {
			// 设置2个post参数，一个是scope、一个是q
			List<NameValuePair> parameters = new ArrayList<NameValuePair>();
			for (String key : params.keySet()) {
				parameters.add(new BasicNameValuePair(key, (String) params
						.get(key)));
			}
			// 构造一个form表单式的实体
			UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(
					parameters, "UTF-8");
			// 将请求实体设置到httpPost对象中
			httpPost.setEntity(formEntity);
			
			String sendData = EntityUtils.toString(httpPost.getEntity(), "UTF-8");
			logger.info("post data:"+sendData);
		}

		CloseableHttpResponse response = null;
		try {
			// 执行请求
			response = httpClient.execute(httpPost);

			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode == HttpStatus.SC_OK) {
				String responseText = EntityUtils.toString(response.getEntity(), "UTF-8");
				//insertService.addHttpLog(responseText);
				//logger.info(responseText);
				Map<String, String> responseMap = JacksonBinder
						.buildNonDefaultBinder().fromJson(responseText,
								Map.class);
				result.putAll(responseMap);
			} else {
				result.error(statusCode, response.getStatusLine()
						.getReasonPhrase());
			}

		} finally {
			if (response != null) {
				response.close();
			}
		}

		return result;
	}

	/**
	 * 执行POST请求
	 * 
	 * @param url
	 * @return
	 * @throws IOException
	 */
	public Result doPost(String url) throws IOException {
		return this.doPost(url, null);
	}

	/**
	 * 提交json数据
	 * 
	 * @param url
	 * @param json
	 * @return
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public Result doPostJson(String url, String json)
			throws ClientProtocolException, IOException {
		
		logger.info("post url:"+url);
		logger.info("post data:"+json);
		
		// 创建http POST请求
		HttpPost httpPost = new HttpPost(url);
		Result result = new Result();
		httpPost.setConfig(this.requestConfig);

		if (json != null) {
			// 构造一个form表单式的实体
			StringEntity stringEntity = new StringEntity(json,
					ContentType.APPLICATION_JSON);
			// 将请求实体设置到httpPost对象中
			httpPost.setEntity(stringEntity);
		}

		CloseableHttpResponse response = null;
		try {
			// 执行请求
			response = this.httpClient.execute(httpPost);
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode == HttpStatus.SC_OK) {
				String responseText = EntityUtils.toString(response.getEntity(), "UTF-8");
				//insertService.addHttpLog(responseText);
				
				logger.info("responseText:"+responseText);
				
				Map<String, String> responseMap = JacksonBinder
						.buildNonDefaultBinder().fromJson(responseText,
								Map.class);
				result.putAll(responseMap);
			} else {
				result.setCode(statusCode);
			}

		} finally {
			if (response != null) {
				response.close();
			}
		}
		return result;
	}

	public Result upload(String url,File file) throws ClientProtocolException, IOException {
		

		HttpPost httppost = new HttpPost(url);
		Result result = new Result();
		FileBody bin = new FileBody(file);
		
		HttpEntity reqEntity = MultipartEntityBuilder.create().addPart("file", bin).build();

		
		httppost.setEntity(reqEntity);

		logger.info("upload request " + httppost.getRequestLine());
		CloseableHttpResponse response = null;
		try {
			response = this.httpClient.execute(httppost);
			HttpEntity resEntity = response.getEntity();
			if (resEntity != null) {
				//logger.info("Response content length: " + resEntity.getContentLength());
				String responseText = EntityUtils.toString(response.getEntity(), "UTF-8");
				logger.info("responseText： " + responseText);
				//insertService.addHttpLog(responseText);
				Map<String, String> responseMap = JacksonBinder
						.buildNonDefaultBinder().fromJson(responseText,
								Map.class);
				result.putAll(responseMap);
			}
			EntityUtils.consume(resEntity);
		} finally {
			response.close();
		}
		
		return result;
	}
	
	public Result doDelete(String url) throws IOException {
		
		logger.info("post url:"+url);

		HttpDelete httpDelete = new HttpDelete(url);
		httpDelete.setConfig(this.requestConfig);
		Result result = new Result();
		CloseableHttpResponse response = null;
		try {
			// 执行请求
			response = httpClient.execute(httpDelete);
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode == HttpStatus.SC_OK) {
				String responseText = EntityUtils.toString(response.getEntity(), "UTF-8");
				//insertService.addHttpLog(responseText);
				logger.info("responseText:"+responseText);
				Map<String, String> responseMap = JacksonBinder
						.buildNonDefaultBinder().fromJson(responseText,
								Map.class);
				result.putAll(responseMap);
			} else {
				result.error(statusCode, response.getStatusLine()
						.getReasonPhrase());
			}
		} finally {
			if (response != null) {
				response.close();
			}
		}
		return result;
	}
	

}
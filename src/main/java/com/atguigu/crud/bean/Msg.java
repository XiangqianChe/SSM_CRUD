package com.atguigu.crud.bean;

import java.util.HashMap;
import java.util.Map;

/**
 * General Return Class
 * 
 * @author chexq
 *
 */
public class Msg {
	// Status Code: 100-Success 200-Failure
	private int code;
	// Prompt Information
	private String msg;
	
	// Data Returned to Browser by User
	private Map<String, Object> extend = new HashMap<String, Object>();
	
	public static Msg success() {
		Msg result = new Msg();
		result.setCode(100);
		result.setMsg("Action Succeeded!");
		return result;
	}
	
	public static Msg fail() {
		Msg result = new Msg();
		result.setCode(200);
		result.setMsg("Action Failed!");
		return result;
	}
	
	public Msg add(String key, Object value) {
		this.getExtend().put(key, value);
		return this;
	}

	public int getCode() {
		return code;
	}

	public String getMsg() {
		return msg;
	}

	public Map<String, Object> getExtend() {
		return extend;
	}

	public void setCode(int code) {
		this.code = code;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

	public void setExtend(Map<String, Object> extend) {
		this.extend = extend;
	}
}

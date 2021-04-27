package com.offcn.util;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Map.Entry;

public class ObjectToMap {

	public static Map<String,String> objToMap(Object obj)throws Exception{
		Map<String,String> map = new HashMap<>();
		//将当前对象的属性充当key  属性值value
		Class<? extends Object> clazz = obj.getClass();
		Field[] declaredFields = clazz.getDeclaredFields();
		for(Field field:declaredFields) {
			field.setAccessible(true);
			//获取字段名称
			String name = field.getName();
			//获取字段的值
			Object object = field.get(obj);
			if(object instanceof Date) {
				SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy-MM-dd");
				String format = simpleDateFormat.format(object);
				map.put(name, format);
			}else {
				map.put(name, object.toString());
			}
		}
		return  map;
	}

	//map   ---  obj
	public static Object mapToObj(Map<String,String> map,Class clazz)throws Exception{
		Object newInstance = clazz.newInstance();
		for(Entry<String, String> entry :map.entrySet()) {
			String key = entry.getKey();//属性名
			String value = entry.getValue();//属性值
			//属性名称   获取属性对象
			Field field = clazz.getDeclaredField(key);
			field.setAccessible(true);
			String name = field.getType().getName();
			if(name.equals("java.util.Date")) {
				SimpleDateFormat simpleDateFormat= new SimpleDateFormat("yyyy-MM-dd");
				Date parse = simpleDateFormat.parse(value);
				field.set(newInstance, parse);
			}else if (name.equals("java.lang.Integer")) {
				field.set(newInstance, Integer.parseInt(value));
			}else {
				field.set(newInstance, value);
			}
		}
		return newInstance;
	}

}

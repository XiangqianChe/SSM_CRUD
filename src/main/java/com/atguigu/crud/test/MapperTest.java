package com.atguigu.crud.test;


import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.DepartmentExample;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

/**
 * Test DAO layer
 * @author chexq
 * Using Spring Unit Test for Spring Project is recommended, which injects components we need automatically
 * 1. Import Spring Test Module
 * 2. @ContextConfiguration Assigns the Location of Spring Configuration File
 * 3. Autowired Components we need
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"classpath:applicationContext.xml"})
public class MapperTest {

	@Autowired
	DepartmentMapper departmentMapper;
	
	@Autowired
	EmployeeMapper employeeMapper;
	
	@Autowired
	SqlSession sqlSession;
	
	/**
	 * Test DepartmentMapper
	 */
	@Test
	public void testCRUD() {
//		//1. Create Spring IOC Container
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
//		//2. Get MApper from Container
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);	
		System.out.println(departmentMapper);
		
		//1. Insert Departments
//		departmentMapper.insertSelective(new Department(null, "Development"));
//		departmentMapper.insertSelective(new Department(null, "Test"));

		//2. Create and Insert Employees
//		employeeMapper.insertSelective(new Employee(null, "Jerry", "M", "Jerry@atguigu.com", 1));
		
		//3. Insert Employees in Batch: Use sqlSession for Operations in Batch
//		for() {
//			employeeMapper.insertSelective(new Employee(null, , "M", "Jerry@atguigu.com", 1));
//		}
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0; i < 1000; i++) {
			String uid =  UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", uid + "@atguigu.com", 1));
		}
		System.out.println("BATCH COMPLETED!");
	}
	
}

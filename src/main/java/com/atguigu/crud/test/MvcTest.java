package com.atguigu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

/**
 * Test Correctness of CRUD Request with Test Request Feature in Spring Test Module
 * Spring 4 Test Needs Servlet 3.0
 * @author chexq
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations={"classpath:applicationContext.xml", 
		"file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {
	// Assign IOC of Spring MVC
	@Autowired
	WebApplicationContext context;
	// Virtualize MVC Request to Get Result
	MockMvc mockMvc;
	
	@Before
	public void initMockMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception  {
		// Mock Request to Get Return Value
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/emps").param("pn", "5"))
				.andReturn();
		
		// After Request Success, There will be PageInfo in Request Domain and We can Test with It
		MockHttpServletRequest request = result.getRequest();
		PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("Current Page: " + pi.getPageNum());
		System.out.println("Total Pages: " + pi.getPages());
		System.out.println("Total Records: " + pi.getTotal());
		System.out.println("Consecutive Display Page Number: ");
		int[] nums = pi.getNavigatepageNums();
		for(int i : nums) {
			System.out.print(" " + i);
		}
		
		// Get Employee Data
		List<Employee> list = pi.getList();
		for(Employee employee : list) {
			System.out.println("ID: " + employee.getEmpId() + "==>Name: " + employee.getEmpName());
		}
	}	
}

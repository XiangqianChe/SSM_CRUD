package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;



/**
 * Handle Employee CRUD Request
 * @author chexq
 *
 */
@Controller
@Validated
public class EmployeeController {
	
	
	@Autowired
	EmployeeService employeeService;
	
	/**
	 * Delete in Batch: 1-2-3
	 * Delete One: 1
	 * @param ids
	 * @return
	 */
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids") String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<>();
			String[] str_ids = ids.split("-");
			// Assemble id Collection
			for (String string : str_ids) {
				del_ids.add(Integer.parseInt(string));
			}
			employeeService.deleteBatch(del_ids);
		} else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		return Msg.success();
	}
	
	/**
	 * Update Employee
	 * PUT/DELETE request body is not wrapped to a Map in Tomcat, Only POST is.
	 * HttpPutFormContentFilter will wrap it to a Map, and overwritten getParameter() will fetch data in the Map
	 * @param employee
	 * @return
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
//		System.out.println(employee);
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	
	/**
	 * Query Employee By Id
	 * @param id
	 * @return
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmo(@PathVariable("id") Integer id) {
		
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	
	/**
	 * Validate Employee Name Availability
	 * @param empName
	 * @return
	 */
	@RequestMapping("/checkuser")
	@ResponseBody
	public Msg checkuser(@RequestParam("empName") String empName) {
		// Check If Employee Name is Legal Expression
		String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
		if(!empName.matches(regex)) {
			return Msg.fail().add("va_msg", "Employee Name Should be 6-16 Combined English Letters and Digits, or 2-5 Chinese Characters.");
		}
		
		// Database Employee Name Duplication Validation
		boolean b = employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		} else {
			return Msg.fail().add("va_msg", "Employee Name Unavailable.");
		}
	}
	
	/**
	 * Save Employee
	 * 1. Support JSR303 Validation
	 * 2. Import Hibernate-Validator
	 * @return
	 */
	@RequestMapping(value="/emp", method = RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee, BindingResult result) {
		if (result.hasErrors()) {
			// Validation Fail, Return Fail and Display Validation Fail Info in Modal
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("Field with Error: " + fieldError.getField());
				System.out.println("Error Infomation: " + fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorField", map);
		} else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}	
	}
	
	
	/**
	 * Import Jackson Package
	 * @param pn
	 * @return
	 */
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpsWithJson(@RequestParam(value="pn", defaultValue = "1") Integer pn) {
		// This is not A Paging Query
		// Use PageHelper Paging Plug-in
		// Before Query, Call This and Assign Page Number and Page Size
		PageHelper.startPage(pn, 5);
		// Query Following Start Page is A Paging Query		
		List<Employee> emps = employeeService.getAll();
		// Encapsulate Query Result with PageInfo, and Give PageInfo to the Page
		// PageInfo Encapsulates Detailed Paging Information, Including Our Query Result, and Assign Consecutive Display Page Number
		PageInfo page = new PageInfo(emps, 5);
		return Msg.success().add("pageInfo", page);
	}
	
	/**
	 * Query Employee Data (Paging Query)
	 * @return
	 */
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn", defaultValue = "1") Integer pn, 
			Model model) {
		// This is not A Paging Query
		// Use PageHelper Paging Plug-in
		// Before Query, Call This and Assign Page Number and Page Size
		PageHelper.startPage(pn, 5);
		// Query Following Start Page is A Paging Query		
		List<Employee> emps = employeeService.getAll();
		// Encapsulate Query Result with PageInfo, and Give PageInfo to the Page
		// PageInfo Encapsulates Detailed Paging Information, Including Our Query Result, and Assign Consecutive Display Page Number
		PageInfo page = new PageInfo(emps, 5);
		model.addAttribute("pageInfo", page);
		
		return "list";
	}
}

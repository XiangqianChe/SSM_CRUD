<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee List</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<!-- Web Path:
Relative Path Not Started with '/': Find Resources by Current Resource's Path, Causing Problems Easily
Relative Path Started with '/': Find Resources by Server's Path (http://localhost:3306) Plus Project Name
		http://localhost:3306/crud
 -->
<script type="text/javascript" src="${APP_PATH}/static/js/jquery-3.6.0.min.js"></script>
<link href="${APP_PATH}/static/bootstrap-3.4.1-dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="${APP_PATH}/static/bootstrap-3.4.1-dist/js/bootstrap.min.js"></script>
</head>
<body>

<!-- Modal to Change Employee -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Change Employee</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <p class="form-control-static" id="empName_update_static"></p>  
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_update_input" placeholder="emails@atguigu.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
			  	<input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> Male
			  </label>
			  <label class="radio-inline">
			  	<input type="radio" name="gender" id="gender2_update_input" value="F"> Female
			  </label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		      <!-- Department Submit dId -->
		      <select class="form-control" name="dId"></select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="emp_update_btn">Update</button>
      </div>
    </div>
  </div>
</div>

<!-- Modal to Add Employee -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Add Employee</h4>
      </div>
      <div class="modal-body">
        <form class="form-horizontal">
		  <div class="form-group">
		    <label class="col-sm-2 control-label">empName</label>
		    <div class="col-sm-10">
		      <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
		      <span class="help-block"></span>
		     </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">email</label>
		    <div class="col-sm-10">
		      <input type="text" name="email" class="form-control" id="email_add_input" placeholder="emails@atguigu.com">
		      <span class="help-block"></span>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">gender</label>
		    <div class="col-sm-10">
		      <label class="radio-inline">
			  	<input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> Male
			  </label>
			  <label class="radio-inline">
			  	<input type="radio" name="gender" id="gender2_add_input" value="F"> Female
			  </label>
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="col-sm-2 control-label">deptName</label>
		    <div class="col-sm-4">
		      <!-- Department Submit dId -->
		      <select class="form-control" name="dId"></select>
		    </div>
		  </div>
		</form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="emp_save_btn">Save</button>
      </div>
    </div>
  </div>
</div>

	<!-- Build Display Page -->
	<div class="container">
		<!-- Title -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- Button -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">Add</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">Delete</button>
			</div>
		</div>
		<!-- Display Table Data -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>
								<input type="checkbox" id="check_all"/>
							</th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						
					</tbody>
				</table>
			</div>
		</div>
		<!-- Display Page Info -->
		<div class="row">
			<!-- Page Word Info -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- Page Strip Info -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
	
		var totalRecord, currentPage;
		// 1. After Loading PAge, Send Ajax Request to get Page Data
		$(function() {
			// To First Page
			to_page(1);
		});
		
		function to_page(pn) {
			$.ajax({
				url:"${APP_PATH}/emps",
				data:"pn=" + pn,
				type:"GET",
				success:function(result) {
					// console.log(result);
					// 1. Parse and Display Employee Data
					build_emps_table(result);
					// 2. Parse and Display Page Information
					build_page_info(result);
					// 3. Parse and Display Page Strip Data
					build_page_nav(result);
				}
			});
		}
		
		function build_emps_table(result) {
			// Clear Table
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var genderTd = $("<td></td>").append(item.gender=='M'?"Male":"Female");
				var emailTd = $("<td></td>").append(item.email);
				var deptNameTd = $("<td></td>").append(item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
					.append("Edit");
				// Add a Custom Attribute for editBtn to Signify Current empId
				editBtn.attr("edit-id", item.empId);
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
					.append($("<span></span>").addClass("glyphicon glyphicon-trash"))
					.append("Delete");
				// Add a Custom Attribute for deleteBtn to Signify Current empId
				delBtn.attr("del-id", item.empId);
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				// Append Return the Same Element After Execution
				$("<tr></tr>").append(checkBoxTd)
					.append(empIdTd)
					.append(empNameTd)
					.append(genderTd)
					.append(emailTd)
					.append(deptNameTd)
					.append(btnTd)
					.appendTo("#emps_table tbody");
			});
		}
		// Parse and Display Page Info
		function build_page_info(result) {
			$("#page_info_area").empty();
			$("#page_info_area").append("Current " + result.extend.pageInfo.pageNum 
					+ " in " + result.extend.pageInfo.pages 
					+ " Pages (" + result.extend.pageInfo.total + " Records)");
			totalRecord = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		// Parse and Display Page Strip, Click to Change Page
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			
			// Build Elements
			var firstPageLi = $("<li></li>").append($("<a></a>").append("First").attr("href", "#"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
			if(!result.extend.pageInfo.hasPreviousPage) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				// Add Change Page Action for Elements
				firstPageLi.click(function() {
					to_page(1);
				});
				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}
			
			// Build Elements
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("Last").attr("href", "#"));
			if(!result.extend.pageInfo.hasNextPage) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				// Add Change Page Action for Elements
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});
				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}
			
			// Add First Page and Previous Page to ul
			ul.append(firstPageLi).append(prePageLi);
			// Add Page Number to ul
			$.each(result.extend.pageInfo.navigatepageNums, function(index, item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			// Add Next Page and Last Page to ul
			ul.append(nextPageLi).append(lastPageLi);
			// Add ul to nav
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
		
		// Clear Form Data, Clear Form Style
		function reset_form(ele) {
			// Syntax to convert jQuery element to a JavaScript object: $(selector)[0].reset()
			// Clear Form Data
			$(ele)[0].reset();
			// Clear Form Style
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		
		// click Add Button to Pop Up Modal
		$("#emp_add_modal_btn").click(function() {
			// Form Reset: Clear Form Data, Clear Form Style
			reset_form("#empAddModal form");
			// Send Ajax Request to Query Department Infomation and Display in Droplist
			getDepts("#empAddModal select");
			// Pop Up Modal
			$("#empAddModal").modal({
				backdrop:"static"
			});
		});
		
		// Query All and Display 
		function getDepts(ele) {
			// Clear Previous Values in Select List
			$(ele).empty();
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result) {
					// Display Department Information in Droplist
					$.each(result.extend.depts, function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
					
				}
			});
		}
		
		// Validate Form Data
		function validate_add_form() {
			// 1. Get Data and Validate with RegEx
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)) {
				show_validate_msg("#empName_add_input", "error", "Employee Name Should be 2-5 Chinese Characters, or 6-16 Combined English Letters and Digits.");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "");
			};
			// 2. Validate Email Information
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)) {
				show_validate_msg("#email_add_input", "error", "Email Format is Incorrect!");
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
			}
			return true;
		}
		
		// Display Prompt for Validation Result
		function show_validate_msg(ele, status, msg) {
			// Clear Current Element's Validation Status
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		
		// Validate Employee Name Availability
		$("#empName_add_input").change(function() {
			// Send Ajax Request to Validate Employee Name Availability
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName="+empName,
				type:"POST",
				success:function(result) {
					if(result.code==100) {
						show_validate_msg("#empName_add_input", "success", "Employee Name Available.");
						$("#emp_save_btn").attr("ajax-va","success");
					} else {
						show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			});
			
		});
		
		
		// Click to Save Employee
		$("#emp_save_btn").click(function() {
			// 1. Submit Form Data in Modal to Server to Save
			// 1. Validate Data for Server First
			if(!validate_add_form()) {
				return false;
			}
			// 1. Check Ajax Employee Name Validation Status
			if($(this).attr("ajax-va")=="error") {
				return false;
			}
			// 2. Send Ajax Request to Save Employee
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result) {
					// alert(result.msg);
					if (result.code == 100) {
						// Save Employee Success:
						// 1. Close Modal
						$("#empAddModal").modal('hide');
						// 2. Go to Last Page and Display Created Data
						// Send Ajax Request to Display Last Page
						to_page(totalRecord);
					} else {
						// Display Fail Info
						// console.log(result);
						// Display Field with Error
						if(undefined != result.extend.errorField.email) {
							// Display email with Error
							show_validate_msg("#email_add_input", "error", result.extend.errorField.email);
						}
						if(undefined != result.extend.errorField.empName) {
							// Display empName with Error
							show_validate_msg("#empName_add_input", "error", result.extend.errorField.empName);
						}
					}
					
				}
			});
		});
		
		// This Click is Bound Before the Button is Created, So It Won't Work
		// 1. Bind When the Button is Created; Or
		// 2. Bind .live()
		// No .live() in JQuery New Version, So Replace with On()
		$(document).on("click", ".edit_btn", function() {
//			alert("edit");
			
			// 1. Query Department Info and Display Department List
			getDepts("#empUpdateModal select");
			// 2. Query Employee Info and Display Employee Info
			getEmp($(this).attr("edit-id"));
			// 3. Transfer empId to updateBtn
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
			
			$("#empUpdateModal").modal({
				backdrop:"static"
			});
		});
		
		function getEmp(id) {
			$.ajax({
				url:"${APP_PATH}/emp/" + id,
				type:"GET",
				success:function(result) {
//					console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModal input[name=gender]").val([empData.gender]);
					$("#empUpdateModal select").val([empData.dId]);
				}				
			});
		}
		
		// Click Update to Update Employee Info
		$("#emp_update_btn").click(function(){
			// Validate Email Availability
			// 1. Validate Email Information
			var email = $("#email_update_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)) {
				show_validate_msg("#email_update_input", "error", "Email Format is Incorrect!");
				return false;
			} else {
				show_validate_msg("#email_update_input", "success", "");
			}
			
			//2. Send Ajax Request to Save Employee Data
			$.ajax({
				url:"${APP_PATH}/emp/" + $(this).attr("edit-id"),
				type:"PUT",
				data:$("#empUpdateModal form").serialize(),
				success:function(result) {
//					alert(result.msg);
					// 1. Close Modal
					$("#empUpdateModal").modal("hide");
					// 2. Go to Page
					to_page(currentPage);
				}				
			});
		});
		
		// Delete One
		$(document).on("click", ".delete_btn", function() {
			// 1. Pop Alert to Confirm Delete
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
//			alert($(this).parents("tr").find("td:eq(1)").text());
			if(confirm("Confirm to DELETE [" + empName + "]?")) {
				$.ajax({
					url:"${APP_PATH}/emp/" + empId,
					type:"DELETE",
					success:function(result) {
						alert(result.msg);
						// Go to page
						to_page(currentPage);
					}
				});
			}
			// 2. 
		});
		
		// Check/Uncheck All
		$("#check_all").click(function() {
			// prop() to r/w dom's built-in attributes
			// attr() to r/w custom attributes
			$(".check_item").prop("checked", $(this).prop("checked"));
		});
		
		// check_item
		$(document).on("click", ".check_item", function() {
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked", flag);
		});
		
		// Delete in Batch
		$("#emp_delete_all_btn").click(function() {
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"), function() {
				empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
				del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
			});
			// Remove last ","
			empNames = empNames.substring(0, empNames.length-1);
			// Remove last "-"
			del_idstr = del_idstr.substring(0, del_idstr.length-1);
			if(confirm("Confirm to DELETE [" + empNames + "]?")) {
				$.ajax({
					url:"${APP_PATH}/emp/" + del_idstr,
					type:"DELETE",
					success:function(result) {
						alert(result.msg);
						// Go to page
						to_page(currentPage);
					}
				});
			}
		});
		
		// To Display Correct DeptName When Editing
		$.ajaxSetup({
			  async: false
		});
	</script>
</body>
</html>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>北大青鸟办公自动化管理系统</title>
		<link href="css/style.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="js/jquery-1.11.1.js">
		</script>
		<script type="text/javascript">
			$(function()
			{
				alert("成功进入jquery");
				//取得初始值再说

				 var age=$("#age").val();
				 var SexText=$("#SexText").val();
				 var nickname=$("#nickname").val();
				 var u_mobile=$("#u_mobile").val();
				 var u_address=$("#u_address").val(); 
				 var isManager=$("#u_manager").val();
				 //点击编辑按钮，使文本可编辑,并显示文本列表
				$("#compile").click(
					function (){
					$("#personMessage :text").removeAttr("readonly");
					$("#SexText").hide();
					$("#SexSelect").show();
					$("#back").show();
					$("#save").show();
					$(this).hide();									//为什么不能改id值呢？
					}
				);
				//点击保存数据按钮，提交数据
				$("#save").click(
					function(){
						if($("#u_mobile").val().trim().length<11)//数字小于11位
						{
							alert("保存失败,手机号应多于11位");
							return;
						}
						if($("#nickname").val().trim().length==0)//昵称为空
						{			
							alert("保存失败,昵称不能为空");
							return;
						}
						if((/[^0-9]/).test($("#u_mobile").val().trim()))//手机中包含非数字
						{			
							alert("保存失败,手机需为纯数字");
							return;
						}
						
						$("#form1").submit();
						//这里执行保存的代码				
					}	
				);
				
					
				//点击返回按钮，回归原位
				$("#back").click(
					function (){
						$("#nickname").val(nickname);
						$("#age").val(age);
						$("#SexText").val(SexText);
						$("#nickname").val(nickname);
						$("#u_mobile").val(u_mobile);
						$("#u_address").val(u_address);
						$("#SexSelect").hide();
						$("#SexText").show();
						$("#personMessage :text").attr("readonly", "readonly");
						$("#back").hide();
						$("#save").hide();
						$("#compile").show();
					}	
				);
				
				//点击个人信息按钮
				$("#personMessageButton").click(
					function(){
						hideAllPage();					//初始化
						$("#personMessage").show();		//显示个人信息
					}
				);
				
				//点击写邮件
				$("#epistolizeButton").click(
					function(){
					
						hideAllPage();
						$("#epistolize").show();//隐藏其他信息
						
					}
				);
				
				
				//点击发送邮件
				$("[name='发送邮件']").click(
					function(){
					
						var sender = nickname;
						var addressee = $("[name='收件人']").val();
						var title = $("[name='邮件标题']").val();
						var context = $("[name='邮件内容']").val();
						//还有一个file 暂时不懂怎么传递
						var mailAllContext = {"mail.sender":nickname,"mail.addressee":addressee,"mail.title":title,"mail.context":context};
						//得到邮件信息的json 传输前的封装
						
						$.ajax({
							url:"mailAction!sendMail",
							data:mailAllContext,
							type:"post",
							success:function(data){
								
								//把邮件信息清空
								$("[name='收件人']").val("");
								$("[name='邮件标题']").val("");
								$("[name='邮件内容']").val("");
							}
						});
						
										
					}
				);
				
				
				//点击收邮件按钮
				$("#getMailButton").click(function(){
					hideAllPage();
					$("#getMail").show();
					$.ajax({
							url:"mailAction!getMailMessage",
							data:{"nickname":nickname},
							type:"post",
							success:function(data){
								$('[style="font-size: 70%"]').hide();
								if(data.count==0){	//说明没人给他发邮件或者他删除了
									
									return;
								}
								else{
									
									var i=0;
									
									
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime0.indexOf(".");
										var sendTime = data.sendTime0;
										alert(sendTime.substring(c).length);
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}	
										var trid="#"+"time"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title0);
										$(trid+" [width='20%']").html(data.context0);
										$(trid+" [width='17%']").html(data.isReade0);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender0);
										i++;		
									}
									
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime1.indexOf(".");
										var sendTime = data.sendTime1;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}

										var trid="#"+"time"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title1);
										$(trid+" [width='20%']").html(data.context1);
										$(trid+" [width='17%']").html(data.isReade1);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender1);
										i++;		
									}
									
									
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime2.indexOf(".");
										var sendTime = data.sendTime2;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"time"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title2);
										$(trid+" [width='20%']").html(data.context2);
										$(trid+" [width='17%']").html(data.isReade2);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender2);
										i++;		
									}
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime3.indexOf(".");
										var sendTime = data.sendTime3;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"time"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title3);
										$(trid+" [width='20%']").html(data.context3);
										$(trid+" [width='17%']").html(data.isReade3);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender3);
										i++;		
									}
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime4.indexOf(".");
										var sendTime = data.sendTime4;
										
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"time"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title4);
										$(trid+" [width='20%']").html(data.context4);
										$(trid+" [width='17%']").html(data.isReade4);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender4);
										i++;		
									}
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime5.indexOf(".");
										var sendTime = data.sendTime5;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"time"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title5);
										$(trid+" [width='20%']").html(data.context5);
										$(trid+" [width='17%']").html(data.isReade5);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender5);
										i++;		
									}						
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime6.indexOf(".");
										var sendTime = data.sendTime6;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"time"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title6);
										$(trid+" [width='20%']").html(data.context6);
										$(trid+" [width='17%']").html(data.isReade6);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender6);
										i++;		
									}
								//由于data.后面不能动态 所以只好这样了  郁闷
							
								}
							}
						});

				});
				//点击收邮件里面的删除按钮
				$("[name='删除按钮']").click(
					function(){
						
					 	if(confirm("确定执行此操作?")){//说明想删除 放回垃圾回收站
					 		var thisId = $(this).attr("id");
					 		var timess = $("#time"+thisId+" [width='27%']").text();
					 		$.ajax({
							url:"mailAction!setDeleteTrue",
							data:{"sendTime":timess},
							type:"post",
							success:function(data){	
								$("#getMailButton").click();
								
							}});	
					 	}	 	
					 	else{
					 	
					 	return;
					 	}		 	
					
					}
				);
				
				
				//点击标题 进入查看界面
				$("[width='21%']").click(
					function(){
						hideAllPage();
						$("#mailContext").show();
						var seeId = $(this).attr("id").substring(11);
						var seeTitle = $("#time"+seeId+" [width='21%']").text();
						var seeContext = $("#time"+seeId+" [width='20%']").text();
						var seeTime = $("#time"+seeId+" [width='27%']").text();
						var seeSender = $("#time"+seeId+" [width='1%']").text();
					
						$("#mailContext :text:eq(0)").val(seeTitle);
						$("#mailContext textarea").val(seeContext);
						$("#mailContext td:eq(5)").html(seeTime);
						$("#mailContext :text:eq(1)").val(seeSender);
						//设置为已读
						$.ajax({
							url:"mailAction!setReadTrue",
							data:{"sendTime":seeTime},
							type:"post",
							success:function(data){	
								alert("设置已读成功");
								
							
								
							}
						});
									
					}
				);
				
				$("[name='邮件信息返回按钮']").click(
					function(){
						$("#getMailButton").click();
					}
				);
					
				//点击垃圾邮件按钮
				$("#garbageButton").click(
					function(){
						hideAllPage();
						$("#garbage").show();
						$.ajax({
							url:"mailAction!getGarbageMailMessage",
							data:{"nickname":nickname},
							type:"post",
							success:function(data){
								if(data.count==0){	//说明有删除的邮件删除了
									return;
								}
								else{
									
									var i=0;

									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime0.indexOf(".");
										var sendTime = data.sendTime0;
										alert(sendTime.substring(c).length);
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}	
										var trid="#"+"timeTwo"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title0);
										$(trid+" [width='20%']").html(data.context0);
										$(trid+" [width='17%']").html(data.isReade0);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender0);
										i++;		
									}
									
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime1.indexOf(".");
										var sendTime = data.sendTime1;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}

										var trid="#"+"timeTwo"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title1);
										$(trid+" [width='20%']").html(data.context1);
										$(trid+" [width='17%']").html(data.isReade1);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender1);
										i++;		
									}
									
									
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime2.indexOf(".");
										var sendTime = data.sendTime2;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"timeTwo"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title2);
										$(trid+" [width='20%']").html(data.context2);
										$(trid+" [width='17%']").html(data.isReade2);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender2);
										i++;		
									}
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime3.indexOf(".");
										var sendTime = data.sendTime3;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"timeTwo"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title3);
										$(trid+" [width='20%']").html(data.context3);
										$(trid+" [width='17%']").html(data.isReade3);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender3);
										i++;		
									}
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime4.indexOf(".");
										var sendTime = data.sendTime4;
										
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"timeTwo"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title4);
										$(trid+" [width='20%']").html(data.context4);
										$(trid+" [width='17%']").html(data.isReade4);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender4);
										i++;		
									}
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime5.indexOf(".");
										var sendTime = data.sendTime5;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"timeTwo"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title5);
										$(trid+" [width='20%']").html(data.context5);
										$(trid+" [width='17%']").html(data.isReade5);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender5);
										i++;		
									}						
									if(data.count>=(i+1))
									{
										//修补框架的bug
										var c = data.sendTime6.indexOf(".");
										var sendTime = data.sendTime6;
										while(sendTime.substring(c).length!=4)
										{
											sendTime+="0";
										}
										var trid="#"+"timeTwo"+i;
										$(trid).show();
										$(trid+" [width='21%']").html(data.title6);
										$(trid+" [width='20%']").html(data.context6);
										$(trid+" [width='17%']").html(data.isReade6);
										$(trid+" [width='27%']").html(sendTime);
										$(trid+" [width='1%']").html(data.sender6);
										i++;		
									}
								//由于data.后面不能动态 所以只好这样了  郁闷
							
								}
							}
						});
							
					
					}
				)
				
				//点击垃圾箱的还原
				$('[name="垃圾箱还原"]').click(function(){
					alert("进入还原");
					var garbageId = $(this).attr("id");		//通过这个取得时间
					var createTime = $("#timeTwo"+garbageId+" [width='27%']").html();
					$.ajax({
							url:"mailAction!setDeleteFalse",
							data:{"sendTime":createTime},
							type:"post",
							success:function(data){
							
							$("#garbageButton").click();
				
					}});
				
				
				});
				
				
				
				
				//点击休假
				$("#garbageButton").click(
					function(){
					
					if("true".equals(isManager))//是管理员就回到if
					{
						hideAllPage();
						$("#holidayForBoos").show();
						
						
						
						
						
						
					
					
					
					
					
					
					}else{
					
						hideAllPage();
						$("#holidayForEpe").show();
					
					
					
					
					
					}
					
			
				});
				
				
				
				
				
					
				
				//点击垃圾箱的删除
				$('[name="垃圾箱删除按钮"]').click(function(){
					alert("进入删除");
					var garbageId = $(this).attr("id");		//通过这个取得时间
					var createTime = $("#timeTwo"+garbageId+" [width='27%']").html();
					$.ajax({
							url:"mailAction!deleteForever",
							data:{"sendTime":createTime},
							type:"post",
							success:function(data){
							
							$("#garbageButton").click();
				
					}});
				
				
				
				
				});
				
				
				
				
				
				
				
				
	
				
				//隐藏所有页面的代码
				function hideAllPage(){
					
				//第一个页面恢复初始值//相当于点了一下返回
					$("#personMessage :text").attr("readonly", "readonly");//让他变成不可写的先
					$("#SexSelect").hide();
					$("#back").hide();
					$("#save").hide();
					$("#nickname").val(nickname);
					$("#age").val(age);
					$("#SexText").val(SexText);
					$("#nickname").val(nickname);
					$("#u_mobile").val(u_mobile);
					$("#u_address").val(u_address);
					$("#SexText").show();
					$("#compile").show();
				//所有板块隐藏
					$("#personMessage").hide();
					$("#getMail").hide();
					$("#epistolize").hide();
					$("[title='sssssss']").hide();
					$("#mailContext").hide();
					$("#garbage").hide();
					$("#holidayForEpe").hide();
					$("#holidayForBoos").hide();
					
				}
				
				
				
				
	
				//初始化隐藏一下
				//$("#SexText").hide();
				$("#SexSelect").hide();
				$("#back").hide();
				$("#save").hide();			//起始的时候别的页面时隐藏的
				$("#epistolize").hide();	
				$("#getMail").hide();
				$("#mailContext").hide();
				$("#garbage").hide();
				$("#holidayForEpe").hide();
				$("#holidayForBoos").hide();
				
			}	
			);
			
		</script>


  </head>
  

	<body>
		<div class="top">
			<div class="global-width">
				ye<img src="Images/logo.gif" class="logo" />
			</div>
		</div>
		<div class="status">
			<div class="global-width">
				<s:property value="employee.name"/>你好！欢迎访问青鸟办公管理系统！&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="#" onclick="location.href='loginOut.action'";>注销</a>
			</div>
		</div>
<!-- 		<form id="myForm" name="myForm" action="userInfo!editData.action" method="post"> -->
		<input type="hidden" name="u.id" value="26"/>
		<input type="hidden" name="u.sex" value="2" id="u_sex"/>
		<input type="hidden" name="u.supper" value="0" id="u_supper"/>
		<div class="main">
			<div class="global-width">
				
 
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<title>北大青鸟办公自动化管理系统</title>
		<link href="css/style.css" rel="stylesheet" type="text/css" />
	</head>
  
  <body>
    <div class="nav" id="nav">
					<div class="t"></div>
					<dl>
							<dt onclick="this.parentNode.className=this.parentNode.className=='open'?'':'open';">信息管理 
						</dt>
						<dd>
							<a id="personMessageButton">个人信息</a>
						</dd>
					</dl>
					<dl>
						<dt
							onclick="this.parentNode.className=this.parentNode.className=='open'?'':'open';">
							邮件管理
						</dt>
						<dd>
							<a id="epistolizeButton">写邮件</a>
						</dd>
						<dd>
							<a id="getMailButton">收邮件</a>
						</dd>
						<dd>
							<a id="garbageButton">垃圾邮件</a>
						</dd>
					</dl>
					<dl>
						<dt
							onclick="this.parentNode.className=this.parentNode.className=='open'?'':'open';">
							考勤管理
						</dt>
						<dd>
							<a id="holidayButton" >休假</a>
						</dd>
					</dl>
					
					<dl >
					
						<dt
							onclick="this.parentNode.className=this.parentNode.className=='open'?'':'open';">
							权限管理
						</dt>
						<dd>
							<a href="userInfo!singleAccountData.action" target="_self">个人账户</a>
						</dd>
						
					</dl>
				</div>
  </body>
</html>
 					
 					
 					
 					
					<!--  这是个人信息页面 -->
					<div class="action" id="personMessage">
						<div class="t">
							个人信息
						</div>
						<div class="pages">
							<form id="form1" method="post"
							action="employeeAction!modifyMessage">
							<table width="90%" border="0" cellspacing="0" cellpadding="0">
								<tr >
									<td align="right" width="30%">昵称：</td><td  align="left"><input type="text" name="employee.name" value='<s:property value="employee.name" />' readonly id="nickname"/><font style="color:#FF0000">*</font></td>
								</tr>
								<tr >
									<td align="right" width="30%">年龄：</td><td  align="left"><input type="text" name="employee.age" value="<s:property value="employee.age" />" readonly id="age"/></td>
								</tr>
								<tr >
									<td align="right" width="30%">性别：</td><td  align="left">
									
										<input type="text"  value="<s:property value="employee.sex" />" readonly id="SexText"/>
                                    	<select id="SexSelect" name="employee.sex">
                                          <option value ="男">男</option>
                                          <option value ="女">女</option>
                                     	</select>
									</td>
								</tr>
								<tr >
									<td align="right" width="30%">手机：</td><td  align="left"><input type="text" name="employee.tel" value="<s:property value="employee.tel" />" readonly id="u_mobile"/><font style="color:#FF0000">*</font></td>
								</tr>
								<tr >
									<td align="right" width="30%">地址：</td><td  align="left"><input type="text" name="employee.address" value="<s:property value="employee.address" />" readonly id="u_address"/></td>
								</tr>
								<tr >
                                
									<td align="center" colspan="2"><br/><input type="button" id="compile" value="编辑数据" /> <input type="button"  id="save" value="保存数据" /><input type="button"  id="back" value="返回" /></td>
                               
								</tr>
								<tr style="display: none;">
								<td><input type="text" name="employee.manager" value="<s:property value='employee.isManager' />" readonly id="u_manager"/></td>
								</tr>
								
														
							</table>
							</form>				
						</div>
					</div>
					
					
					
					<!--  这是写邮件页面 -->
					<div class="action" id="epistolize">
						<div class="t">
							写邮件
						</div>
						<div class="pages">
							
							<table width="90%" border="0" cellspacing="0" cellpadding="0">
								<tr >
									<td align="right" width="30%">收件人：</td>
								<td  align="left">
									<select name="收件人">	
										<s:iterator value="nameList" var="na"> 					
											<option value="<s:property value='#na' />"><s:property value="#na" /></option>
										</s:iterator>
									</select>
								</td>
								</tr>
								<tr >
									<td align="right" width="30%">邮件标题：</td><td  align="left"><input type="text" name="邮件标题" /><font style="color:#FF0000">*</font></td>
								</tr>
	
								<tr >
									<td align="right" width="30%">邮件内容：</td><td  align="left"><textarea cols="50" rows="8" name="邮件内容" ></textarea></td>
								</tr>
								<tr >
									<td align="right" width="30%">上传附件：</td><td  align="left"><input type="file" /><font style="color:#FF0000">*</font></td>
								</tr>
								<tr >
									<td align="center" colspan="2"><br/><input type="button" value="发送邮件" name="发送邮件" /></td>
								</tr>						
							</table>
						</div>
					</div>
					
					
					
							<!--  这是收邮件页面  		-->
					<div class="action" id="getMail">
						<div class="t">
							收邮件
						</div>
						<div class="pages" >
							<table width="90%" border="0" cellspacing="0" cellpadding="0">
								<tr style="font-size: 69%">
									<td align="center" width="20%">邮件标题</td><td align="center" width="20%">邮件内容</td>
									<td align="center" width="17%">是否已读</td><td align="center" width="27%">时间</td>
									<td align="center" width="15%">操作</td>
								</tr>
								<s:iterator begin="1" end="50" status="x">
								<tr style="font-size: 70%" id="time<s:property value='#x.index' />" title="sssssss">
									<td align="center" id="myMailTitle<s:property value='#x.index' />" width="21%">邮件标题</td><td align="center" width="20%">邮件内容</td>
									<td align="center" width="17%">是否已读</td><td align="center" width="27%">时间</td>
									<td align="center" width="1%" style="display: none;">发送者(用于保存数据的)</td>
									<td align="center" width="15%"><a name="删除按钮"  id="<s:property value='#x.index' />" >删除</a></td>
								</tr>
								</s:iterator>
							</table>
						</div>
					</div>
					
					<!--  这是查看邮件内容  		-->
					
					<div class="action" id="mailContext">
						<div class="t">
							邮件信息详情
						</div>
						<div class="pages" >
							<table width="90%" border="0" cellspacing="0" cellpadding="0">
								<tr >
									<td align="right" width="30%">邮件标题：</td><td  align="left"><input type="text" name="邮件标题" readonly="readonly" /></td>
								</tr>
	
								<tr >
									<td align="right" width="30%">邮件内容：</td><td  align="left"><textarea cols="50" rows="8" name="邮件内容" readonly="readonly" ></textarea></td>
								</tr>
								<tr >
									<td align="right" width="30%">发送时间：</td><td  align="left"></td>
								</tr>
								<tr >
									<td align="right" width="30%">来自：</td><td  align="left"><input type="text" name="发件人" readonly="readonly" /></td>
								</tr>
								<tr >
									<td align="center" colspan="2"><br/><input type="button" value="返回" name="邮件信息返回按钮" /></td>
								</tr>
							</table>
						</div>
					</div>
					
					
					
					
					
					<!--  这是垃圾邮件页面  		-->
					<div class="action" id="garbage">
						<div class="t">
							收邮件
						</div>
						<div class="pages" >
							<table width="90%" border="0" cellspacing="0" cellpadding="0">
								<tr style="font-size: 69%">
									<td align="center" width="20%">邮件标题</td><td align="center" width="20%">邮件内容</td>
									<td align="center" width="17%">是否已读</td><td align="center" width="27%">时间</td>
									<td align="center" width="15%">操作</td>
								</tr>
								<s:iterator begin="1" end="50" status="x">
								<tr style="font-size: 70%" id="timeTwo<s:property value='#x.index' />" title="sssssss">
									<td align="center" id="myMailTitle<s:property value='#x.index' />" width="21%">邮件标题</td><td align="center" width="20%">邮件内容</td>
									<td align="center" width="17%">是否已读</td><td align="center" width="27%">时间</td>
									<td align="center" width="15%"><a name="垃圾箱删除按钮"  id="<s:property value='#x.index' />" >删除</a>
									<a name="垃圾箱还原"  id="<s:property value='#x.index' />" >还原</a></td>
								</tr>
								</s:iterator>
							</table>
						</div>
					</div>
					
					
					
					<!--  这是休假页面  		-->
					<div class="action" id="holidayForEpe">
						<div class="t">
							休假信息列表
						</div>
						<div class="pages" >
							<table width="90%" border="0" cellspacing="0" cellpadding="0">
								<tr style="font-size: 69%">
									<td align="center" width="20%">邮件标题</td><td align="center" width="20%">邮件内容</td>
									<td align="center" width="17%">是否已读</td><td align="center" width="27%">时间</td>
									<td align="center" width="15%">操作</td>
								</tr>
								<s:iterator begin="1" end="50" status="x">
								<tr style="font-size: 70%" id="timeTwo<s:property value='#x.index' />" title="sssssss">
									<td align="center" id="myMailTitle<s:property value='#x.index' />" width="21%">邮件标题</td><td align="center" width="20%">邮件内容</td>
									<td align="center" width="17%">是否已读</td><td align="center" width="27%">时间</td>
									<td align="center" width="15%"><a name="垃圾箱删除按钮"  id="<s:property value='#x.index' />" >删除</a>
									<a name="垃圾箱还原"  id="<s:property value='#x.index' />" >还原</a></td>
								</tr>
								</s:iterator>
							</table>
						</div>
					</div>
					
					<!--  这是休假页面  		-->
					<div class="action" id="holidayForBoos">
						<div class="t">
							休假信息列表
						</div>
						<div class="pages" >
							<table width="90%" border="0" cellspacing="0" cellpadding="0">
								<tr style="font-size: 69%">
									<td align="center" width="20%">邮件标题</td><td align="center" width="20%">邮件内容</td>
									<td align="center" width="17%">是否已读</td><td align="center" width="27%">时间</td>
									<td align="center" width="15%">操作</td>
								</tr>
								<s:iterator begin="1" end="50" status="x">
								<tr style="font-size: 70%" id="timeTwo<s:property value='#x.index' />" title="sssssss">
									<td align="center" id="myMailTitle<s:property value='#x.index' />" width="21%">邮件标题</td><td align="center" width="20%">邮件内容</td>
									<td align="center" width="17%">是否已读</td><td align="center" width="27%">时间</td>
									<td align="center" width="15%"><a name="垃圾箱删除按钮"  id="<s:property value='#x.index' />" >删除</a>
									<a name="垃圾箱还原"  id="<s:property value='#x.index' />" >还原</a></td>
								</tr>
								</s:iterator>
							</table>
						</div>
					</div>
					
						
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
					
					
					
					
					

					
			</div>
		</div>
<!-- 		</form> -->
		<div class="copyright">
			Copyright &nbsp; &copy; &nbsp; 北大青鸟
		</div>
 
	</body>
</html>











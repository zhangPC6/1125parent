<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>添加需求分析信息</title>
<link rel="stylesheet" type="text/css" href="skin/css/base.css">
	<script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/utf8-jsp/ueditor.config.js"></script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/utf8-jsp/ueditor.all.min.js"> </script>
	<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/utf8-jsp/lang/zh-cn/zh-cn.js"></script>

	<script type="application/javascript">
        var ue = UE.getEditor('editor');

        function commit(){
             $("#form15").submit();
		}
	</script>
	<style type="text/css">
		div{
			width:100%;
		}
	</style>
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" c1ellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
	<tr>
		 <td height="26" background="skin/images/newlinebg3.gif">
			  <table width="58%" border="0" cellspacing="0" cellpadding="0">
				  <tr>
					  <td >
						当前位置:论坛>>评论
					  </td>
				 </tr>
			  </table>
		</td>
	</tr>
</table>

<div>

<form name="form2" action="${pageContext.request.contextPath}/saveEvaluate" id="form15">
<input type="hidden" name="forumFk" value="${fe.forumid}">
<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="2" background="skin/images/tbg.gif">&nbsp;评论&nbsp;</td>
</tr>
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">
				<span >
					<img src='${pageContext.request.contextPath}/img/0.jpg' height='50px' width='50px'/>
				</span>
			</td>
			<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<span>发布人：${fe.employee.ename}</span><br>
				<span>发布时间：<fmt:formatDate value="${fe.createtime}" pattern="yyyy-MM-dd" /> </span><br>
				<span>标题：${fe.forumtitle} </span>
				<span>内容：${fe.forumcontent}</span>

			</td>
		</tr>

	<c:forEach items="${sessionScope.fe.firstEvaluate}" var="eval">
		<tr >
			<td align="right" bgcolor="#FAFAF1" height="22">
					<span >
						<img src='${pageContext.request.contextPath}/img/0.jpg' height='50px' width='50px'/>
					</span>
			</td>
			<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
				<span>评论人：${eval.evaluateEmployee.ename}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<span>评论时间：<fmt:formatDate value="${eval.updatetime}" pattern="yyyy-MM-dd HH:mm:ss" /> </span><br>
				<span>评论内容：${eval.evacontent}</span>
				&nbsp;<span><a href="answer.jsp?forumid=${fe.forumid}&evaid=${eval.evaid}">【回复】</a></span>
			</td>
		</tr>
	      <c:if test="${not empty eval.childEvaluate}">
                 <c:forEach items="${eval.childEvaluate}" var="ev">
							<tr>
									<td align="right" bgcolor="#FAFAF1" height="22">
											<span >
												<img src='${pageContext.request.contextPath}/img/0.jpg' height='50px' width='50px'/>
											</span>
									</td>
									<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
										<span>${ev.evaluateEmployee.ename}&nbsp;回复了&nbsp;${eval.evaluateEmployee.ename}</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<span>回复时间：<fmt:formatDate value="${ev.updatetime}" pattern="yyyy-MM-dd HH:mm:ss" /> </span><br>
										<span>回复内容：${ev.evacontent}</span>
										&nbsp;<span><a href="#">【回复】</a></span>
									</td>
							</tr>

	             </c:forEach>

	      </c:if>
	</c:forEach>

	<%--<%  for(int i=0;i<3;i++){%>
	<tr>
		<td align="right" bgcolor="#FAFAF1" height="22"></td>
		<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		</td>
	</tr>
		<% } %>
--%>

	<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">我也说两句：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
	<script id="editor" name="evacontent" type="text/plain" style="width:1024px;height:100px;"></script>
	</td>
	</tr>
<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
&nbsp;
<a href="javascript:commit()" class="coolbg">发布</a>
<a href="${pageContext.request.contextPath}/forum.jsp" class="coolbg">返回</a>
</td>
</tr>

</table>
 </form>

</div>

</body>
</html>
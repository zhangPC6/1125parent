<%@ page language="java"  pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
             $("#form3").submit();
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
<div>
<form name="form2" action="${pageContext.request.contextPath}/saveForumPost" id="form3">

<table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center" style="margin-top:8px">
<tr bgcolor="#E7E7E7">
	<td height="24" colspan="2" background="skin/images/tbg.gif">&nbsp;发帖&nbsp;</td>
</tr>

<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">标题：</td>
	<td  align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<input name="forumtitle"/></td>
</tr>
<tr >
	<td align="right" bgcolor="#FAFAF1" height="22">内容：</td>
	<td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';" onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
		<script id="editor" name="forumcontent" type="text/plain" style="width:1024px;height:500px;"></script>
	</td>
</tr>
<tr bgcolor="#FAFAF1">
<td height="28" colspan=4 align=center>
	&nbsp;
	<a href="javascript:commit()" class="coolbg">发布</a>
	<a href="forumpost.jsp" class="coolbg">返回</a>
</td>
</tr>
</table>

</form>
</div>

</body>
</html>
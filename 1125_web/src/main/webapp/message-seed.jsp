<%@ page language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>发消息</title>
    <link rel="stylesheet" href="layui/css/layui.css">
    <script type="application/javascript" src="js/jquery-3.4.1.js" charset="UTF-8"></script>
    <script type="application/javascript" src="layui/layui.all.js" charset="UTF-8"></script>

    <script type="text/javascript">
        //日期时间选择器
        $(function () {
            layui.use('laydate', function () {
                var laydate = layui.laydate;
                laydate.render({
                    elem: '#test5'
                    , type: 'datetime'
                });
            });
        });

        function commit() {
            $("#form12").submit();
        }
    </script>
    <link rel="stylesheet" type="text/css" href="skin/css/base.css">
</head>
<body leftmargin="8" topmargin="8" background='skin/images/allbg.gif'>

<!--  快速转换位置按钮  -->
<table width="98%" border="0" cellpadding="0" cellspacing="1" bgcolor="#D1DDAA" align="center">
    <tr>
        <td height="26" background="skin/images/newlinebg3.gif">
            <table width="58%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td>
                        当前位置:消息>>发送消息
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<form name="form2" id="form12" action="${pageContext.request.contextPath}/sendMsg" method="post">

    <table width="98%" border="0" cellpadding="2" cellspacing="1" bgcolor="#D1DDAA" align="center"
           style="margin-top:8px">
        <tr bgcolor="#E7E7E7">
            <td height="24" colspan="2" background="skin/images/tbg.gif">&nbsp;发信息&nbsp;</td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">收件人：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <select name="recvp" id="rep">
                    <option value="1">选取收件人</option>
                </select>
            </td>
        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">定时发送时间：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"  onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <input type="text" name="msgtime" class="layui-input" id="test5" placeholder="yyyy-MM-dd HH:mm:ss">
            </td>

        </tr>
        <tr>
            <td align="right" bgcolor="#FAFAF1" height="22">内容：</td>
            <td align='left' bgcolor="#FFFFFF" onMouseMove="javascript:this.bgColor='#FCFDEE';"
                onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
                <textarea rows=15 cols=130 name="msgcontent"></textarea></td>
        </tr>


        <tr bgcolor="#FAFAF1">
            <td height="28" colspan=4 align=center>
                &nbsp;
                <a href="javascript:commit()" class="coolbg">保存</a>
            </td>
        </tr>
    </table>

</form>


</body>
</html>
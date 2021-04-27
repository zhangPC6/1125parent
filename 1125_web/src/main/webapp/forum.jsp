<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
    <title>main</title>
    <base target="_self">
  
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/skin/css/main.css" />

    <script type="application/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript">
        $(function(){
            $.ajax({
                type:'GET',
                url:'${pageContext.request.contextPath}/showAllForumPost',
                dataType:'json',
                success:function(resultData){
                    var i =0;
                    var tr ="";
                    $(resultData).each(function(index,item){
                        i++;
                        if(index %3 ==0){
                            tr ="<tr>";
                        }
                        var newdate = new Date(item.createtime);
                        tr += "<td><ul> <li class='ue-clear'> <span id='p'> <img src='/upfile/"+item.employee.pic+"' height='50px' width='50px'/></span><br><font>发布时间："+newdate.getFullYear()+"-"+(newdate.getMonth()+1)+"-"+newdate.getDate()+"</font><br>标题：<a href='${pageContext.request.contextPath}/showForumpostAndEvaluate?forumid="+item.forumid+" 'class='notice-title'>"+item.forumtitle+"</a></li></ul></td>";
                        if(index!=0 && i%3 ==0 ) {
                            var ttr = tr + "</tr>";
                            $("#ff").before(ttr);
                        }
                    });
                    if(i %3 !=0){
                        var ttr2 = tr + "</tr>";
                        $("#ff").before(ttr2);
                    }
                },
                error:function(){
                    alert("-----");
                }
            });
        })
    </script>


</head>
<body leftmargin="8" topmargin='8'>

<table width="98%" align="center" border="0" cellpadding="3"
       cellspacing="1" bgcolor="#CBD8AC"
       style="margin-bottom: 8px; margin-top: 8px;">
    <tr>
        <td colspan="3"
            class='title'>
            <span>生活广场</span> |<span>租房信息</span>|<span>我的帖子</span>
            <a href='forum-add.jsp' style='padding-left: 900px'><font size="5">发帖</font></a>
        </td>
    </tr>


    <tr id="ff">

    </tr>


</table>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>


<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>绿地中央广场综合物业办公系统 - 基础表格</title>
    <meta name="keywords" content="综合办公系统">
    <meta name="description" content="综合办公系统">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/select/bootstrap-select.min.css" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper2 wrapper-content2 animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="ibox-content">
            <div class="row">
                <div class="col-sm-3 col-sm-offset-2 text-right">
                    <h3><small>搜索条件:</small></h3>
                </div>
                <div class="col-sm-2">
                    <select id="st" name="searchType" class="form-control">
                        <option value="0">选择类型</option>
                        <option value="1">员工姓名</option>
                        <option value="2">员工备注</option>
                    </select>
                </div>

                <div class="col-sm-3">
                    <div class="input-group">
                        <input type="text" id="kc" name="keyCode" placeholder="请输入关键词" class="input-sm form-control">
                        <span class="input-group-btn">
                                        <button type="button" id="bt" class="btn btn-sm btn-primary">搜索</button>
                                    </span>
                    </div>
                </div>
                <div class="col-sm-2 text-right">
                    <a href="save-employee.jsp" class="btn btn-sm btn-primary" type="button"><i
                            class="fa fa-plus-circle"></i> 添加员工</a>
                </div>
            </div>
            <div class="hr-line-dashed2"></div>
            <div class="table-responsive">
                <c:if test="${not empty pageInfo}">
                    <table class="table table-striped list-table">
                        <thead>
                        <tr>
                            <th>选择</th>
                            <th>序号</th>
                            <th>姓名</th>
                            <th>职位</th>
                            <th>性别</th>
                            <th>年龄</th>
                            <th>联系电话</th>
                            <th>入职时间</th>
                            <th class="text-center">操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${requestScope.pageInfo.list}" var="emp">
                            <tr>
                                <td><input type="checkbox" id="ck" name="ck" class="ck"></td>
                                <td>${emp.eid}</td>
                                <td>${emp.ename}</td>
                                <td>${emp.dept.dname}</td>
                                <td>${emp.esex}</td>
                                <td>${emp.eage}</td>
                                <td>${emp.telephone}</td>
                                <td><fmt:formatDate value="${emp.hiredate}" pattern="yyyy-MM-dd"></fmt:formatDate></td>
                                <td class="text-right">
                                    <a href="${pageContext.request.contextPath}/showEmpByPk?eid=${emp.eid}"
                                       class="btn btn-primary btn-xs"><i
                                            class="fa fa-edit"></i>编辑</a>
                                    <button class="btn btn-danger btn-xs btndel"><i class="fa fa-close"></i>删除</button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>

            <div class="row">
                <div class="col-sm-5">
                    <button class="btn btn-sm btn-primary" type="button" onclick="checkAll()"><i class="fa fa-check-square-o"></i> 全选
                    </button>
                    <button class="btn btn-sm btn-primary" type="button" onclick="uncheckAll()"><i class="fa fa-square-o"></i> 反选</button>
                    <button class="btn btn-sm btn-primary" type="button" onclick="batchDelete()"><i class="fa fa-times-circle-o"></i> 删除
                    </button>
                    <button id="demo1" class="btn btn-sm btn-primary" type="button" onclick="outPutExcel()"><i
                            class="fa fa-table"></i> 导出Excel
                    </button>
                    <form method="post" enctype="multipart/form-data" action="inExcel">
                        file:<input type="file" name="files">
                        <input type="submit" value="导入">
                    </form>
                </div>

                <div class="col-sm-7 text-right">
                    <span>共有${pageInfo.pages}页,当前是第${pageInfo.pageNum}页</span>
                    <c:if test="${!pageInfo.isFirstPage}">  <%--或者${!pageInfo.isFirstPage}--%>
                        <a href='${pageContext.request.contextPath}/showAllEmp?pageNum=1'>首页</a>
                        <a href='${pageContext.request.contextPath}/showAllEmp?pageNum=${pageInfo.prePage}'>上一页</a>
                    </c:if>
                    <c:if test="${!pageInfo.isLastPage}"> <%--或者${!pageInfo.isLastPage}--%>
                        <a href='${pageContext.request.contextPath}/showAllEmp?pageNum=${pageInfo.nextPage}'>下一页</a>
                        <a href='${pageContext.request.contextPath}/showAllEmp?pageNum=${pageInfo.pages}'>尾页</a>
                    </c:if>
                </div>
            </div>

        </div>
    </div>
</div>

<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/select/bootstrap-select.min.js"></script>
<script src="js/plugins/sweetalert/sweetalert.min.js"></script>


<script>
    //全选
    function checkAll() {
        //过去所有的复选框 选中
        var cks = $(".ck");
        for (var i = 0; i < cks.length; i++) {
            cks[i].checked = true;
        }
    }

    // 反选
    function uncheckAll() {
        //过去所有的复选框 选中
        var cks = $(".ck");
        for (var i = 0; i < cks.length; i++) {
            cks[i].checked = !cks[i].checked;
        }
    };

    // 批量删除
    function batchDelete() {
        //获取选中的复选框
        var arr =  $("input:checkbox:checked");
        if(arr.length>0){
            var ids = new Array();
            for(var i=0;i<arr.length;i++){
                ids[i]=$(arr[i]).val();
            }
            $.ajax({
                type:'GET',
                url:'deleteEmpByPk?ids='+ids,
                dataType:'json',
                success:function(rs){
                    // 以下是成功的提示框，请在ajax回调函数中执行
                    if(rs.flag){
                        swal(rs.msg,"您已经永久删除了这条信息","success");
                        window.location.href="${pageContext.request.contextPath}/showAllEmp";
                    }else{
                        alert(rs.msg);
                    }
                }
            });
        }else{
            alert("必须勾选删除的数据");
            return false;
        }
    }

    $(function () {
        $("#bt").click(function(){
            var keyCode = $("#kc").val();
            if(keyCode.length===0){
                alert("必须输入我们的搜索的关键词");
                return  false;
            }else{
                var searchType = $("#st").val();
                var url="${pageContext.request.contextPath}/showAllEmp?keyCode="+keyCode+"&searchType="+searchType;
                window.location.href=url;
            }
        });

        $("#demo1").click(function(){
            var info = prompt("输入导出文件名称");
            window.location.href="${pageContext.request.contextPath}/outPutExcel?filename="+info;
        });

        // 设置按钮的样式
        $('.selectpicker').selectpicker('setStyle', 'btn-white').selectpicker('setStyle', 'btn-sm');

        //点击删除
        $('.btndel').click(function () {
            swal({
                title: "您确定要删除这条信息吗",
                text: "删除后将无法恢复，请谨慎操作！",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "删除",
                closeOnConfirm: false
            }, function () {//此函数是点击删除执行的函数
                //这里写ajax代码
                // 以下是成功的提示框，请在ajax回调函数中执行
                swal("删除成功！", "您已经永久删除了这条信息。", "success");
            });
        });
    });
</script>

</body>


</html>

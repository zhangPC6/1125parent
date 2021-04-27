<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title>办公系统 - 基础表格</title>
    <meta name="keywords" content="办公系统">
    <meta name="description" content="办公系统">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="${pageContext.request.contextPath}/css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/select/bootstrap-select.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/plugins/zTreeStyle/zTreeStyle.css" />
</head>

<body class="gray-bg">
<div class="wrapper2 wrapper-content2 animated fadeInRight">
    <div class="row">
        <div class="col-sm-5">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>添加角色</h5>
                </div>
                <div class="ibox-content">

                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色名称：</label>
                        <div class="col-sm-8">
                            <input type="text" id="rolename" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色描述：</label>

                        <div class="col-sm-8">
                            <input type="text" id="roledis"  class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色权限：</label>

                        <div class="col-sm-8">
                            <ul id="treeDemo" class="ztree"></ul>
                            <%-- <ul>
                                <li>注销员工</li>
                                <li>添加员工</li>
                                <li>报销审批</li>
                                <li>
                                   <ul>
                                       <li>请假审批</li>
                                       <li>请假申请</li>
                                   </ul>
                                </li>

                             </ul>--%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">是否启用：</label>
                        <div class="col-sm-8">
                            <input type="radio" value="1" class="st" name="status" >启用
                            <input type="radio" value="0" class="st" name="status" >禁用
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-8">
                            <button class="btn btn-sm btn-white" onclick="addRole()"><i class="fa fa-save"></i> 保存</button>
                            <button class="btn btn-sm btn-white" ><i class="fa fa-undo"></i> 重置</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-7">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>角色列表 <small>点击修改信息将显示在左边表单</small></h5>
                </div>
                <div class="ibox-content">
                    <div class="hr-line-dashed2"></div>
                    <div class="row">
                        <div class="table-responsive">
                            <c:if test="${not empty pageInfo}">
                            <table class="table table-striped list-table">
                                <thead>
                                <tr>
                                    <th>选择</th>
                                    <th>角色名称</th>
                                    <th>角色描述：</th>
                                    <th>是否启用</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${requestScope.pageInfo.list}" var="role">
                                        <tr>
                                            <td><input id="ck" name="ck" value="${role.roleid}" class="ck" type="checkbox" ></td>
                                            <td>${role.rolename}</td>
                                            <td>${role.roledis}</td>
                                            <td>
                                                <c:if test="${role.status==1}">
                                                    是
                                                </c:if>
                                                <c:if test="${role.status==0}">
                                                    否
                                                </c:if>
                                            </td>
                                            <td>
                                                <a href="update-role.jsp?roleid=${role.roleid}"><i class="glyphicon glyphicon-edit  text-navy"></i></a>
                                                <a href="javascript:deleteNode(${role.roleid})" class="btndel"><i class="glyphicon glyphicon-remove text-navy"></i></a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            </c:if>
                        </div>
                        <div class="row">
                            <div class="col-sm-5">
                                <button class="btn btn-sm btn-primary" type="button" onclick="checkAll()"><i class="fa fa-check-square-o"></i> 全选</button>
                                <button class="btn btn-sm btn-primary" type="button" onclick="uncheckAll()"><i class="fa fa-square-o"></i> 反选</button>
                                <button class="btn btn-sm btn-primary" type="button" onclick="batchDelete()"><i class="fa fa-times-circle-o"></i> 删除</button>
                            </div>
                            <div class="col-sm-7 text-right">
                                <div class="btn-group">

                                    <span>共有${pageInfo.pages}页,当前是第${pageInfo.pageNum}页</span>
                                    <c:if test="${pageInfo.pageNum!=1}">  <%--或者${!pageInfo.isFirstPage}--%>
                                        <a href='${pageContext.request.contextPath}/showAllRole?pageNum=1'>首页</a>
                                        <a href='${pageContext.request.contextPath}/showAllRole?pageNum=${pageInfo.prePage}'>上一页</a>
                                    </c:if>
                                    <c:if test="${pageInfo.pageNum!=pageInfo.pages}"> <%--或者${!pageInfo.isLastPage}--%>
                                        <a href='${pageContext.request.contextPath}/showAllRole?pageNum=${pageInfo.nextPage}'>下一页</a>
                                        <a href='${pageContext.request.contextPath}/showAllRole?pageNum=${pageInfo.pages}'>尾页</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>

</div>
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/select/bootstrap-select.min.js"></script>
<script src="js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="js/plugins/ztree/jquery.ztree.core.min.js"></script>
<script src="js/plugins/ztree/jquery.ztree.exedit.js"></script>
<script src="js/plugins/ztree/jquery.ztree.excheck.js"></script>
<script>
    $(function() {
        var setting = {
            check: {
                enable: true
            },
            async: {
                enable: true,
                url: 'showTree',
                autoParam: ["id", "name"]
            },
        };
        $.fn.zTree.init($("#treeDemo"),setting);
    });

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
                url:'deleteRoleByPk?ids='+ids,
                dataType:'json',
                success:function(rs){
                    // 以下是成功的提示框，请在ajax回调函数中执行
                    if(rs.flag){
                        swal(rs.msg,"您已经永久删除了这条信息","success");
                        window.location.href="${pageContext.request.contextPath}/showAllRole";
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

    //添加角色
    function  addRole(){
        //提交表单数据
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        var nodes = treeObj.getCheckedNodes(true);
        if(nodes.length==0){
            alert("创建角色必须指定资源");
            return false;
        }else{
            var  idarr = new Array();
            for(var i=0;i<nodes.length;i++){
                idarr[i]=nodes[i].id;
            }
            var rolename = $("#rolename").val();
            var roledis = $("#roledis").val();
            var status = $("input[name='status']:checked").val();
            alert(status);
            var url="${pageContext.request.contextPath}/addRole?ids="+idarr+"&rolename="+rolename+"&roledis="+roledis+"&status="+status;
            window.location.href=url;
        };
    };

    function deleteNode(id){
        swal({
            title : "您确定要删除该资源信息么？",
            text : "删除后数据无法恢复！",
            type : "warning",
            showCancelButton : true,
            confirmButtonColor : "#DD6B55",
            confirmButtonText : "删除",
            closeOnConfirm : false
        }, function() {
            $.ajax({
                type:'GET',
                url:'deleteRoleByPk',
                data:{"ids":id},
                dataType:'json',
                success:function(rs){
                    // 以下是成功的提示框，请在ajax回调函数中执行
                    if(rs.flag){
                        swal(rs.msg,"您已经永久删除了这条信息","success");
                        window.location.href="${pageContext.request.contextPath}/showAllRole";
                    }else{
                        alert(rs.msg);
                    }
                }
            });
        });
    };
</script>

</body>


</html>
    

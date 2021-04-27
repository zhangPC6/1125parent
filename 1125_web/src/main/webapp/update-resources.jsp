<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <link href="${pageContext.request.contextPath}/css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/animate.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/plugins/select/bootstrap-select.min.css"
          rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/plugins/zTreeStyle/zTreeStyle.css"/>

</head>

<body class="gray-bg">
<div class="wrapper2 wrapper-content2 animated fadeInRight">
    <div class="row">

        <div class="col-sm">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>资源添加</h5>
                </div>
                <div class="ibox-content">
                    <form class="form-horizontal" action="updateSources" method="post">
                        <input type="hidden" id="uid" name="id">
                        <div class="form-group">
                            <label class="col-sm-4 control-label">菜单资源名称：</label>

                            <div class="col-sm-3">
                                <input type="text" id="uname" name="name" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">父菜单：</label>

                            <div class="col-sm-3">
                                <select name="level" id="parents" class="form-control">
                                    <%--<option>Mustard</option>
                                    <option>Ketchup</option>
                                    <option>Relish</option>--%>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">菜单资源路径：</label>

                            <div class="col-sm-3">
                                <input type="text" id="uurl" name="url" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">备注：</label>
                            <div class="col-sm-3">
                                <textarea class="form-control" id="uremark" name="remark"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-4">
                                <button class="btn btn-sm btn-white" type="submit">
                                    <i class="fa fa-save"></i> 保存
                                </button>
                                <button class="btn btn-sm btn-white" type="reset">
                                    <i class="fa fa-undo"></i> 重置
                                </button>
                            </div>
                        </div>
                    </form>
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
<script type="application/javascript">
    $(function () {
        $.ajax({
            type:"GET",
            url:"getOneSourceById",
            data:{"id":${param.id}},
            dataType:"json",
            success:function (rs) {
                $("#uid").val(rs.id);
                $("#uname").val(rs.name);
                $("#uurl").val(rs.url);
                $("#uremark").val(rs.remark);
                $.ajax({
                    type:'GET',
                    url:'getSecondLevel',
                    dataType:'json',
                    success:function(nrs){
                        $(nrs).each(function(index,item){
                            var opt="";
                            if(rs.pid===item.id){
                                opt="<option value='"+item.id+"' selected='true'>"+item.name+"</option>";
                            }else{
                                opt="<option value="+item.id+">"+item.name+"</option>";
                            }
                            $("#parents").append(opt);
                        });
                    }
                });
            }
        })
    })
</script>

</body>


</html>

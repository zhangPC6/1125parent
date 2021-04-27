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
    <link href="${pageContext.request.contextPath}/css/plugins/select/bootstrap-select.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/plugins/zTreeStyle/zTreeStyle.css"/>

</head>

<body class="gray-bg">
<div class="wrapper2 wrapper-content2 animated fadeInRight">
    <div class="row">
        <div class="col-sm-6">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>资源管理</h5>
                </div>
                <div class="ibox-content">
                    <div class="zTreeDemoBackground left" style="font-size: 16px">
                        <ul id="treeDemo" class="ztree"></ul>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-sm-6">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>资源添加</h5>
                </div>
                <div class="ibox-content">
                    <form class="form-horizontal" action="updateSources" method="post">
                        <input type="hidden" id="uid" name="id">
                        <div class="form-group">
                            <label class="col-sm-4 control-label">菜单资源名称：</label>

                            <div class="col-sm-7">
                                <input type="text" id="uname" name="name" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">父菜单：</label>

                            <div class="col-sm-7">
                                <select name='pid' id="parents" class="form-control">
                                    <%--<option>Mustard</option>
                                    <option>Ketchup</option>
                                    <option>Relish</option>--%>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">菜单资源路径：</label>

                            <div class="col-sm-7">
                                <input type="text" id="uurl" name="url" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-4 control-label">备注：</label>
                            <div class="col-sm-7">
                                <textarea id="uremark" name="remark" class="form-control"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-8">
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

<SCRIPT type="text/javascript">
    var setting = {
        async: {
            enable: true,
            url: 'showTree',
            autoParam: ["id", "name"]
        },
        view : {
            addHoverDom : function(treeId, treeNode) {
                var aObj = $("#" + treeNode.tId + "_a");
                if (treeNode.editNameFlag
                    || $("#btnGroup" + treeNode.tId).length > 0)
                    return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if (treeNode.level == 1) {
                    if (treeNode.children.length == 0) {
                        s += '<span class="button remove" onclick="deleteNode('
                            + treeNode.id + ')"></span>';
                    }
                } else if (treeNode.level == 2) {
                    s += '<span class="button edit" onclick="editNode('
                        + treeNode.id + ')" ></span>';
                    s += '<span class="button remove" onclick="deleteNode('
                        + treeNode.id + ')" ></span>';
                }
                s += '</span>';
                aObj.append(s);
            },
            removeHoverDom : function(treeId, treeNode) {
                $("#btnGroup" + treeNode.tId).remove();
            }
        }

    };

    //编辑
    function editNode(id) {
        window.location.href="update-resources.jsp?id="+id;
    }


    //删除
    function deleteNode(id) {
        swal({
            title : "您确定要删除该资源信息么？",
            text : "删除后数据无法恢复！",
            type : "warning",
            showCancelButton : true,
            confirmButtonColor : "#DD6B55",
            confirmButtonText : "删除",
            closeOnConfirm : false
        }, function() {
            //此函数是点击删除执行的函数
            //这里写ajax代码
            $.ajax({
                type:'GET',
                url:'deleteSourcesById',
                data:{"id":id},
                dataType:'json',
                success:function(rs){
                    // 以下是成功的提示框，请在ajax回调函数中执行
                    if(rs.flag){
                        swal(rs.msg,"您已经永久删除了这条信息","success");
                        //通过ul标签的id获取我们的树对象
                        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                        //从新向后台发送请求获取树的最新的信息
                        treeObj.reAsyncChildNodes(null, "refresh");
                    }else{
                        alert(rs.msg);
                    }
                }
            });
        });
    }

    $(function() {
        $.fn.zTree.init($("#treeDemo"),setting);
        $.ajax({
            type:'GET',
            url:'getSecondLevel',
            dataType:'json',
            success:function(rs){
                console.info(rs);
                $(rs).each(function(index,item){
                    var opt="<option value="+item.id+">"+item.name+"</option>";
                    $("#parents").append(opt);
                });
            }
        });
    });
</SCRIPT>
</body>


</html>

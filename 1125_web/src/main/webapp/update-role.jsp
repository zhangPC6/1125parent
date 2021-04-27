<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>办公系统 - 基础表格</title>
    <meta name="keywords" content="办公系统">
    <meta name="description" content="办公系统">

    <link rel="shortcut icon" href="favicon.ico">
    <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="css/plugins/select/bootstrap-select.min.css" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link rel="stylesheet" href="css/plugins/zTreeStyle/zTreeStyle.css" />
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">

    <div class="row">
        <div >
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>编辑角色</h5>
                </div>
                <div class="ibox-content">

                    <div class="form-group">
                        <input type="hidden" name="roleid" id="rid">
                        <label class="col-sm-3 control-label">角色名称：</label>

                        <div class="col-sm-8">
                            <input type="text" id="rname" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色描述：</label>

                        <div class="col-sm-8">
                            <input type="text" id="rdis" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">角色权限：</label>

                        <div class="col-sm-8">
                            <ul id="treeDemo" class="ztree"></ul>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">是否启用：</label>
                        <div class="col-sm-8">
                            <input type="radio" value="1" class="st1" name="status">启用
                            <input type="radio" value="0" class="st2" name="status">禁用
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-8">
                            <button class="btn btn-sm btn-white" onclick="addRole()"><i class="fa fa-save"></i> 更新</button>
                            <button class="btn btn-sm btn-white" type="submit"><i class="fa fa-undo"></i> 重置</button>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/sweetalert/sweetalert.min.js"></script>
<script src="js/plugins/select/bootstrap-select.min.js"></script>
<script src="js/plugins/layer/laydate/laydate.js"></script>
<script src="js/plugins/ztree/jquery.ztree.core.min.js"></script>
<script src="js/plugins/ztree/jquery.ztree.exedit.js"></script>
<script src="js/plugins/ztree/jquery.ztree.excheck.js"></script>

<!-- 修复日期控件长度-->
<link href="css/customer.css" rel="stylesheet">
<script type="application/javascript">
    $(function() {
        $.ajax({
            type:'GET',
            url:'getOneRoleByPk',
            data:{"roleid":${param.roleid}},
            dataType:'json',
            success:function(rs){
                //角色的基本数据
                var role = rs.role;
                $("#rid").val(role.roleid);
                $("#rname").val(role.rolename);
                $("#rdis").val(role.roledis);
                if(role.status==1){
                    $(".st1").prop("checked",true);
                }else{
                    $(".st2").prop("checked",true);
                }
                //角色对应的权限数据
                var roleSources = rs.sourceList;
                var setting = {
                    check: {
                        enable: true
                    },
                    async: {
                        enable: true,
                        url: 'showTree',
                        autoParam: ["id", "name"]
                    },
                    callback: {
                        onAsyncSuccess: function (event, treeId, treeNode, msg) {
                            //提前勾选树中的结点
                            //获取我们的树对象
                            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
                            //勾选树上的某个结点
                            $(roleSources).each(function(index,item){
                                //利用了我们的资源的树的特点 完成我们的树的勾选操作
                                var nodes = treeObj.getNodesByParam("id",item.id,null);
                                treeObj.checkNode(nodes[0],true,true);
                            });
                        }
                    }
                };
                //显式我们的树结构
                $.fn.zTree.init($("#treeDemo"),setting);
            }
        });
    });


    function  addRole(){
        //提交表单数据
        var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
        //获取所有的勾选结点数组
        var nodes = treeObj.getCheckedNodes(true);
        if(nodes.length==0){
            alert("更新角色必须指定资源");
            return false;
        }else{
            var  idarr = new Array();
            for(var i=0;i<nodes.length;i++){
                idarr[i]=nodes[i].id;
            }
            var roleid = $("#rid").val();
            var rolename = $("#rname").val();
            var roledis = $("#rdis").val();
            //获取选中的哪个radio标签的数据
            //var state1=$('input:radio:checked').val();
            var status =$('input:radio:checked').val();
            var url="${pageContext.request.contextPath}/addRole?ids="+idarr+"&rolename="+rolename+"&roledis="+roledis+"&status="+status+"&roleid="+roleid;
            window.location.href=url;
        }
    }
</script>

</body>


</html>
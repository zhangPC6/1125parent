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
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="css/plugins/select/bootstrap-select.min.css" rel="stylesheet">
    <link href="layui/css/layui.css" rel="stylesheet">

</head>

<body class="gray-bg">
<div class="wrapper2 wrapper-content2 animated fadeInRight">
    <div class="row">
        <div class="col-sm-5">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>添加部门</h5>
                </div>
                <div class="ibox-content">
                    <form action="addOneDept" method="post" class="form-horizontal">
                        <div hidden="hidden" class="form-group">
                            <label  class="col-sm-3 control-label">部门编号：</label>

                            <div class="col-sm-8">
                                <input type="hidden" id="deptno" name="deptno"  class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">部门名称：</label>

                            <div class="col-sm-8">
                                <input type="text" id="dname" name="dname" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-3 control-label">区域：</label>

                            <div class="col-sm-8">
                                <input type="text" id="local" name="local" class="form-control">
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-3 col-sm-8">
                                <button class="btn btn-sm btn-white" type="submit"><i class="fa fa-save"></i> 保存</button>
                                <button class="btn btn-sm btn-white" type="reset"><i class="fa fa-undo"></i> 重置</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <div class="col-sm-7">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>部门列表 <small>点击修改信息将显示在左边表单</small></h5>
                </div>
                <div class="ibox-content">
                    <table id="demo" lay-filter="test"></table>
                </div>
            </div>
        </div>

    </div>
</div>
<script src="js/jquery.min.js?v=2.1.4"></script>
<script src="js/bootstrap.min.js?v=3.3.6"></script>
<script src="js/plugins/select/bootstrap-select.min.js"></script>
<script src="js/plugins/sweetalert/sweetalert.min.js"></script>
<script type="application/javascript" src="layui/layui.js"></script>
<script type="application/javascript">
    layui.use('table', function(){
        var table = layui.table;
        //第一个实例
        table.render({
            elem: '#demo'
            ,url: 'showDept' //数据接口
            ,limit:2
            ,page: true //开启分页
            ,limits:[2,4,6,8]
            ,cols: [[ //表头
                {field: 'deptno', title: '部门编号', sort: true, fixed: 'left'}
                ,{field: 'dname', title: '部门名称'}
                ,{field: 'local', title: '部门位置', sort: true}
            ]]
        });

    });
</script>
</body>


</html>
    

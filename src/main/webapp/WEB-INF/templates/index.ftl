<#assign ctx=request.contextPath />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>首页</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css"/>

    <link href="${ctx}/static/css/main.css" rel="stylesheet">

    <script src="${ctx}/static/js/jquery.js"></script>

    <script src="${ctx}/static/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript" language="javascript" src="${ctx}/static/js/dataTables.bootstrap.js"></script>

    <script src="${ctx}/static/js/bootstrap.min.js"></script>

    <script src="${ctx}/static/js/bootstrap-datetimepicker.min.js"></script>

    <script src="${ctx}/static/js/handlebars-v3.0.1.js"></script>
</head>
<body>

<!--<div class="container">

</div>-->
<ol class="breadcrumb">
    <li><button class="btn btn-table" data-toggle="modal" data-target="#myModal">查询</button></li>
    <li><button class="btn btn-table" data-toggle="modal" data-target="#myModal">新增</button></li>
    <li><button id="delete">删除</button></li>
</ol>
<div class="container">
    <table id="user" class="display" cellspacing="0" width="100%">
        <thead>
        <tr>
            <th>编码</th>
            <th>姓名</th>
            <th>状态</th>
            <th>创建时间</th>
            <th>最后登录</th>
            <th>账号类型</th>
        </tr>
        </thead>
        <tbody></tbody>
        <!-- tbody是必须的 -->
    </table>
</div>
<!-- Button trigger modal -->


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">新增</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <input type="text" class="form-control" id="number" placeholder="编码">
                </div>
                <div class="form-group">
                    <input type="text" class="form-control" id="userName" placeholder="姓名">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="initData">添加模拟数据</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="save">保存</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(document).ready(function() {

        $("#user").dataTable({
            "bProcessing": false,                   // 是否显示取数据时的那个等待提示
            "bServerSide": true,                    //这个用来指明是通过服务端来取数据
            "sAjaxSource": "${ctx}/user/list",      //这个是请求的地址
            "columns": [
                {"data": "number"},
                {"data":"userName"},
                {"data":"state"},
                {"data":"createTime"},
                {"data":"lastLogin"},
                {"data":"type"}
            ],
            "fnServerData": retrieveData            // 获取数据的处理函数
        });
    });

    // 3个参数的名字可以随便命名,但必须是3个参数,少一个都不行
    function retrieveData( sSource,aoData, fnCallback) {
        $.ajax({
            url : sSource,                              //这个就是请求地址对应sAjaxSource
            data : {"aoData":JSON.stringify(aoData)},   //这个是把datatable的一些基本数据传给后台,比如起始位置,每页显示的行数 ,分页,排序,查询等的值
            type : 'post',
            dataType : 'json',
            async : false,
            success : function(result) {
                fnCallback(result);                     //把返回的数据传给这个方法就可以了,datatable会自动绑定数据的
            },
            error : function(msg) {
            }
        });
    }

    $(document).ready(function() {
        var table = $('#user').DataTable();
        var id;
        $('#user tbody').on( 'click', 'tr', function () {
            if ( $(this).hasClass('selected') ) {
                $(this).removeClass('selected');
                id=null;
            }
            else {
                table.$('tr.selected').removeClass('selected');
                $(this).addClass('selected');
                //alert($(this));
                id=$(this).find("td:first").text();
            }
        } );

        $('#delete').click( function () {
            $.ajax({
                url : "${ctx}/user/delete",
                data : {"id":id},
                type : 'post',
                dataType : 'json',
                async : false,
                success : function(result) {
                    if (result.success){
                        alert("删除成功");
                        window.location.reload();
                    }
                },
                error : function(msg) {
                }
            });
        } );
    } );
</script>
</body>
</html>

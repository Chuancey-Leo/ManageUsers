<#assign ctx=request.contextPath />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
        "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>首页</title>
    <link href="http://netdna.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="http://cdn.datatables.net/1.10.13/css/jquery.dataTables.min.css"/>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/css/daterangepicker.css">
    <link href="${ctx}/static/css/main.css" rel="stylesheet">

    <script src="${ctx}/static/js/jquery.js"></script>

    <script src="${ctx}/static/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript" language="javascript" src="${ctx}/static/js/dataTables.bootstrap.js"></script>

    <script src="${ctx}/static/js/bootstrap.min.js"></script>

    <script src="${ctx}/static/js/bootstrap-datetimepicker.min.js"></script>

    <script src="${ctx}/static/js/handlebars-v3.0.1.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/moment.min.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/daterangepicker.js"></script>
</head>
<body>

<!--<div class="container">

</div>-->
<ol class="breadcrumb">
    <li><button class="btn btn-table" onclick="location='${ctx}/user/add'">添加</button></li>
    <li><button class="btn btn-table" id="delete">删除</button></li>
    <li><button class="btn btn-table" id="update">修改</button></li>
</ol>
<div class="container">
    <form action="${ctx}/user/search" method="post">
        <input type="text" id="number" name="number" class="form-control" placeholder="number">
        <input type="text" id="userName" name="number" class="form-control" placeholder="userName">
        <input type="radio" name="state" value="1">封存</input>
        <input type="radio" name="state" value="2">解封</input>

        <input type="text" name="start" id="start" class="form-control">
        <input type="text" name="last" id="last" class="form-control">
        <select id="typeName" name="typeName" type="text" class="form-control select2" placeholder="吸烟...">
            <option>管理员</option>
            <option>超级管理员</option>
            <option>普通用户</option>
        </select><br><br>
        <button type="submit" class="btn btn-table" id="search">搜索</button>
    </form>
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
<script type="text/javascript">

    $(document).ready(function() {


        $('#start').daterangepicker({
            "singleDatePicker": true,
            "timePicker": true,
            "timePicker24Hour": true,
            "timePickerSeconds": true,
            "locale": {
                "direction": "ltr",
                "format": "YYYY-MM-DD HH:MM:SS",
                "separator": " - ",
                "applyLabel": "Apply",
                "cancelLabel": "Cancel",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "daysOfWeek": [
                    "Su",
                    "Mo",
                    "Tu",
                    "We",
                    "Th",
                    "Fr",
                    "Sa"
                ],
                "monthNames": [
                    "January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December"
                ],
                "firstDay": 1
            },
            "startDate": "02/07/2017",
            "endDate": "02/13/2017"
        }, function(start, end, label) {
            console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
        });

        $('#last').daterangepicker({
            "singleDatePicker": true,
            "timePicker": true,
            "timePicker24Hour": true,
            "timePickerSeconds": true,
            "locale": {
                "direction": "ltr",
                "format": "YYYY-MM-DD HH:MM:SS",
                "separator": " - ",
                "applyLabel": "Apply",
                "cancelLabel": "Cancel",
                "fromLabel": "From",
                "toLabel": "To",
                "customRangeLabel": "Custom",
                "daysOfWeek": [
                    "Su",
                    "Mo",
                    "Tu",
                    "We",
                    "Th",
                    "Fr",
                    "Sa"
                ],
                "monthNames": [
                    "January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December"
                ],
                "firstDay": 1
            },
            "startDate": "02/07/2017",
            "endDate": "02/13/2017"
        }, function(start, end, label) {
            console.log("New date range selected: ' + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD') + ' (predefined range: ' + label + ')");
        });

        $("#user").dataTable({
            "aaData": data,
            "aoColumns": [
                { data: 'number'},//这里还可以用mDataProp
                { data: 'userName'},
                { data: 'state'},
                { data: 'createTime'},
                { data: 'lastLogin'},
                { data: 'typeName'}
            ]
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

        $('#add').click(function(){
            $.ajax({
                url : "${ctx}/user/add",
                type : 'post',
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
        });

        $('#update').click( function () {
            if (id==null){
                alert("请选中额！");
            }else {
                window.location.href="${ctx}/user/update/"+id;
            }
        } );

        $('#search').click( function () {
            var state=$("input[name='state']:checked").val();
            var type = $("#typeName").val();
            var number=$('#number').val();
            var userName=$('#userName').val();
            var start = $("#start").val();
            var last = $("#last").val();
            alert(type);
            $.ajax({
                url : "${ctx}/user/addData",
                data : {"id":number,"type":type,"state":state,"userName":userName,
                    "start":start,
                    "last":last},
                type : 'post',
                dataType : 'json',
                async : false,
                success : function(result) {
                    if (result.success){
                        alert("添加成功");
                        //window.location.reload();
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

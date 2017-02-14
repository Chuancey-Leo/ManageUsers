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
    <script src="${ctx}/static/js/jquery.js"></script>

    <script src="${ctx}/static/js/jquery.dataTables.min.js"></script>

    <script type="text/javascript" language="javascript" src="${ctx}/static/js/dataTables.bootstrap.js"></script>

    <script src="${ctx}/static/js/bootstrap.min.js"></script>

    <script src="${ctx}/static/js/bootstrap-datetimepicker.min.js"></script>

    <script src="${ctx}/static/js/handlebars-v3.0.1.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/moment.min.js"></script>

    <script type="text/javascript" src="${ctx}/static/js/daterangepicker.js"></script>
</head>
<body style="margin: 60px 0">

<div class="container">

    <h1 style="margin: 0 0 20px 0"><a href="${ctx}/user/index">回到主页</a></h1>

    <div class="well configurator">
            <div class="row">

                <div class="col-md-4">

                    <div class="form-group">
                        <label for="parentEl">编码</label>
                        <input type="text" class="form-control" id="number" value="${user.number}">
                    </div>

                    <div class="form-group">
                        <label for="parentEl">姓名</label>
                        <input type="text" class="form-control" id="userName" placeholder="body" value="${user.userName}">
                    </div>
                    <div class="form-group">
                        <input type="radio" name="state" value="1">封存</input>
                        <input type="radio" name="state" value="2">解封</input>
                    </div>

                    <div class="form-group">
                        <select id="typeName" name="typeName" type="text" class="form-control select2" placeholder="吸烟...">
                            <option>管理员</option>
                            <option>超级管理员</option>
                            <option>普通用户</option>
                        </select>
                    </div>

                    <div class="form-group">
                            <h4>Your Date Range Picker</h4>
                            <input type="text" id="start" class="form-control" value="${user.createTime?string("yyyy-MM-dd HH:mm:ss")}">
                    </div>
                    <div class="form-group">
                        <h4>Your Date Range Picker</h4>
                        <input type="text" id="last" class="form-control" value="${user.lastLogin   ?string("yyyy-MM-dd HH:mm:ss")}">
                    </div>

                </div>

            </div>
            <button id="updateData">更新</button>
    </div>


</div>

<style type="text/css">
    .demo { position: relative; }
    .demo i {
        position: absolute; bottom: 10px; right: 24px; top: auto; cursor: pointer;
    }
</style>

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

        $('#updateData').click( function () {
            var state=$("input[name='state']:checked").val();
            var type = $("#typeName").val();
            var number=$('#number').val();
            var userName=$('#userName').val();
            var start = $("#start").val();
            var last = $("#last").val();
            if (state==null||state==''){
                alert("有条件未填写！");
                return false;
            }else if(type==null||type==''){
                alert("有条件未填写！");
                return false;
            }else if (number==null||number==''){
                alert("有条件未填写！");
                return false;
            }else if (userName==null||userName==''){
                alert("有条件未填写！");
                return false;
            }else if (start==null||start==''){
                alert("有条件未填写！");
                return false;
            }else if (last==null||last==''){
                alert("有条件未填写！");
                return false;
            }
            $.ajax({
                url : "${ctx}/user/updateData",
                data : {"id":number,"type":type,"state":state,"userName":userName,
                "start":start,
                "last":last},
                type : 'post',
                dataType : 'json',
                async : false,
                success : function(result) {
                    if (result.success){
                        alert("修改成功");
                        //window.location.reload();
                    }
                },
                error : function(msg) {
                }
            });
        } );
    });



</script>

</body>
</html>

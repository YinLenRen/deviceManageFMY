<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>设备分类列表</title>
        <%pageContext.setAttribute("APP_PATH", request.getContextPath());%>
    <script src="${APP_PATH}/jslib/js/jquery-1.12.4.min.js"></script>
  <!--  <script src="./jslib/js/mui.min.js"></script>
    <link href="./jslib/css/mui.min.css" rel="stylesheet"/>
    <link rel="stylesheet" type="text/css" href="./jslib/css/app.css"/>   script不可用<script   /> -->
    <script src="jslib/bootstrap-4.6.0-dist/js/bootstrap.js"></script>
    <link href="jslib/bootstrap-4.6.0-dist/css/bootstrap.css" rel="stylesheet">

    <style type="text/css">
        .table {
            text-align: center;
        }
        .badge{
            font-size: 20px;
            margin-top: 5px;
            margin-bottom: 10px;
            float: right;
        }
        .badge-light{
            margin-right: 5px;
        }
        .badge-danger{
            margin-right: 5px;
        }
    </style>

</head>

<body>

<div class="modal fade" id="listOfEdit" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="exampleModalLabel">修改|</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="modalOfEditList">
                <form>
                    <div class="form-group">
                        <label class="col-form-label">设备分类编号</label>
                        <input type="text" class="form-control" id="editDeviceClassId" readonly>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">设备分类名称</label>
                        <input type="text" class="form-control" id="editDeviceClassName"></input>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="cannelBtn">重置</button>
                <button type="button" class="btn btn-primary" id="deviceClassBtnOfEdit" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>
<!--删除-->
<div class="modal" tabindex="-1" id="delList">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"></h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <h5>确定要删除吗?</h5>
                <!--隐藏输出框 仅用于传递ID-->
                <input type="hidden" id="delID">
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal" id="deviceClassBtnOfDel">确定</button>
            </div>
        </div>
    </div>
</div>
<!--新增-->
<div class="modal fade" id="addList" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">新增|</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body" id="addListModal">
                <form>
                    <div class="form-group">
                        <label class="col-form-label">设备分类编号</label>
                        <input type="text" class="form-control" id="addDeviceClassId" readonly>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">设备分类名称</label>
                        <input type="text" class="form-control" id="addDeviceClassName"></input>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="addCannelBtn">重置</button>
                <button type="button" class="btn btn-primary" id="saveDeviceClassBtn" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

    <div>
        <button type="button" id="deviceClassBtnOfAllDelete" class="badge badge-pill badge-danger">删除</button>
        <button type="button" id="deviceClassBtnOfAdd" class="badge badge-pill badge-light" >新增</button>
    </div>

    <div>
        <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="deviceclass_table">
            <thead>
            <tr>
                <th scope="col"><input type="checkbox" id="check_all"/></th>
                <th scope="col">设备分类编号</th>
                <th scope="col">设备分类名称</th>
                <th scope="col">操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</body>

<script>
    var aa = /^[0-9]*[1-9][0-9]*$/;
    $(function () {
        findAllDeviceClass();
    });

    function findAllDeviceClass() {
        $.ajax({
            url:"${APP_PATH}/findAllDeviceClass",
            type:"GET",
            success:function (result) {
                //  console.log(result);
                var jsjson = eval("("+result+")");
                console.log(jsjson);
                build_deviceclass_table(jsjson);
            }
        });
    }
    function build_deviceclass_table(jsjson) {
        $("#deviceclass_table tbody").empty();
        var deviceclass = jsjson.result;
        console.log(deviceclass);
        $.each(deviceclass, function (index, item) {
            var checkBox = $("<td><input type='checkbox'/></td>");
            checkBox.attr("id", "checkBox" + item.DeviceClassId);
            //var checkBox = $("<td></td>").append(checkBox1);
            var deviceClassID = $("<td></td>").append(item.DeviceClassId);
            deviceClassID.attr("id", "deviceClassId" + item.DeviceClassId);
            var deviceClassName = $("<td></td>").append(item.DeviceClassName);
            var edit = $("<button></button>").addClass("btn btn-secondary").append("编辑");
            deviceClassName.attr("id", "deviceClassName" + item.DeviceClassId);
            //动态生成id
            edit.attr("id", "edit" + item.DeviceClassId);
            var del = $("<button></button>").addClass("btn btn-secondary").append("删除");
            del.attr("id", "del" + item.DeviceClassId);
            var btnGroup = $("<td></td>").addClass("btn-group").append(edit).append(" ").append(del);
            $("<tr></tr>").append(checkBox).append(deviceClassID).append(deviceClassName).append(btnGroup).appendTo("#deviceclass_table tbody");
        });
    }
        //正则匹配button的id以edit开头的
    $(document).on('click', 'button[id^=edit]', function () {
        var a = $(this).attr("id").substring(4);
        console.log(a);
        $("#listOfEdit").modal();
        $.ajax({
            url:"${APP_PATH}/findDeviceClass?deviceClassId=" + a,
            method:"GET",
            success:function (result) {
                var json = eval("("+result+")").result;
                var inp = $("#modalOfEditList").find('input');
                $(inp[0]).val(json[0].DeviceClassId);
                $(inp[1]).val(json[0].DeviceClassName);
                console.log(json[0].DeviceClassId);

            }
        });

    })
    $(document).on('click', 'button[id^=del]', function () {
        var a = $(this).attr("id").substring(3);
        $("#delList").modal();
        var inp = $("#delList").find('input');
        //输入框传值
        $(inp[0]).val(a);
    });
    $("#deviceClassBtnOfAdd").click( function () {
        $("#addList").modal();
        $.ajax({
            url:"${APP_PATH}/findAllDeviceClass",
            method:"GET",
            success:function (result) {
                var deviceclass = eval("(" + result + ")").result;
                $.each(deviceclass, function (index, item) {
                    if(index == deviceclass.length - 1){
                        $("#addDeviceClassId").val(item.DeviceClassId + 1);
                    }
                })
            }
        });
    });
    $("button[id=deviceClassBtnOfEdit]").click( function (){
        var editDeviceClassId = $("#editDeviceClassId").val();
        console.log(editDeviceClassId);
        var editDeviceClassName = $("#editDeviceClassName").val();
        var nowData = [].concat(editDeviceClassName, editDeviceClassId);
        $.ajax({
            url:"${APP_PATH}/editDeviceClass?deviceClassId=" + editDeviceClassId + "&deviceClassName=" + editDeviceClassName,
            methods:"GET",
            success:function () {
                //查找id为"#edit" + editDeviceClassId所在td的所有td
                var newData = Array.prototype.slice.call($("#edit" + editDeviceClassId).parent().prevAll());
                //console.log(newData);
                for(var i = 0; i < nowData.length; ++i){
                    newData[i].innerHTML = nowData[i];
                }
            }
        });
    });

    $("#deviceClassBtnOfDel").click(function () {
        var id = $("#delID").val();
        console.log(id);
        $.ajax({
            url:"${APP_PATH}/deleteDeviceClass?deviceClassId=" + id,
            method:"GET"
        });
        $("#del" + id).parent().parent().remove();  //移除该列<tr></tr>
    });

    $("#saveDeviceClassBtn").click(function () {
        var addDeviceClassId = $("#addDeviceClassId").val();
        var addDeviceClassName = $("#addDeviceClassName").val();
        $.ajax({
            url:"${APP_PATH}/addDeviceClass?deviceClassId=" + addDeviceClassId + "&deviceClassName=" + addDeviceClassName,
            method:"GET",
            success:function () {
                findAllDeviceClass();
            }
        });
    })
    $("#deviceClassBtnOfAllDelete").click(function () {
        var checkIDs = new Array();
        checkIDs = getAllCheckIDs();
        for(var i = 0; i < checkIDs.length; ++i){
            $.ajax({
                url:"${APP_PATH}/deleteDeviceClass?deviceClassId=" + checkIDs[i],
                method:"POST",
            });
            console.log("#del" + checkIDs[i]);
            $("#del" + checkIDs[i]).parent().parent().remove();  //移除该列<tr></tr>
        }

    })
    function getAllCheckIDs(){
        var  checkBoxId = new Array();
        var trNum = ($("#deviceclass_table tbody").children("tr"));
        for(var i = 0; i < trNum.length; i++){
            var tdArr = trNum.eq(i).find("td").eq(0);
            if(tdArr.find("input").is(":checked")){
                checkBoxId.push(tdArr.attr("id").substring(8));
             //   console.log($("input[id^='checkBox']").attr("id"));
            }

        }
        console.log(checkBoxId);
        return checkBoxId;
    }
    /*全选、全不选
     *prop设置属性或值
     */
    $("#check_all").click(function () {
        $("input[type^='checkbox']").each(function () {
            if ($(this).prop("checked") == true) {
                $("input[type='checkbox']").prop('checked', true);
                return;
            } else {
                $("input[type='checkbox']").prop('checked', false);
                return;
            }
        })
    })

</script>
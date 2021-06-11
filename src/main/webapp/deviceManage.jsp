<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>设备列表</title>
    <%pageContext.setAttribute("APP_PATH", request.getContextPath());%>
    <script src="${APP_PATH}/jslib/js/jquery-1.12.4.min.js"></script>
    <script src="https://cdn.bootcss.com/popper.js/1.14.7/umd/popper.min.js"></script>
    <script src="jslib/bootstrap-4.6.0-dist/js/bootstrap.min.js"></script>
    <link href="jslib/bootstrap-4.6.0-dist/css/bootstrap.min.css" rel="stylesheet">
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
                    <label class="col-form-label">设备编号</label>
                    <input type="text" class="form-control" id="editDeviceId" readonly>
                </div>
                    <div class="form-group">
                        <label class="col-form-label">设备分类编号</label>
                        <input type="text" class="form-control" id="editDeviceClassId">
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">设备名称</label>
                        <input type="text" class="form-control" id="editDeviceName">
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">设备价格</label>
                        <input type="text" class="form-control" id="editDevicePrice">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="cannelBtn">重置</button>
                <button type="button" class="btn btn-primary" id="deviceBtnOfEdit" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

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
                <button type="button" class="btn btn-danger" data-dismiss="modal" id="deviceBtnOfDel">确定</button>
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
                        <label class="col-form-label">设备编号</label>
                        <input type="text" class="form-control" id="addDeviceId" readonly>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">设备分类</label>
                        <select class="form-control" id="deviceClassSelect" >
                            <option value="" ></option>
                        </select>
                    </div>
                    <!--<div class="dropdown">
                        <a class="btn btn-secondary dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-expanded="false">
                            设备分类名称
                        </a>
                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink" id="deviceClass_selected">
                            <a class="dropdown-item" id="">Action</a>
                            <a class="dropdown-item" href="#">Another action</a>
                            <a class="dropdown-item" href="#">Something else here</a>
                        </div>
                    </div>-->
                    <div class="form-group">
                        <label class="col-form-label">设备名称</label>
                        <input type="text" class="form-control" id="addDeviceName">
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">设备价格</label>
                        <input type="text" class="form-control" id="addDevicePrice">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="addCannelBtn">重置</button>
                <button type="button" class="btn btn-primary" id="saveDeviceBtn" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<div>
    <button type="button" id="deviceBtnOfAllDelete" class="badge badge-pill badge-danger">删除</button>
    <button type="button" id="deviceBtnOfAdd" class="badge badge-pill badge-light" >新增</button>
</div>

    <div>
        <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="device_table">
            <thead>
            <tr>
                <th scope="col"><input type="checkbox" id="check_all"></th>
                <th scope="col">设备编号</th>
                <th scope="col">设备分类编号</th>
                <th scope="col">设备名称</th>
                <th scope="col">设备价格</th>
                <th scope="col">操作</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>
</select>

</body>

<script>

    $(function () {
        findAllDevice();
    });
    function findAllDevice() {
        $.ajax({
            url:"${APP_PATH}/findAllDevice",
            method:"GET",
            success:function (result) {
                var jsjson = eval("("+result+")");
                console.log(jsjson);
                build_device_table(jsjson);
                bulid_deviceclass_selected(jsjson);
            }
        });
    }
    function findAllDeviceClass() {
        $.ajax({
            url:"${APP_PATH}/findAllDeviceClass",
            type:"GET",
            success:function (result) {
                //  console.log(result);
                var jsjson = eval("("+result+")");
                //console.log(jsjson);
                bulid_deviceclass_selected(jsjson);
            }
        });
    }
    function build_device_table(jsjson) {
        $("#device_table tbody").empty();
        var device = jsjson.result;
        $.each(device, function (index, item) {
            var checkBox = $("<td><input type='checkbox'></td>");
            checkBox.attr("id", "checkBox" + item.DeviceId);
            var deviceID = $("<td></td>").append(item.DeviceId);
            deviceID.attr("id", "deviceId" + item.DeviceId);
            var deviceclassID = $("<td></td>").append(item.DeviceClassId);
            deviceclassID.attr("id", "deviceClassId" + item.DeviceId);
            var deviceName = $("<td></td>").append(item.DeviceName);
            deviceName.attr("id", "deviceName" + item.DeviceId);
            var devicePrice = $("<td></td>").append(item.DevicePrice);
            devicePrice.attr("id", "devicePrice" + item.DeviceId);
            var editBtn = $("<button></button>").addClass("btn btn-secondary").append("编辑");
            editBtn.attr("id", "edit" + item.DeviceId);
            var delBtn = $("<button></button>").addClass("btn btn-secondary").append("删除");
            delBtn.attr("id", "del" + item.DeviceId);
            var btnGroup = $("<td></td>").addClass("btn-group").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(checkBox).append(deviceID).append(deviceclassID).append(deviceName).append(devicePrice).append(btnGroup).appendTo("#device_table tbody");

        });
    }

    $(document).on('click', 'button[id^=edit]', function () {
        var a = $(this).attr("id").substring(4);
        console.log(a);
        $("#listOfEdit").modal();
        $.ajax({
            url:"${APP_PATH}/findDeviceById?deviceId=" + a,
            method:"GET",
            success:function (result) {
                var json = eval("("+result+")").result;
                var inp = $("#modalOfEditList").find('input');
                console.log(inp);
                console.log(json);
                $(inp[0]).val(json[0].DeviceId);
                $(inp[1]).val(json[0].DeviceClassId);
                $(inp[2]).val(json[0].DeviceName);
                $(inp[3]).val(json[0].DevicePrice);
            }
        });
    })
    $(document).on('click', 'button[id^=del]', function () {
        var a = $(this).attr("id").substring(3);
        $("#delList").modal();
        $.ajax({
            url:"${APP_PATH}/findDeviceById?deviceId=" + a,
            method:"GET",
            success:function (result) {
                var json = eval("("+result+")").result;
                var inp = $("#delList").find('input');
                //输入框传值
                $(inp[0]).val(json[0].DeviceId);
                $(inp[1]).val(json[1].DeviceClassId);
            }
        });
    });
    $("#deviceBtnOfAdd").click( function () {
        $("#addList").modal();
        $.ajax({
            url:"${APP_PATH}/findAllDevice",
            method:"GET",
            success:function (result) {
                var len = eval("("+result+")").result;
                $("#addDeviceId").val(len.length + 1);
                findAllDeviceClass();
                $("#addDevicePrice").empty();
                $("#addDeviceName").empty();
            }
        });
    });
    $("button[id=deviceBtnOfEdit]").click( function (){
        var editDeviceId = $("#editDeviceId").val();
        var editDeviceClassId = $("#editDeviceClassId").val();
        var editDeviceName = $("#editDeviceName").val();
        var editDevicePrice = $("#editDevicePrice").val();
        var nowData = [].concat(editDevicePrice, editDeviceName, editDeviceClassId, editDeviceId);
        console.log(nowData);
        $.ajax({
            url:"${APP_PATH}/editDevice?deviceId=" + editDeviceId + "&deviceClassId="+ editDeviceClassId + "&deviceName=" + editDeviceName + "&devicePrice=" + editDevicePrice,
            methods:"GET",
            success:function () {
                //查找id为"#edit" + editDeviceClassId所在td的所有td
                var newData = Array.prototype.slice.call($("#edit" + editDeviceId).parent().prevAll());
                console.log(newData);
                for(var i = 0; i < nowData.length; ++i){
                    newData[i].innerHTML = nowData[i];
                }
            }
        });
    });

    $("#deviceBtnOfDel").click(function () {
        var id = $("#delID").val();
        $.ajax({
            url:"${APP_PATH}/deleteDevice?deviceId=" + id,
            method:"GET"
        });
        $("#del" + id).parent().parent().remove();  //移除该列<tr></tr>
    });

    $("#saveDeviceBtn").click(function () {
        var addDeviceId = $("#addDeviceId").val();
        var addDeviceClassId = $("#deviceClassSelect option:selected").val();
        var addDevicePrice = $("#addDevicePrice").val();
        var addDeviceName = $("#addDeviceName").val();
        $.ajax({
            url:"${APP_PATH}/addDevice?deviceId=" + addDeviceId + "&deviceClassId="+ addDeviceClassId + "&deviceName=" + addDeviceName + "&devicePrice=" + addDevicePrice,
            method:"GET",
            success:function () {
                findAllDevice();
            }
        });
    })
    $("#deviceBtnOfAllDelete").click(function () {
        var checkIDs = new Array();
        checkIDs = getAllCheckIDs();
        console.log(checkIDs);
        for(var i = 0; i < checkIDs.length; ++i){
            $.ajax({
                url:"${APP_PATH}/deleteDevice?deviceId=" + checkIDs[i],
                method:"POST",
            });
            console.log("#del" + checkIDs[i]);
            $("#del" + checkIDs[i]).parent().parent().remove();  //移除该列<tr></tr>
        }
    })
    function getAllCheckIDs(){
        var  checkBoxId = new Array();
        var trNum = ($("#device_table tbody").children("tr"));
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

    function bulid_deviceclass_selected(jsjson) {
        var deviceclass = jsjson.result;
        var content = '';
        $.each(deviceclass,function(index,item){
            content += "<option value='" + item.DeviceClassId + "'>"+ item.DeviceClassName +"</option>";
        });
            //选择列表，选中的值赋值;
        /*$("#deviceClassSelect").html(content).trigger("chosen:updated").change(function () {
            deviceClassSelect = $("#deviceClassSelect option:selected").val();
        });*/
    }

</script>
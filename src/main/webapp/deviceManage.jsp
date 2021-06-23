<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>设备列表</title>
    <%pageContext.setAttribute("APP_PATH", request.getContextPath());%>
    <script src="${APP_PATH}/jslib/js/jquery-1.12.4.min.js"></script>

    <link href="jslib/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src="jslib/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.25/datatables.min.css"/>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.25/datatables.min.js"></script>

    <style type="text/css">
        .table {
            text-align: center;
            padding: 0px;
        }
        .table th, .table td{
            vertical-align: middle;
            margin: 0 auto;
            text-align: center;
        }
        .btn-group {
            display: inline;
            vertical-align: middle;
            margin: 100px auto;
            padding: 0px;
        }
        .btn-group-vertical>.btn, .btn-group>.btn{
            margin: 8px;
            text-align: center;
            float: none;
            vertical-align: middle;
        }
        .btn{
            padding:5px;
            font-size: 10px;
            margin-bottom: 5px;
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
                        <label class="col-form-label">设备分类名称</label>
                        <select class="form-control" id="editDeviceClassSelect" >
                            <option value="" ></option>
                        </select>
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
                        <label class="col-form-label">设备分类名称</label>
                        <select class="form-control" id="addDeviceClassSelect" >
                            <option value=""></option>
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
    <button id="btn_delete" type="button" class="btn btn-danger" style=" margin-left: 0px; float: right; margin-top:5px;">
        <span class="glyphicon glyphicon-trash" aria-hidden="true" ></span>删除
    </button>
    <button id="btn_add" type="button" class="btn bg-primary" style="margin-left: 10px; float: right; margin-top:5px;">
        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>
</div>

    <div>
        <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="device_table">
        </table>
    </div>
</select>

</body>

<script>

    $(document).ready(function () {
        $('#device_table').DataTable({
            "destroy": true,  //不加会报错
            "language": {
                "sProcessing": "处理中...",
                "sLengthMenu": "显示 _MENU_ 项结果",
                "sZeroRecords": "没有匹配结果",
                "sInfo": "显示第 _START_ 至 _END_ 项结果，共 _TOTAL_ 项",
                "sInfoEmpty": "显示第 0 至 0 项结果，共 0 项",
                "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                "sInfoPostFix": "",
                "sSearch": "搜索:",
                "sUrl": "",
                "sEmptyTable": "表中数据为空",
                "sLoadingRecords": "载入中...",
                "sInfoThousands": ",",
                "oPaginate": {
                    "sFirst": "首页",
                    "sPrevious": "上页",
                    "sNext": "下页",
                    "sLast": "末页"
                },
                "oAria": {
                    "sSortAscending": ": 以升序排列此列",
                    "sSortDescending": ": 以降序排列此列"
                }
            },
            ajax: {
                url: "findAllDevice.action",
                dataSrc: 'result'
            },
            columns: [
                {
                    "data": null,
                    "title": "<input type='checkbox' id='check_all'/>",
                    render: function (data, type, row) {
                        var html = "<input type='checkbox' id='checkbox" + data.DeviceID + "' />";
                        return html;
                    }
                },
                {"data": "DeviceID", "title": "设备编号"},
                {"data":"DeviceClass.DeviceClassName", "title": "设备分类编号"},
                {"data": "DeviceName", "title": "设备名称"},
                {"data": "DevicePrice", "title": "设备价格"},
                {
                    "data": null,
                    "title": "操作",
                    render: function (data, type, row) {
                        var html = "<div style='margin-top:5px;' ><button type='button' onclick= 'editDevice(" + data.DeviceID + ")' id='deviceId" + data.DeviceID + "' class='btn bg-info'><span class='glyphicon glyphicon-pencil' aria-hidden='true'>编辑</span></button></div>";
                        html += "<div style='margin-top:5px;'><button type='button' onclick='deleteDevice(" + data.DeviceID + ")' id='deviceId" + data.DeviceID + "' class='btn btn-danger'><span class='glyphicon glyphicon-remove' aria-hidden='true'>删除</span></button></div>";
                        var title = " <section class='content'>" + "<div class='btn-group operation'>";
                        title += html;
                        title += "</div>"
                        return title;
                    }
                }
            ]
        })
    })

    function editDevice(deviceID) {
        $("#listOfEdit").modal();
        $.ajax({
            url:"findDeviceById.action?deviceId=" + deviceID,
            method:"GET",
            success:function (result) {
                var json = eval("("+result+")").result;
                var inp = $("#modalOfEditList").find('input');
                //console.log(inp);
                console.log(json);
                $(inp[0]).val(json[0].DeviceID);
                findAllDevice("editDeviceClassSelect", json[0].DeviceClassID);
                $(inp[1]).val(json[0].DeviceName);
                $(inp[2]).val(json[0].DevicePrice);
            }
        });
    }
    function deleteDevice(deviceId) {
        $("#delList").modal();
        var inp = $("#delList").find('input');
        $(inp[0]).val(deviceId);
    }
    $("#btn_add").click(function () {
        $("#addList").modal();
        $.ajax({
            url:"${APP_PATH}/findAllDevice",
            method:"GET",
            success:function (result) {
                var len = eval("("+result+")").result;
                $("#addDeviceId").val(len.length + 1);
                findAllDeviceClass("addDeviceClassSelect");
                $("#addDevicePrice").empty();
                $("#addDeviceName").empty();
            }
        });
    })
    function findAllDeviceClass(str, id) {
        $.ajax({
            url:"findAllDeviceClass.action",
            type:"GET",
            success:function (result) {
                //  console.log(result);
                var jsjson = eval("("+result+")");
                //console.log(jsjson);
                bulid_deviceclass_selected(jsjson, str, id);
            }
        });
    }
    $("#deviceBtnOfEdit").click( function (){
        var editDeviceId = $("#editDeviceId").val();
        var editDeviceClassId = $("#editDeviceClassSelect option:selected").val();
        var editDeviceName = $("#editDeviceName").val();
        var editDevicePrice = $("#editDevicePrice").val();
        var nowData = [].concat(editDevicePrice, editDeviceName, editDeviceClassId, editDeviceId);
        console.log(nowData);
        $.ajax({
            url:"editDevice.action?deviceId=" + editDeviceId + "&deviceClassId="+ editDeviceClassId + "&deviceName=" + editDeviceName + "&devicePrice=" + editDevicePrice,
            methods:"GET",
            success:function () {
                window.location = "deviceManage.jsp";
            }
        });
    });

    $("#deviceBtnOfDel").click(function () {
        var id = $("#delID").val();
        console.log(id);
        $.ajax({
            url:"deleteDevice.action?deviceId=" + id,
            method:"GET",
            success:function () {
                window.location = "deviceManage.jsp";
            }
        });
    });

    $("#saveDeviceBtn").click(function () {
        var addDeviceId = $("#addDeviceId").val();
        var addDeviceClassId = $("#addDeviceClassSelect option:selected").val();
        var addDevicePrice = $("#addDevicePrice").val();
        var addDeviceName = $("#addDeviceName").val();
        $.ajax({
            url:"${APP_PATH}/addDevice.action?deviceId=" + addDeviceId + "&deviceClassId="+ addDeviceClassId + "&deviceName=" + addDeviceName + "&devicePrice=" + addDevicePrice,
            method:"GET",
            success:function () {
                window.location = "deviceManage.jsp";
            }
        });
    })
    $("#btn_delete").click(function () {
        var checkIDs = new Array();
        checkIDs = getAllCheckIDs();
        console.log(checkIDs);
        for(var i = 0; i < checkIDs.length; ++i){
            $.ajax({
                url:"deleteDevice.action?deviceId=" + checkIDs[i],
                method:"POST",
            });
            console.log("#del" + checkIDs[i]);
            window.location = "deviceManage.jsp";
        }
    })
    function getAllCheckIDs(){
        var  checkBoxId = new Array();
        var trNum = ($("#device_table tbody").children("tr"));
        for(var i = 0; i < trNum.length; i++){
            var tdArr = trNum.eq(i).find("td").eq(0);
            if(tdArr.find("input").is(":checked")){
                checkBoxId.push(tdArr.children("input").attr("id").substring(8));
                //   console.log($("input[id^='checkBox']").attr("id"));
            }

        }
        console.log(checkBoxId);
        return checkBoxId;
    }
    $("#device_table").on("click","#check_all",function(){//给tr或者td添加click事件
        var check = $(this).prop("checked");
        $("input[type='checkbox']").prop("checked", check);
    })

    function bulid_deviceclass_selected(jsjson, str, id) {
        var deviceclass = jsjson.result;
        var content = '';
        if(str == 'editDeviceClassSelect'){
            var content1 = '';
            $.each(deviceclass,function(index,item){
                //console.log(item.DeviceClassName);
                if(index != id - 1) {
                    content1 += "<option value='" + item.DeviceClassID + "'>" + item.DeviceClassName + "</option>";
                }
                else{
                    content += "<option value='" + item.DeviceClassID + "'>" + item.DeviceClassName + "</option>";
                }
            });
            content += content1;
        }
        else {
            $.each(deviceclass,function(index,item){
                //console.log(item.DeviceClassName);
                content += "<option value='" + item.DeviceClassID + "'>"+ item.DeviceClassName +"</option>";
            });
        }
            //选择列表，选中的值赋值;
        $("#" + str).html(content).trigger("chosen:updated").change(function () {
            str = $("#" + str + "option:selected").val();
            //console.log(str);
        });
    }

</script>
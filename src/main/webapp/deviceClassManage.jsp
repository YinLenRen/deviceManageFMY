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

   <!-- <div>
        <button type="button" id="deviceClassBtnOfAllDelete" class="badge badge-pill badge-danger">删除</button>
        <button type="button" id="deviceClassBtnOfAdd" class="badge badge-pill badge-light" >新增</button>
    </div>-->

<div>
    <button id="btn_delete" type="button" class="btn btn-danger" style=" margin-left: 0px; float: right; margin-top:5px;">
        <span class="glyphicon glyphicon-trash" aria-hidden="true" ></span>删除
    </button>
    <button id="btn_add" type="button" class="btn bg-primary" style="margin-left: 10px; float: right; margin-top:5px;">
        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>
</div>

    <div>
        <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="deviceclass_table">
        </table>
    </div>
</body>

<script type="text/javascript">

    $(document).ready(function () {
        $('#deviceclass_table').DataTable({
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
                url: "findAllDeviceClass.action",
                dataSrc: 'result'
            },
            columns: [
                {
                    "data": null,
                    "title": "<input type='checkbox' id='check_all'/>",
                    render: function (data, type, row) {
                        var html = "<input type='checkbox' id='checkbox" + data.DeviceClassID + "' />";
                        return html;
                    }
                },
                {"data":"DeviceClassID", "title": "设备分类名称"},
                {"data": "DeviceClassName", "title": "设备名称"},
                {
                    "data": null,
                    "title": "操作",
                    render: function (data, type, row) {
                        var html = "<button type='button' onclick= 'editDeviceClass(" + data.DeviceClassID + ")' id='deviceClassID" + data.DeviceClassID + "' class='btn bg-info'><span class='glyphicon glyphicon-pencil' aria-hidden='true'>编辑</span></button>";
                        html += "<button type='button' onclick='deleteDeviceClass(" + data.DeviceClassID + ")' id='deviceClassID" + data.DeviceClassID + "' class='btn btn-danger'><span class='glyphicon glyphicon-remove' aria-hidden='true'>删除</span></button>";
                        var title = " <section class='content'>" + "<div class='btn-group operation'>";
                        title += html;
                        title += "</div>"
                        return title;
                    }
                }
            ]
        })
    })

    function editDeviceClass(deviceClassID) {
        $("#listOfEdit").modal();
        $.ajax({
            url:"findDeviceClass.action?deviceClassId=" + deviceClassID,
            method:"GET",
            success:function (result) {
                var json = eval("("+result+")").result;
                var inp = $("#modalOfEditList").find('input');
                $(inp[0]).val(json[0].DeviceClassID);
                $(inp[1]).val(json[0].DeviceClassName);
                //console.log(json[0].DeviceClassId);

            }
        });
    }
    function deleteDeviceClass(deviceClassID) {
        $("#delList").modal();
        var inp = $("#delList").find('input');
        //输入框传值
        $(inp[0]).val(deviceClassID);
    }
    $("#btn_add").click(function () {
        $("#addList").modal();
        $.ajax({
            url:"findAllDeviceClass.action",
            method:"GET",
            success:function (result) {
                var deviceclass = eval("(" + result + ")").result;
                $.each(deviceclass, function (index, item) {
                    if(index == deviceclass.length - 1){
                        $("#addDeviceClassId").val(item.DeviceClassID + 1);
                    }
                })
            }
        });
    })
    $("#btn_delete").click(function () {
        var checkIDs = new Array();
        checkIDs = getAllCheckIDs();
        for(var i = 0; i < checkIDs.length; ++i){
            $.ajax({
                url:"deleteDeviceClass.action?deviceClassId=" + checkIDs[i],
                method:"POST",
            });
        }
        window.location = "deviceClassManage.jsp";
    })
    $("#deviceClassBtnOfEdit").click( function (){
        var editDeviceClassId = $("#editDeviceClassId").val();
        //console.log(editDeviceClassId);
        var editDeviceClassName = $("#editDeviceClassName").val();
        var nowData = [].concat(editDeviceClassName, editDeviceClassId);
        $.ajax({
            url:"editDeviceClass.action?deviceClassId=" + editDeviceClassId + "&deviceClassName=" + editDeviceClassName,
            methods:"GET",
            success:function () {
                window.location = "deviceClassManage.jsp";
                //查找id为"#edit" + editDeviceClassId所在td的所有td
                /*var newData = Array.prototype.slice.call($("#edit" + editDeviceClassId).parent().prevAll());
                //console.log(newData);
                for(var i = 0; i < nowData.length; ++i){
                    newData[i].innerHTML = nowData[i];
                }*/
            }
        });
    });

    $("#deviceClassBtnOfDel").click(function () {
        var id = $("#delID").val();
        console.log(id);
        $.ajax({
            url:"deleteDeviceClass.action?deviceClassId=" + id,
            method:"GET",
            success:function () {
                window.location = "deviceClassManage.jsp";
            }
        });
    });

    $("#saveDeviceClassBtn").click(function () {
        var addDeviceClassId = $("#addDeviceClassId").val();
        var addDeviceClassName = $("#addDeviceClassName").val();
        $.ajax({
            url:"addDeviceClass.action?deviceClassId=" + addDeviceClassId + "&deviceClassName=" + addDeviceClassName,
            method:"GET",
            success:function () {
                window.location = "deviceClassManage.jsp";
            }
        });
    })
    function getAllCheckIDs(){
        var  checkBoxId = new Array();
        var trNum = ($("#deviceclass_table tbody").children("tr"));
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
    /*全选、全不选
     *prop设置属性或值
     */
    $("#deviceclass_table").on("click","#check_all",function(){//给tr或者td添加click事件
        var check = $(this).prop("checked");
        $("input[type='checkbox']").prop("checked", check);
    })

</script>
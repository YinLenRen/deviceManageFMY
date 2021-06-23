<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>购物列表</title>
        <%pageContext.setAttribute("APP_PATH", request.getContextPath());%>
    <script src="${APP_PATH}/jslib/js/jquery-1.12.4.min.js"></script>
    <!--  <script src="./jslib/js/mui.min.js"></script>
      <link href="./jslib/css/mui.min.css" rel="stylesheet"/>
      <link rel="stylesheet" type="text/css" href="./jslib/css/app.css"/>   script不可用<script   /> -->
    <link href="jslib/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src="jslib/bootstrap-3.3.7-dist/js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.25/datatables.min.css"/>
    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.25/datatables.min.js"></script>

    <script type="text/javascript" src="jslib/layDate-v5.3.1/laydate/laydate.js"></script>

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
                <button type="button" class="btn btn-danger" data-dismiss="modal" id="shoppingcartBtnOfDel">确定</button>
            </div>
        </div>
    </div>
</div>

<!--编辑-->
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
                        <label class="col-form-label">订单编号</label>
                        <input type="text" class="form-control" id="editShoppingcartId" readonly>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">设备名称</label>
                        <select class="form-control" id="editDeviceSelect" >
                            <option value=""></option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">购买数量</label>
                        <input type="text" class="form-control" id="editBuyNum">
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">用户</label>
                        <select class="form-control" id="editUserSelected" >
                            <option value=""></option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="cannelBtn">重置</button>
                <button type="button" class="btn btn-primary" id="shoppingcartBtnOfEdit" data-dismiss="modal">确定</button>
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
                    <label class="col-form-label">订单编号</label>
                    <input type="text" class="form-control" id="addShoppingcartId" readonly>
                </div>
                    <div class="form-group">
                        <label class="col-form-label">设备名称</label>
                        <select class="form-control" id="addDeviceSelect" >
                            <option value=""></option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">购买数量</label>
                        <input type="text" class="form-control" id="addBuyNum">
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">用户</label>
                        <select class="form-control" id="addUserSelected" >
                            <option value=""></option>
                        </select>
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
<!--结算-->
<div class="modal fade" id="calulationList" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">结算|</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label class="col-form-label">用户</label>
                        <select class="form-control" id="calulationUserSelect" >
                            <option value=""></option>
                        </select>
                        <!--<input type="text" class="form-control" id="calulationUser"></input>-->
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">订单接收人</label>
                        <input type="text" class="form-control" id="calulationReceiver">
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">接收人地址</label>
                        <input type="text" class="form-control" id="calulationAddress">
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">创建时间</label>
                        <input type="text" class="form-control" id="demoTest" style="width: 274px;">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="calulationCannelBtn">重置</button>
                <button type="button" class="btn btn-primary" id="calulationShoppingcartBtn" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<div>
    <button id="btn_calulation" type="button" class="btn btn-danger" style=" margin-left: 0px; float: right; margin-top:5px;">
        <span class="glyphicon glyphicon-yen" aria-hidden="true" ></span>结算
    </button>
    <button id="btn_add" type="button" class="btn bg-primary" style="margin-left: 10px; float: right; margin-top:5px;">
        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>
</div>

<div>
    <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="shoppingcart_table">
    </table>
</div>

<script>
    laydate.render({
        elem: '#demoTest' //指定元素,
        ,theme: '#393D49'
    });
</script>

</body>

<script>

    $(document).ready(function () {
        $('#shoppingcart_table').DataTable({
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
                url: "findAllShopingcart.action",
                dataSrc: 'result'
            },
            columns: [
                {
                    "data": null,
                    "title": "<input type='checkbox' id='check_all'/>",
                    render: function (data, type, row) {
                        var html = "<input type='checkbox' id='checkbox" + data.ShopingcartID + "' />";
                        return html;
                    }
                },
                {"data":"ShopingcartID", "title": "购物车编号"},
                {"data": "Device.DeviceName", "title": "设备名称"},
                {"data":"BuyNum", "title": "购买数量"},
                {"data": "User.UserName", "title": "用户"},
                {
                    "data": null,
                    "title": "操作",
                    render: function (data, type, row) {
                        var html = "<button type='button' onclick= 'editShoppingcart(" + data.ShopingcartID + ")' id='ShopingcartID" + data.ShopingcartID + "' class='btn bg-info'><span class='glyphicon glyphicon-pencil' aria-hidden='true'>编辑</span></button>";
                        html += "<button type='button' onclick='deleteShoppingcart(" + data.ShopingcartID + ")' id='ShopingcartID" + data.ShopingcartID + "' class='btn btn-danger'><span class='glyphicon glyphicon-remove' aria-hidden='true'>删除</span></button>";
                        var title = " <section class='content'>" + "<div class='btn-group operation'>";
                        title += html;
                        title += "</div>"
                        return title;
                    }
                }
            ]
        })
    })
    function editShoppingcart(ShopingcartID){
        $("#listOfEdit").modal();
        $.ajax({
            url:"findShopingcartById?shopingcartId=" + ShopingcartID,
            method:"GET",
            success:function (result) {
                var jsjson = eval("(" + result + ")").result;
                console.log(jsjson);
                var inp = $("#modalOfEditList").find('input');

                $(inp[0]).val(jsjson[0].ShopingcartID);
                findAllUser("editUserSelected", jsjson[0].User.UserID);
                findAllDevice("editDeviceSelect", jsjson[0].Device.DevcieID);
                $(inp[1]).val(jsjson[0].BuyNum);
            }
        });
    }
    $("#btn_add").click(function () {
        $("#addList").modal();
        $.ajax({
            url:"findAllShopingcart.action",
            method:"GET",
            success:function (result) {
                var deviceclass = eval("(" + result + ")").result;
                $.each(deviceclass, function (index, item) {
                    if(index == deviceclass.length - 1){
                        $("#addShoppingcartId").val(item.ShopingcartID + 1);
                        findAllDevice("addDeviceSelect");
                        findAllUser("addUserSelected");
                    }
                })
            }
        });
    })
    $("#saveDeviceClassBtn").click(function () {
       var addDeviceName = $("#addDeviceSelect option:selected").val();
        var addBuyNum = $("#addBuyNum").val();
        var addUserID = $("#addUserID").val();
        $.ajax({
            url:"addShopingcart.action?deviceId=" + addDeviceName + "&buyNum=" + addBuyNum + "&userId=" + addUserID,
            method:"GET",
            success:function () {
                window.location = "shoppingcartManage.jsp";
            }
        });
    })

    function findAllDevice(str, id) {
        $.ajax({
            url:"findAllDevice.action",
            type:"GET",
            success:function (result) {
                //  console.log(result);
                var jsjson = eval("("+result+")");
                //console.log(jsjson);
                bulid_device_selected(jsjson, str, id);
            }
        });
    }
    function bulid_device_selected(jsjson, str, id) {
        var deviceclass = jsjson.result;
        var content = '';
        if(str == 'editDeviceSelect'){
            var content1 = '';
            $.each(deviceclass,function(index,item){
                //console.log(item.DeviceClassName);
                if(index != id - 1) {
                    content1 += "<option value='" + item.DeviceID + "'>" + item.DeviceName + "</option>";
                }
                else{
                    content += "<option value='" + item.DeviceID + "'>" + item.DeviceName + "</option>";
                }
            });
            content += content1;
        }
        else {
            $.each(deviceclass,function(index,item){
                //console.log(item.DeviceClassName);
                content += "<option value='" + item.DeviceID + "'>"+ item.DeviceName +"</option>";
            });
        }
        //选择列表，选中的值赋值;
        $("#" + str).html(content).trigger("chosen:updated").change(function () {
            str = $("#" + str + "option:selected").val();
            //console.log(str);
        });
    }
    $("#shoppingcartBtnOfEdit").click(function () {
        var id = $("#editShoppingcartId").val();
        var userId = $("#editUserID").val();
        var deviceId = $("#editDeviceSelect option:selected").val();
        var editBuyNum = $("#editBuyNum").val();
        $.ajax({
            url:"updateShoppingcart.action?shoppingcartId=" + id + "&deviceId=" + deviceId + "&buyNum=" + editBuyNum + "&userId=" + userId,
            method:"GET",
            success:function () {
                window.location = "shoppingcartManage.jsp";
            }
        });
    })
    function deleteShoppingcart(ShopingcartID) {
        $("#delList").modal();
        var inp = $("#delList").find("input");
        $(inp[0]).val(ShopingcartID);
    }
    $("#shoppingcartBtnOfDel").click(function () {
        var id = $("#delID").val();
        console.log(id);
        $.ajax({
            url:"deleteShopingcart.action?deleteShopingcartId=" + id,
            method: "GET",
        });
        window.location = "shoppingcartManage.jsp";
    })
    function getAllCheckIDs(){
        var  checkBoxId = new Array();
        var trNum = ($("#shoppingcart_table tbody").children("tr"));
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
    $("#shoppingcart_table").on("click","#check_all",function(){//给tr或者td添加click事件
        var check = $(this).prop("checked");
        $("input[type='checkbox']").prop("checked", check);
    })
    $("#btn_calulation").click(function () {
        $("#calulationList").modal();
        findAllUser("calulationUserSelect");

    })
    function findAllUser(str, id){
        $.ajax({
            url:"findAllUser.action",
            method:"GET",
            success:function (result) {
                var user = eval("(" + result + ")");
                bulid_user_selected(user, str, id);
            }
        })
    }
    function bulid_user_selected(user, str, id){
        var user = user.result;
        var content = '';
        if(str == "editUserSelected"){
            var content1 = '';
            $.each(user, function (index, item) {
                if(index != id - 1){
                    content1 += "<option value='" + item.UserID +"'>" + item.UserName + "</option>";
                }
                else content += "<option value='" + item.UserID +"'>" + item.UserName + "</option>";
            })
            content += content1;
        }
        else{
            $.each(user, function (index, item) {
                content += "<option value='" + item.UserID + "'>" + item.UserName + "</option>";
            })
        }
        $("#" + str).html(content).trigger("chosen:updated").change(function () {
            var str = $("#" + str + "option:selected").val();
        })
    }
    $("#calulationShoppingcartBtn").click(function () {
        var calulationUser = $("#calulationUserSelect option:selected").val();
        var calulationReceiver = $("#calulationReceiver").val();
        var calulationAddress = $("#calulationAddress").val();
        var calulationCreateTime = $("#demoTest").val();
        var checked = getAllCheckIDs();
        console.log(checked.toString());
        $.ajax({
            url:"calulation.action?userId=" + calulationUser + "&receive=" + calulationReceiver + "&receiveAddress=" + calulationAddress + "&createtime=" + calulationCreateTime + "&shopingcartids=" + checked.toString(),
            method:"GET",
            success:function () {
                window.location = "shoppingcartManage.jsp";
            }
        })
    })

</script>
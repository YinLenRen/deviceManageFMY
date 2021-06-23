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
                <button type="button" class="btn btn-danger" data-dismiss="modal" id="shoppingorderitemBtnOfDel">确定</button>
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
                        <input type="text" class="form-control" id="editShoppingorderitemId" readonly>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">订单项编号</label>
                        <input type="text" class="form-control" id="editShoppingorderId" readonly>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">设备名称</label>
                        <input type="text" class="form-control" id="editDeviceName">
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">购买数量</label>
                        <input type="text" class="form-control" id="editBuyNum"></input>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="cannelBtn">重置</button>
                <button type="button" class="btn btn-primary" id="shoppingorderitemBtnOfEdit" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<div>
    <button type="button" id="deviceBtnOfAllDelete" class="badge badge-pill badge-danger">删除</button>
    <button type="button" id="deviceBtnOfAdd" class="badge badge-pill badge-light" >新增</button>
</div>

<div>
    <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="shoppingorderitem_table">
        <thead>
        <tr>
            <th scope="col"><input type="checkbox" id="check_all"/></th>
            <th scope="col">订单编号</th>
            <th scope="col">设备名称</th>
            <th scope="col">购买数量</th>
            <th scope="col">用户ID</th>
            <th scope="col">操作</th>
        </tr>
        </thead>
        <tbody>

        </tbody>
    </table>
</div>
</body>

<script>
    $(function () {
        findAllShoppingorderitem();
    });
    function findAllShoppingorderitem() {
        $.ajax({
            url:"${APP_PATH}/findAllShopingcart",
            method:"GET",
            success:function (result) {
                var jsjson = eval("(" + result + ")");
                console.log(jsjson);
                bulid_shoppingorderitem_table(jsjson);
            }
        });
    }
    function bulid_shoppingorderitem_table(jsjson) {
        $("#shoppingorderitem_table tbody").empty();
        var shoppingorderitem = jsjson.result;
        console.log(shoppingorderitem);
        $.each(shoppingorderitem, function (index, item) {
            var checkbox = $("<td><input type='checkbox'></td>");
            checkbox.attr("id", "checkbox" + item.ShopingcartID);
            var shoppingorderitemId = $("<td></td>").append(item.ShopingcartID);
            shoppingorderitemId.attr("id", "DeviceId" + item.ShopingcartID);

            var deviceName = $("<td></td>").append(item.Device.DeviceName);
            deviceName.attr("id", "deviceName" + item.ShopingcartID);

            var buyNum = $("<td></td>").append(item.BuyNum);
            buyNum.attr("id", "userId" + item.ShopingcartID);

            var userId = $("<td></td>").append(item.UserId);
            userId.attr("id", "userId" + item.ShopingcartID);

            var edit = $("<button></button>").addClass("btn btn-secondary").append("编辑");
            //动态生成id
            edit.attr("id", "edit" + item.ShopingOrderItemId);
            var del = $("<button></button>").addClass("btn btn-secondary").append("删除");
            del.attr("id", "del" + item.ShopingcartID);
            var btnGroup = $("<td></td>").addClass("btn-group").append(edit).append().append(del);
            $("<tr></tr>").append(checkbox).append(shoppingorderitemId).append(deviceName).append(buyNum).append(userId).append(btnGroup).appendTo("#shoppingorderitem_table tbody");

        });
    }
    $(document).on('click', 'button[id^=del]', function () {
        $("#delList").modal();
        var id = $(this).attr("id").substring(3);
        var inp = $("#delList").find("input");
        $(inp[0]).val(id);
    })
    $("#shoppingorderitemBtnOfDel").click(function () {
        var id = $("#delID").val();
        $.ajax({
            url:"${APP_PATH}/deleteShopingorderitem?deleteShopingorderitemId=" + id,
            method: "GET",
        });
        $("#del" + id).parent().parent().remove();
    })
    $(document).on('click', 'button[id^=edit]', function () {
        $("#listOfEdit").modal();
        var id = $(this).attr("id").substring(4);
        $.ajax({
            url:"${APP_PATH}/findShopingorderitemById?shopingOrderItemId=" + id,
            method:"GET",
            success:function (result) {
                var jsjson = eval("(" + result + ")").result;
                console.log(jsjson);
                var inp = $("#modalOfEditList").find('input');
                $(inp[0]).val(jsjson[0].ShopingOrderItemId);
                $(inp[1]).val(jsjson[0].ShopingOrderId);
                $(inp[2]).val(jsjson[0].Device.DeviceName);
                $(inp[3]).val(jsjson[0].BuyNum);
            }
        });
    })
    $("#shoppingorderitemBtnOfEdit").click(function () {
        var id = $("#editShoppingorderitemId").val();
        var orderId = $("#editShoppingorderId").val();
        var deviceName = $("#editDeviceName").val();
        var editBuyNum = $("#editBuyNum").val();
        var update = [].concat(editBuyNum, deviceName, orderId, id);
        console.log(update);
        $.ajax({
            url:"${APP_PATH}/updateShoppingorderitem?shopingorderitemId=" + id + "&shoppingorderId=" + orderId + "&deviceName=" + deviceName + "&buyNum=" + editBuyNum,
            method:"GET",
            success:function () {
                var allTd = Array.prototype.slice.call($("#edit" + id).parent().prevAll());
                for(var i = 0; i < update.length; ++i){
                    allTd[i].innerHTML = update[i];
                }
            }
        });
    })

</script>
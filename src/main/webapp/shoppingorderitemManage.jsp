<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>购物订单列表</title>
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
                        <label class="col-form-label">订单项编号</label>
                        <input type="text" class="form-control" id="addShoppingorderitemId" readonly>
                    </div>
                    <div class="form-group">
                        <label class="col-form-label">订单编号</label>
                        <input type="text" class="form-control" id="addShoppingorderId" >
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
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal" id="addCannelBtn">重置</button>
                <button type="button" class="btn btn-primary" id="saveDeviceClassBtn" data-dismiss="modal">确定</button>
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
    <button id="btn_delete" type="button" class="btn btn-danger" style=" margin-left: 0px; float: right; margin-top:5px;">
        <span class="glyphicon glyphicon-trash" aria-hidden="true" ></span>删除
    </button>
    <button id="btn_add" type="button" class="btn bg-primary" style="margin-left: 10px; float: right; margin-top:5px;">
        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>
</div>

<div>
    <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="shoppingorderitem_table">
        </tbody>
    </table>
</div>
</body>

<script>

    $(document).ready(function () {
        $('#shoppingorderitem_table').DataTable({
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
                url: "findAllShopingorderitem.action",
                dataSrc: 'result'
            },
            columns: [
                {
                    "data": null,
                    "title": "<input type='checkbox' id='check_all'/>",
                    render: function (data, type, row) {
                        var html = "<input type='checkbox' id='checkbox" + data.ShopingOrderItemId + "' />";
                        return html;
                    }
                },
                {"data":"ShopingOrderItemID", "title": "订单项编号"},
                {"data": "ShopingOrderID", "title": "订单编号"},
                {"data":"Device.DeviceName", "title": "设备名称"},
                {"data": "BuyNum", "title": "购买数量"},
                {
                    "data": null,
                    "title": "操作",
                    render: function (data, type, row) {
                        var html = "<button type='button' onclick= 'editShopingOrderItem(" + data.ShopingOrderItemId + ")' id='ShopingOrderItemId" + data.ShopingOrderItemId + "' class='btn bg-info'><span class='glyphicon glyphicon-pencil' aria-hidden='true'>编辑</span></button>";
                        html += "<button type='button' onclick='deleteShopingOrderItem(" + data.ShopingOrderItemId + ")' id='ShopingOrderItemId" + data.ShopingOrderItemId + "' class='btn btn-danger'><span class='glyphicon glyphicon-remove' aria-hidden='true'>删除</span></button>";
                        var title = " <section class='content'>" + "<div class='btn-group operation'>";
                        title += html;
                        title += "</div>"
                        return title;
                    }
                }
            ]
        })
    })
    function editShopingOrderItem(ShopingOrderItemId) {
    }
    $("#btn_add").click(function () {
    })
    $("#btn_delete").click(function () {

    })
    function deleteShopingOrderItem(ShopingOrderItemId) {
        $("#delList").modal();
        var inp = $("#delList").find("input");
        $(inp[0]).val(ShopingOrderItemId);
    }
    $("#shoppingorderitemBtnOfDel").click(function () {
        var id = $("#delID").val();
        $.ajax({
            url:"deleteShopingorderitem.action?deleteShopingorderitemId=" + id,
            method: "GET",
        });
        window.location = "shoppingorderitemManage.jsp";
    })
    $("#shoppingorderitem_table").on("click", "#check_all", function () {
        $("input[type='checkbox']").prop("checked", $(this).prop("checked"));
    })


    /*function findAllShoppingorderitem() {
        $.ajax({
            url:"${APP_PATH}/findAllShopingorderitem",
            method:"GET",
            success:function (result) {
                var jsjson = eval("(" + result + ")");
                console.log(jsjson);
                bulid_shoppingorderitem_table(jsjson);
            }
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
    })*/


</script>
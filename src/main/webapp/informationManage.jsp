<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>资讯列表</title>
        <%pageContext.setAttribute("APP_PATH", request.getContextPath());%>
    <script src="${APP_PATH}/jslib/js/jquery-1.12.4.min.js"></script>
    <!--  <script src="./jslib/js/mui.min.js"></script>
      <link href="./jslib/css/mui.min.css" rel="stylesheet"/>
      <link rel="stylesheet" type="text/css" href="./jslib/css/app.css"/>   script不可用<script   /> -->
    <!--<link href="jslib/bootstrap-4.6.0-dist/css/bootstrap.css" rel="stylesheet">
    <script src="jslib/bootstrap-4.6.0-dist/js/bootstrap.js"></script>-->
    <script type="text/javascript" charset="utf-8" src="./ueditor1.4.3.3/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="./ueditor1.4.3.3/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="./ueditor1.4.3.3/lang/zh-cn/zh-cn.js"></script>


    <link href="jslib/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
    <script src="jslib/bootstrap-3.3.7-dist/js/bootstrap.js"></script>


    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/v/dt/dt-1.10.25/datatables.min.css"/>

    <script type="text/javascript" src="https://cdn.datatables.net/v/dt/dt-1.10.25/datatables.min.js"></script>

    <style type="text/css">
        img{
            width: 50px;
            height: 50px;
            padding: 0px;
            margin-top: 2px;
        }
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
        span{
            float:left;
            padding-left: 5px;
        }
        .dd {
            font-size: 10px;
            width: 730px;
            course: hand;
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis; /* IE */
        }
        .btn{
            padding:5px;
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
                <button type="button" class="btn btn-danger" data-dismiss="modal" id="informationBtnOfDel">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="btn-group operation">
    <a href="addInformation.html">
        <button id="btn_add" type="button" class="btn bg-primary" style="margin-left: 10px;">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
        </button>
    </a>
    <button id="btn_delete" type="button" class="btn btn-danger" style=" margin-left: 0px">
        <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>删除
    </button>
</div>
<!--<hr>-->

<div>
    <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="information_table">

    </table>
</div>

</body>

<script type="text/javascript">

    $(document).ready(function() {
        $('#information_table').DataTable({
            "destroy":true,  //不加会报错
            ajax:{
                url:"findAllInformation.action",
                dataSrc:'result'
            },
            columns:[
                {
                    "data":null,
                    "title": "<input type='checkbox' id='check_all'/>",
                    render: function (data, type, row) {
                        var html = "<input type='checkbox'/>";
                        return html;
                    }
                },
                {"data": "InformationID", "title":"编号"},
                {
                    "data":null,
                    "title":"咨询内容",
                    render:function (data, type, row) {
                        var content = data.InformationContent;
                        var imgURL = content.split('<x>')[3].split('<p>')[1];
                        var html = "<div>" + "<img src='"+ $(imgURL)[0].src +"' style='float:left;'/>";

                        var title = content.split('<x>')[1].replace(/<[^>]+>/,"");
                        html += "<span >" + title + "</span>";

                        var brife = content.split('<x>')[2].replaces(/<[^>]+>/,"");
                        html += "<br><span class='dd'>" + brife + "</span>";

                        html += "</div>"
                        return html;
                    }
                },
                {"data":"InformationImage", "title":"咨询图片"},
                {"data":"InformationCreateTime", "title":"咨询创建时间"},
                {
                    "data": null,
                    "title": "操作",
                    render: function (data, type, row) {
                        var html = "<div style='margin-top:5px;' ><button type='button' onclick= 'editInformation("+ data.InformationID +")' id='InformationID" + data.InformationID + "' class='btn bg-info'><span class='glyphicon glyphicon-pencil' aria-hidden='true'>编辑</span></button></div>";
                        html += "<div style='margin-top:5px;' ><button type='button' onclick='deleteInformation("+ data.InformationID +")' id='InformationID" + data.InformationID + "' class='btn btn-danger'><span class='glyphicon glyphicon-remove' aria-hidden='true'>删除</span></button></div>";
                        var title = " <section class='content'>" + "<div class='btn-group operation'>";
                        title += html;
                        title += "</div>"
                        return title;
                    }
                }
            ]
        });
    });

    function editInformation(informationId) {
        $(location).attr("href","updateInformation.html?id=" + informationId);
    }

    function deleteInformation(informationId){
        $("#delList").modal();
        //输入框传值
        $("#delID").val(informationId);
    }
    $("#information_table").on("click","#check_all",function(){//给tr或者td添加click事件
        console.log("111");
        var check = $(this).prop("checked");
        $("input[type='checkbox']").prop("checked", check);
    })

    $("#informationBtnOfDel").click(function () {
        var id = $("#delID").val();
        $.ajax({
            url:"deleteInformation.action?informationId=" + id,
            method:"GET"
        });
        $("#InformationID" + id).parent().parent().parent().parent().remove();
    })

</script>
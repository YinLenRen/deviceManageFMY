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
    <script type="text/javascript" charset="utf-8" src="./ueditor1.4.3.3/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="./ueditor1.4.3.3/ueditor.all.min.js"> </script>
    <script type="text/javascript" charset="utf-8" src="./ueditor1.4.3.3/lang/zh-cn/zh-cn.js"></script>
    <link href="jslib/bootstrap-4.6.0-dist/css/bootstrap.css" rel="stylesheet">

    <style type="text/css">
        img{
            width: 100px;
            height: 100px;
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
        }
        .badge-light{
            margin-right: 5px;
        }
        .badge-danger{
            margin-right: 5px;
        }
        .badge{
            font-size: 20px;
            margin-top: 5px;
            margin-bottom: 10px;
            float: right;
        }
        .btn-group, .btn-group-vertical {
            display: inline;
            vertical-align: middle;
            margin: 100px auto;
            padding: 0px;
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

    <button type="button" id="informationBtnOfAllDelete" class="badge badge-pill badge-danger">删除</button>
    <a href="addInformation.html">
         <button type="button" id="informationBtnOfAdd" class="badge badge-pill badge-light" >新增</button>
    </a>
</div>

<div>
    <table class="table table-striped table-bordered row-border hover order-column" cellspacing="0" width="100%" id="information_table">
        <thead>
        <tr>
            <th scope="col"><input type="checkbox" id="check_all"/></th>
            <th scope="col">资讯编号</th>
            <th scope="col">资讯内容</th>
            <th scope="col">资讯图片</th>
            <th scope="col">资讯创建时间</th>
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
        findAllInformation();
    });

    function findAllInformation() {
        $.ajax({
            url:"${APP_PATH}/findAllInformation",
            type:"GET",
            success:function (result) {
                //  console.log(result);
                var jsjson = eval("("+result+")");
                console.log(jsjson);
                build_information_table(jsjson);
            }
        });
    }
    function build_information_table(jsjson) {
        $("#information_table tbody").empty();
        var information = jsjson.result;
        console.log(information);
        $.each(information, function (index, item) {
            var checkBox = $("<td><input type='checkbox'/></td>");
            checkBox.attr("id", "checkBox" + item.InformationID);

            var informationID = $("<td></td>").append(item.InformationID);
            informationID.attr("id", "informationID" + item.InformationID);

            var informationContent = $("<td></td>").append(item.InformationContent);
            informationContent.attr("id", "informationContent" + item.InformationID);

            var informationImage = $("<td></td>").append(item.InformationImage);
            informationImage.attr("id", "informationImage" + item.InformationID);

            var informationCreateTime = $("<td></td>").append(item.InformationCreateTime);
            informationCreateTime.attr("id", "informationCreateTime" + item.InformationID);

            var edit = $("<button></button>").addClass("btn btn-secondary").append("编辑");
            edit.attr("id", "edit" + item.InformationID);
            var del = $("<button></button>").addClass("btn btn-secondary").append("删除");
            del.attr("id", "del" + item.InformationID);
            var btnGroup = $("<td></td>").addClass("btn-group").append(edit).append(" ").append(del);
            $("<tr></tr>").append(checkBox).append(informationID).append(informationContent).append(informationImage).append(informationCreateTime).append(btnGroup).appendTo("#information_table tbody");
        });
    }
    $(document).on("click", 'button[id^=del]', function () {
        var id = $(this).attr("id").substring(3);
        console.log(id)
        $("#delList").modal();
        $.ajax({
            url:"${APP_PATH}/findInformationById?informationId=" + id,
            method:"GET",
            success:function (result) {
                var json = eval("("+result+")").result;
                var inp = $("#delList").find('input');
                //输入框传值
                $(inp[0]).val(json[0].InformationID);
            }
        });
    })
    $("#informationBtnOfDel").click(function () {
        var id = $("#delID").val();
        $.ajax({
            url:"${APP_PATH}/deleteInformation?informationId=" + id,
            method:"GET"
        });
        $("#del" + id).parent().parent().remove();
    })
    $(document).on("click", 'button[id^=edit]', function () {
        var id = $(this).attr("id").substring(4);
        console.log(id);
        $(location).attr("href","updateInformation.html?id=" + id);
    })

</script>
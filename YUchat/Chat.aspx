﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Chat.aspx.cs" Inherits="YUchat.Chat" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>YUchat : Chat</title>

    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <link href="Content/font-awesome.css" rel="stylesheet" />
    <link rel="icon" href="/pics/pigeon.png" type="image/x-icon">


    <script src="Scripts/jquery-3.2.1.min.js"></script>
    <script src="Scripts/jquery.signalR-2.4.3.min.js"></script>
    <script src="Scripts/date.format.js"></script>
    <link href="Content/emojionearea.min.css" rel="stylesheet" />  
    <script src="Scripts/emojionearea.js"></script> 

    <script src="signalr/hubs"></script>
    <script type="text/javascript" src="Scripts/jquery.slimscroll.min.js"></script>

    <script type="text/javascript">



        $(function () {
            var chatHub = $.connection.chatHub;
            registerClientMethods(chatHub);
            $.connection.hub.start().done(function () {

                registerEvents(chatHub)

            });
            $(document).on('change', '#<%= FileUpload1.ClientID%>', function (e) {

                var tmppath = URL.createObjectURL(e.target.files[0]);
                $("#ImgDisp").attr('src', tmppath);

            });

        });

        function ShowTitleAlert(newMessageTitle, pageTitle) {
            if (document.title == pageTitle) {
                document.title = newMessageTitle;
            }
            else {
                document.title = pageTitle;
            }
        }

        function registerEvents(chatHub) {


            var name = '<%= this.UserName %>';

            if (name.length > 0) {
                chatHub.server.connect(name);

            }
            $('#btnClearChat').click(function () {

                var msg = $("#divChatWindow").html();

                if (msg.length > 0) {
                    chatHub.server.clearTimeout();
                    $('#divChatWindow').html('');

                }
            });


            $('#btnSendMsg').click(function () {

                var msg = $("#txtMessage").val();

                if (msg.length > 0) {

                    var userName = $('#hdUserName').val();

                    var date = GetCurrentDateTime(new Date());

                    chatHub.server.sendMessageToAll(userName, msg, date);
                    $("#txtMessage").val('');
                }
            });

            $("#txtMessage").keypress(function (e) {
                if (e.which == 13) {
                    $('#btnSendMsg').click();
                }
            });
        }

        function registerClientMethods(chatHub) {
            chatHub.client.onConnected = function (id, userName, allUsers, messages, times) {

                $('#hdId').val(id);
                $('#hdUserName').val(userName);
                $('#spanUser').html(userName);
                for (i = 0; i < allUsers.length; i++) {

                    AddUser(chatHub, allUsers[i].ConnectionId, allUsers[i].UserName, allUsers[i].UserImage, allUsers[i].LoginTime);
                }
                for (i = 0; i < messages.length; i++) {
                    AddMessage(messages[i].UserName, messages[i].Message, messages[i].Time, messages[i].UserImage);

                }
            }
            chatHub.client.onNewUserConnected = function (id, name, UserImage, loginDate) {
                AddUser(chatHub, id, name, UserImage, loginDate);
            }
            chatHub.client.onUserDisconnected = function (id, userName) {

                $('#Div' + id).remove();

                var ctrId = 'private_' + id;
                $('#' + ctrId).remove();


                var disc = $('<div class="disconnect">"' + userName + '" je offline.</div>');

                $(disc).hide();
                $('#divusers').prepend(disc);
                $(disc).fadeIn(200).delay(2000).fadeOut(200);

            }

            chatHub.client.messageReceived = function (userName, message, time, userimg) {

                AddMessage(userName, message, time, userimg);
            }

            chatHub.client.sendPrivateMessage = function (windowId, fromUserName, message, userimg, CurrentDateTime) {

                var ctrId = 'private_' + windowId;
                if ($('#' + ctrId).length == 0) {

                    OpenPrivateChatBox(chatHub, windowId, ctrId, fromUserName, userimg);

                }

                var CurrUser = $('#hdUserName').val();
                var Side = 'right';
                var TimeSide = 'left';

                if (CurrUser == fromUserName) {
                    Side = 'left';
                    TimeSide = 'right';

                }
                else {
                    var Notification = 'Nova poruka od ' + fromUserName;
                    IntervalVal = setInterval("ShowTitleAlert('YUchat', '" + Notification + "')", 1000);

                    var msgcount = $('#' + ctrId).find('#MsgCountP').html();
                    msgcount++;
                    $('#' + ctrId).find('#MsgCountP').html(msgcount);
                    $('#' + ctrId).find('#MsgCountP').attr("title", msgcount + ' Novih poruka');
                }

                var divChatP = '<div class="direct-chat-msg ' + Side + '">' +
                    '<div class="direct-chat-info clearfix">' +
                    '<span class="direct-chat-name pull-' + Side + '">' + fromUserName + '</span>' +
                    '<span class="direct-chat-timestamp pull-' + TimeSide + '"">' + CurrentDateTime + '</span>' +
                    '</div>' +

                    ' <img class="direct-chat-img" src="' + userimg + '" alt="Message User Image">' +
                    ' <div class="direct-chat-text" >' + message + '</div> </div>';

                $('#' + ctrId).find('#divMessage').append(divChatP);
                var ScrollHeight = $('#' + ctrId).find('#divMessage')[0].scrollHeight;
                $('#' + ctrId).find('#divMessage').slimScroll({
                    height: ScrollHeight
                });
            }


        }

        function GetCurrentDateTime(now) {

            var localdate = dateFormat(now, "dddd, mmmm dS, yyyy, h:MM:ss TT");

            return localdate;
        }

        function AddUser(chatHub, id, name, UserImage, date) {

            var userId = $('#hdId').val();

            var code = "";

            var Clist = "";
            if (userId == id) {

                code = $('<div class="box-comment">' +
                    '<img class="img-circle img-sm" src="' + UserImage + '" alt="Profilna slika" />' +
                    ' <div class="comment-text">' +
                    '<span class="username">' + name + '<span class="text-muted pull-right">' + date + '</span>  </span></div></div>');


                Clist = $(
                    '<li style="background:#494949;">' +
                    '<a href="#">' +
                    '<img class="contacts-list-img" src="' + UserImage + '" alt="Profilna slika" />' +

                    ' <div class="contacts-list-info">' +
                    ' <span class="contacts-list-name" id="' + id + '">' + name + ' <small class="contacts-list-date pull-right">' + date + '</small> </span>' +
                    ' <span class="contacts-list-msg">How have you been? I was...</span></div></a > </li >');

            }
            else {

                code = $('<div class="box-comment" id="Div' + id + '">' +
                    '<img class="img-circle img-sm" src="' + UserImage + '" alt="Profilna slika" />' +
                    ' <div class="comment-text">' +
                    '<span class="username">' + '<a id="' + id + '" class="user" >' + name + '<a>' + '<span class="text-muted pull-right">' + date + '</span>  </span></div></div>');


                Clist = $(
                    '<li>' +
                    '<a href="#">' +
                    '<img class="contacts-list-img" src="' + UserImage + '" alt="Profilna slika" />' +

                    ' <div class="contacts-list-info">' +
                    '<span class="contacts-list-name" id="' + id + '">' + name + ' <small class="contacts-list-date pull-right">' + date + '</small> </span>' +
                    ' <span class="contacts-list-msg">How have you been? I was...</span></div></a > </li >');

                var UserLink = $('<a id="' + id + '" class="user" >' + name + '<a>');
                $(code).click(function () {

                    var id = $(UserLink).attr('id');

                    if (userId != id) {
                        var ctrId = 'private_' + id;
                        OpenPrivateChatBox(chatHub, id, ctrId, name);

                    }

                });

            }

            $("#divusers").append(code);

            $("#ContactList").append(Clist);

        }

        function AddMessage(userName, message, time, userimg) {

            var CurrUser = $('#hdUserName').val();
            var Side = 'right';
            var TimeSide = 'left';

            if (CurrUser == userName) {
                Side = 'left';
                TimeSide = 'right';

            }

            var divChat = '<div class="direct-chat-msg ' + Side + '">' +
                '<div class="direct-chat-info clearfix">' +
                '<span class="direct-chat-name pull-' + Side + '">' + userName + '</span>' +
                '<span class="direct-chat-timestamp pull-' + TimeSide + '"">' + time + '</span>' +
                '</div>' +

                ' <img class="direct-chat-img" src="' + userimg + '" alt="Message User Image">' +
                ' <div class="direct-chat-text" >' + message + '</div> </div>';

            $('#divChatWindow').append(divChat);

            var height = $('#divChatWindow')[0].scrollHeight;
            $('#divChatWindow').slimScroll({
                height: height
            });

            ParseEmoji('#divChatWindow');

        }

        function OpenPrivateChatBox(chatHub, userId, ctrId, userName) {
            var PWClass = 'info';

            $('#PWCount').val(PWClass);
            var div1 = ' <div class="col-md-4"> <div  id="' + ctrId + '" class="box box-solid box-' + PWClass + ' direct-chat direct-chat-' + PWClass + '">' +
                '<div class="box-header with-border">' +
                ' <h3 class="box-title">' + userName + '</h3>' +

                ' <div class="box-tools pull-right">' +
                ' <span data-toggle="tooltip" id="MsgCountP" title="0 Novih poruka" class="badge bg-' + PWClass + '">0</span>' +
                ' <button type="button" class="btn btn-box-tool" data-widget="collapse">' +
                '    <i class="fa fa-minus"></i>' +
                '  </button>' +
                '  <button id="imgDelete" type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button></div>' +
                '  <img src="pics/pigeon.png" class="golub-image" alt="Golub">' +
                '</div>' +

                ' <div class="box-body">' +
                ' <div id="divMessage" class="direct-chat-messages">' +

                ' </div>' +

                '  </div>' +
                '  <div class="box-footer">' +

                '    <input type="text" id="txtPrivateMessage" name="message" placeholder="Ukucajte poruku ..." class="form-control"  />' +

                '  <div class="input-group">' +
                '    <input type="text" name="message" placeholder="Ukucajte poruku ..." class="form-control" style="visibility:hidden;" />' +
                '   <span class="input-group-btn">' +
                '          <input type="button" id="btnSendMessage" class="btn btn-' + PWClass + ' btn-flat" value="send" />' +
                '   </span>' +

                '  </div>' +

                ' </div>' +
                ' </div></div>';


            var $div = $(div1);
            $div.find('#imgDelete').click(function () {
                $('#' + ctrId).remove();
            });
            $div.find("#btnSendMessage").click(function () {
                $textBox = $div.find("#txtPrivateMessage");
                var msg = $textBox.val();
                if (msg.length > 0) {
                    chatHub.server.sendPrivateMessage(userId, msg);
                    $textBox.val('');
                }
            });
            $div.find("#txtPrivateMessage").keypress(function (e) {
                if (e.which == 13) {
                    $div.find("#btnSendMessage").click();
                }
            });
            $div.find("#divMessage").mouseover(function () {
                $("#MsgCountP").html('0');
                $("#MsgCountP").attr("title", '0 Novih poruka');
            });
            $('#PriChatDiv').append($div);
            var msgTextbox = $div.find("#txtPrivateMessage");
            $(msgTextbox).emojioneArea();
        }


    </script>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server" ></asp:ScriptManager>
        <div class="content-wrapper">

                   <header class="main-header" >
        <!-- Logo -->
        <a href="index2.html" class="logo">
          <!-- mini logo for sidebar mini 50x50 pixels -->
          
          <!-- logo for regular state and mobile devices -->
          <span class="logo-lg"><b>YU</b>chat</span>
        </a>
        <!-- Header Navbar: style can be found in header.less -->
        <nav class="navbar navbar-static-top" role="navigation">
          <!-- Sidebar toggle button-->
        
          <div class="navbar-custom-menu">
            <ul class="nav navbar-nav">
              <!-- Messages: style can be found in dropdown.less-->

              <!-- User Account: style can be found in dropdown.less -->
              <li class="dropdown user user-menu">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                  <img src="<%= UserImage %>" class="user-image" alt="User Image" />
                  <span class="hidden-xs"><%= this.UserName %></span>
                </a>
                <ul class="dropdown-menu">
                  <!-- User image -->
                  <li class="user-header" >
                    <img src="<%= UserImage %>" class="img-circle" alt="User Image" />
                    <p style="color:#000000;">
                      <%= UserName %>
                    </p>
                  </li>
                  <!-- Menu Footer-->
                  <li class="user-footer">
                    <div class="pull-left">
                      <a  class="btn btn-default btn-flat" data-toggle="modal" href="#ChangePic">Promijeni profilnu</a>
                    </div>
                    <div class="pull-right">
                        <asp:Button ID="btnSignOut" runat="server" CssClass="btn btn-default btn-flat" Text="Izloguj se" OnClick="btnSignOut_Click" />
                     <%-- <a href="#" class="btn btn-default btn-flat">Sign out</a>--%>
                    </div>
                  </li>
                </ul>
              </li>
              <!-- Control Sidebar Toggle Button -->

            </ul>
          </div>
        </nav>
      </header>

            <div class="row">

                <div class="col-md-8">
                    <!-- DIRECT CHAT PRIMARY -->
                    <div class="box box-primary direct-chat direct-chat-primary">
                       <div class="box-header with-border">
                            <h3 class="box-title" style="color:dimgrey;">Dobrodošli <span id='spanUser'></span></h3>
                           <div class="box-tools pull-right">
                               <button type="button" class="btn btn-box-tool" id="btnClearChat" data-toggle="tooltip" title="Clear Chat">
                                   <i class="fa fa-trash-o"></i>
                               </button>

                               <span data-toggle="tooltip" id="MsgCountMain" title="0 New Messages" class="badge bg-gray">0</span>
                           </div>
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <!-- Conversations are loaded here -->
                                    <div class="box-body" id="chat-box">
                                            <!-- Conversations are loaded here -->

                                            <div id="divChatWindow" class="direct-chat-messages" style="height: 450px;">
                                            </div>

                                            <div class="direct-chat-contacts">
                                                <ul class="contacts-list" id="ContactList">

                                                    <!-- End Contact Item -->
                                                </ul>
                                                <!-- /.contatcts-list -->
                                            </div>
                                            <!-- /.direct-chat-pane -->
                                     
                                            </div>

                        </div>
                        <!-- /.box-body -->
                        <div class="box-footer">

                            <textarea id="txtMessage" class="form-control" ></textarea>

                            <div class="input-group" style="float: right;">
                                <input class="form-control" style="visibility: hidden;" />
                                <span class="input-group-btn">
                                    <input type="button" class="btn btn-primary btn-flat" id="btnSendMsg" value="pošalji" />

                                </span>

                            </div>

                        </div>
                        <!-- /.box-footer-->
                    </div>
                    <!--/.direct-chat -->
                </div>
                <!-- /.col -->
                <div class="col-md-4">

                    <div class="box box-solid box-primary">

                        <div class="box-header with-border">
                            <h3 class="box-title">Online korisnici <span id='UserCount'></span></h3>
                        </div>

                        <div class="box-footer box-comments" id="divusers">
                        </div>

                    </div>



                </div>


                <div class="row">
                    <div class="col-md-12">
                        <div class="row" id="PriChatDiv">
                        </div>
                        <textarea class="form-control" style="visibility: hidden;"></textarea>




                        <!--/.private-chat -->
                    </div>
</div>

                
            </div>
            <!-- /.row -->
        </div>

        <span id="time"></span>
        <input id="hdId" type="hidden" />
        <input id="PWCount" type="hidden" value="info" />
        <input id="hdUserName" type="hidden" />

          <div class="modal fade" id="ChangePic" role="dialog">
        <div class="modal-dialog" style="width: 700px">
            <div class="modal-content">
                <div class="modal-header bg-light-blue-gradient with-border">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Promijeni profilnu</h4>
                </div>
                <div class="modal-body">
                    <div class="container">

                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                                   
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnChangePicModel" />
                        </Triggers>
                        <ContentTemplate>

                        <div class="row">
                            <div class="col-md-12">
                                <table class="table table-bordered table-striped table-hover table-responsive" style="width: 600px">

                                    <tr>

                                        <div class="col-md-12">
                                            <td class="text-primary col-md-4" style="font-weight: bold;">
                                                <img id="ImgDisp" src="" class="user-image" style="height: 100px;" />
                                            </td>
                                            <td class="text-primary col-md-4" style="font-weight: bold;">
                                                <asp:FileUpload ID="FileUpload1" runat="server" class="btn btn-default"/>
                                            </td>
                                            <td class="col-md-4">
                                                
                                              <asp:Button ID="btnChangePicModel" runat="server" Text="Promijeni Profilnu" CssClass="btn btn-flat btn-success" OnClick="btnChangePicModel_Click" />

                                                   
                                            </td>
                                        </div>

                                    </tr>


                                    <tr>
                                        <div class="col-md-12">

                                            <td class="col-md-12" colspan="4"></td>
                                        </div>

                                    </tr>


                                </table>
                            </div>
                        </div>

                    </div>
                </div>
                 </ContentTemplate>
                  </asp:UpdatePanel>
            </div>
        </div>
    </div>
            </div>
          </div>

        <div class="modal fade" id="ShowPictureModal" role="dialog">
            <div class="modal-dialog" style="width: 100%; max-width: 750px; min-width: 350px">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">&times;</button>
                    </div>
                    <div class="modal-body">
                        <div class="container">
                            <img id="ImgModal" src="Uploads/Chrysanthemum.jpg" class="user-image" style="max-width: 700px; min-width: 300px" />
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <style>
            .direct-chat .golub-image {
                position: absolute;
                top: 10px;
                right: 10px;
                width: 30px;
                height: 30px;
            }
            .main-header{
                background-color: #2c3e50; 
                color: #fff;
            }
            .box-header{
                background-color: #2c3e50; 
                color: #fff;
            }
            .upload-btn-wrapper {
                position: relative;
                overflow: hidden;
                display: inline-block;
                margin-top: 5px;
            }

                .upload-btn-wrapper input[type=file] {
                    font-size: 100px;
                    position: absolute;
                    left: 0;
                    top: 0;
                    opacity: 0;
                }

            .direct-chat-text img {
                width: 20px;
            }
        </style>

        <script src="Scripts/bootstrap.min.js"></script>
        <script>
            $(function () {
                $("#txtMessage").emojioneArea();

            });
        </script>

    </form>
</body>
</html>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="YUchat.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>YUchat : Login</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <link rel="icon" href="/pics/pigeon.png" type="image/x-icon">

    <style>
        body {
            background-color: #1a252f;
            color: #fff;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .login-box {
            width: 360px;
            background: #2c3e50;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.5);
            background-image: url('../pics/pigeon.png');
            background-repeat: repeat;
            background-position
        }

        .login-logo a {
            color: #fff;
            font-size: 36px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .login-box-body {
            color: #abb2bb;
            border-radius: 10px;
            box-shadow: 0px 0px 10px 0px rgba(0, 0, 0, 0.5);
        }

        .login-box-msg {
            margin: 0;
            text-align: center;
            padding: 0 20px 20px 20px;
            font-size: 18px;
        }

        .form-control {
            background: #3b4a57;
            border: none;
            color: #fff;
        }

        .form-control:focus {
            background: #3b4a57;
            color: #fff;
        }

        .btn-flat {
            border-radius: 5px;
        }

        .btn-success {
            background-color: #2c3e50;
            border-color: #2980b9;
        }

        .btn-primary {
            background-color: #2c3e50;
            border-color: #1c598a;
        }

        .glyphicon-envelope, .fa-lock {
            color: #ccc;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-box">
            <div class="login-logo">
                <a href="Login.aspx"><b>YU</b>chat</a>
            </div>
            <div class="login-box-body">
                <p class="login-box-msg">Ulogujte se da nastavite</p>
                <div class="form-group has-feedback">
                    <input type="email" id="txtEmail" class="form-control" placeholder="Email" required="required" runat="server" />
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input type="password" id="txtPassword" class="form-control" placeholder="Lozinka" required="required" runat="server" autocomplete="off" />
                    <span class="fa fa-lock form-control-feedback"></span>
                </div>
                <div class="row">
                    <div class="col-6 mx-auto">
                        <div class="d-flex align-items-center justify-content-evenly">
                            <div class="col-xs-5">
                                <asp:Button ID="btnSignIn" runat="server" OnClick="btnSignIn_Click" Text="Uloguj se" CssClass="btn btn-success btn-block btn-flat" /><br />
                            </div>
                            <div class="col-xs-6">
                                <a href="Register.aspx" class="btn btn-primary btn-block btn-flat">Registruj se</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</body>
</html>

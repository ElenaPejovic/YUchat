<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="YUchat.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>YUchat : Registracija</title>
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <link href="Content/icheck-bootstrap.css" rel="stylesheet" />
    <link href="Content/font-awesome.css" rel="stylesheet" />
    <link rel="icon" href="/pics/pigeon.png" type="image/x-icon">

    <style>
        body {
            background-color: #1a252f;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            height: 100vh; 
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('../pics/pigeon.png');
            background-repeat: repeat; 
            background-position: 15px 15px; 
        }

        .register-box {
            width: 360px;
            background: #2c3e50; 
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 20px 0px rgba(0, 0, 0, 0.5);
            width:auto;
            
        }

        .register-logo a {
            color: #fff;
            font-size: 36px;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.6);
        }

        .register-box-body {
            color: #abb2bb;
            width:auto;
            border-radius: 10px;
            box-shadow: 0px 0px 20px 0px rgba(0, 0, 0, 0.5);
        }

        .register-box-msg {
            margin: 0;
            text-align: center;
            padding: 0 20px 20px 20px;
            font-size: 18px;
            width:auto;
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
            border-radius: 10px;
            width:auto;
        }

        .btn-success {
            background-color: #3498db;
            border-color: #2980b9;
        }

        .btn-primary {
            background-color: #2980b9;
            border-color: #1c598a;
        }

        .glyphicon-envelope, .fa-lock {
            color: #ccc;
        }
        
    </style>
</head>
<body class="hold-transition">
    <form id="form1" runat="server">
        <div class="register-box">
            <div class="register-logo">
                <a href="Login.aspx"><b>YU</b>chat</a>
            </div>
            <div class="register-box-body">
                <p class="login-box-msg">Registrujte se</p>
                <div class="form-group has-feedback">
                    <input id="txtName" type="text" class="form-control" placeholder="Puno ime" required="required" runat="server">
                    <span class="glyphicon glyphicon-user form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input id="txtEmail" type="email" class="form-control" placeholder="Email" required="required" runat="server">
                    <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input id="txtPassword" type="password" class="form-control" placeholder="Lozinka" required="required" runat="server">
                    <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                </div>
                <div class="form-group has-feedback">
                    <input id="txtPasswordR" type="password" class="form-control" placeholder="Ponovo ukucajte lozinku" required="required" runat="server">
                    <span class="glyphicon glyphicon-log-in form-control-feedback"></span>
                </div>
                <div class="row">
                    <div class="col-xs-8">
                        <div class="checkbox icheck-primary">
                            <input type="checkbox" id="chkTerms" required="required" runat="server" /> 
                            <label for="chkTerms"></label>
                            <a href="#">Slažem se sa uslovima</a>
                        </div>
                    </div>
                    <div class="col-xs-4">
                        <button type="submit" class="btn btn-primary btn-block btn-flat" id="btnRegister" runat="server" onserverclick="btnRegister_ServerClick">Registruj se</button>
                    </div>
                </div>
                <a href="Login.aspx" class="text-center">Postojeći nalog</a>
            </div>
        </div>
    </form>
    <script src="Scripts/jquery-3.2.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
</body>
</html>

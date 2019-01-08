import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAS - Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

enum FormType {
  login,
  register
}

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _email = "";
  String _password = "";
  FormType _form = FormType.login;

  _LoginPageState() {
    _emailController.addListener(_emailListen);
    _passwordController.addListener(_passwordListen);
  }

  _emailListen() {
    if (_emailController.text.isEmpty) {
      _email = "";
    } else {
      _email = _emailController.text;
    }
  }
  _passwordListen() {
    if (_passwordController.text.isEmpty) {
      _password = "";
    } else {
      _password = _passwordController.text;
    }
  }

  _formChange() async {
    setState(() {
      if (_form == FormType.register) {
        _form = FormType.login;
      } else {
        _form = FormType.register;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBar(context),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            _buildTextFields(),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return AppBar(
      title: Text("AAS - Login"),
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          itemBuilder: (context) {
            return <PopupMenuEntry>[
              PopupMenuItem(
                child: Text("Helper"),
                value: "Helper",
              )
            ];
          },
          onSelected: (Widget) { //TODO: here
            _displayHelperDialog(context);
          },
        ),
      ],
    );
  }

  void _displayHelperDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Login - Helper"),
          content: Text("To login press the Login button."),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }


  Widget _buildTextFields() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: "Email"
              ),
            ),
          ),
          Container(
            child: TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                  labelText: "Password"
              ),
              obscureText: true,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtons() {
    if (_form == FormType.login) {
      return Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Login"),
              onPressed: _loginPressed,
            ),
            FlatButton(
              child: Text("Press here to register."),
              onPressed: _formChange,
            ),
            FlatButton(
                onPressed: _passwordReset,
                child: Text("Reset your password.")
            ),
          ],
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Create an Account"),
              onPressed: _createAccountPressed,
            ),
            FlatButton(
              onPressed: _formChange,
              child: Text("Already have an account? Click here to login."),
            ),
          ],
        ),
      );
    }
  }

  void _loginPressed() {
    print("Login with $_email and $_password");
  }

  void _createAccountPressed() {
    print("Create account with $_email and $_password");
  }

  void _passwordReset() {
    print("Reset password with $_email and $_password");
  }
}

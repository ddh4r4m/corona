import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:corona/widget/provider_widget.dart';
import 'package:corona/services/auth_service.dart';
import 'package:corona/services/authentication.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var divWidth;
  bool _autoValidate = false;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _firstNameTextController =
      new TextEditingController();
  final TextEditingController _emailTextController =
      new TextEditingController();
  final TextEditingController _lastNameTextController =
      new TextEditingController();
  final TextEditingController _phoneTextController =
      new TextEditingController();
  final TextEditingController _passwordTextController =
      new TextEditingController();
  var kMarginPadding = 16.0;
  var kFontSize = 13.0;
  String _email, _password, _name,_lastName ,_warning, _errorMessage;
  bool _isLoginForm = false;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _formKey,
              autovalidate: _autoValidate,
              child: Column(
                children: <Widget>[_buildEmailSignUpForm()],
              )),
        ),
      ),
//      appBar: AppBar(
//        leading: IconButton(
//            icon: Icon(
//              Icons.close,
//              color: Colors.blueGrey,
//            ),
//            onPressed: () {
//              Navigator.pop(context, false);
//            }),
//        backgroundColor: Colors.white,
//        elevation: 0.0,
//      ),
    );
  }

  Widget _buildEmailSignUpForm() {
    //Form 1
    return new Column(
      children: <Widget>[
        new Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Text('SignUp',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.w900)),
                Text('.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue))
              ],
            )),
        new Row(
          children: <Widget>[
            new Expanded(
                child: new Container(
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.only(left: kMarginPadding, right: 10.0),
                  child: new TextFormField(
                      style: new TextStyle(
                          fontSize: kFontSize, color: Colors.blueGrey),
                      controller: _firstNameTextController,
                      validator: _validateFields,
                      onSaved: (value) => _name = value,
                      decoration: InputDecoration(
                          labelText: "First Name*",
                          hintText: "Enter your first name",
                          labelStyle: new TextStyle(fontSize: kFontSize))),
                )),
            new Expanded(
                child: new Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: 10.0, right: kMarginPadding),
              child: new TextFormField(
                  style: new TextStyle(
                      fontSize: kFontSize, color: Colors.blueGrey),
                  controller: _lastNameTextController,
                  validator: _validateFields,
                  onSaved: (value) => _lastName = value,
                  decoration: InputDecoration(
                      labelText: "Last name",
                      hintText: "Enter your last name",
                      labelStyle: new TextStyle(fontSize: kFontSize))),
            ))
          ],
        ),
        SizedBox(
          height: 10.0,
        ),
        new Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
          child: new TextFormField(
              controller: _emailTextController,
              validator: _validateEmail,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => _email = value,
              decoration: InputDecoration(
                  labelText: "Email*",
                  hintText: "Enter your email",
                  labelStyle: new TextStyle(fontSize: 13))),
        ),
        SizedBox(
          height: 10.0,
        ),
        new Container(
          padding: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
          margin: EdgeInsets.only(left: 10.0, right: 10.0),
          child: new TextFormField(
              style: new TextStyle(fontSize: kFontSize, color: Colors.blueGrey),
              obscureText: true,
              controller: _passwordTextController,
              onSaved: (value) => _password = value,
              validator: (value) {
                if (value.length == 0) {
                  return "Password is not valid";
                } else if (value.length < 6) {
                  return "Please enter atleast 6 characters";
                } else {
                  return null;
                }
              },
              decoration: InputDecoration(
                  labelText: "Password*",
                  hintText: "Enter a password",
                  labelStyle: new TextStyle(fontSize: kFontSize))),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: new Center(
                child: ButtonTheme(
                  minWidth: 250,
                  child: RaisedButton(
                    elevation: 8,
                    textColor: Colors.white,
                    onPressed: () => _signUpButtonTaped(),
                    child: new Text("SignUp"),
                    color: Colors.lightBlue,
                  ),
            ))),
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: new Center(
                child: ButtonTheme(
                  minWidth: 250,
                  child: FlatButton(
                    textColor: Colors.blue,
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/LogIn'),
                    child: new Text("LogIn"),
                  ),
            ))),
      ],
    );
  }

  String _validateFields(String text) {
    if (text.length == 0) {
      return "Should not be empty";
    } else {
      return null;
    }
  }

  String _validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (regex.hasMatch(email))
      return null;
    else
      return "Please enter a valid email";
  }

  _signUpButtonTaped() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      //sign up user..
      final form = _formKey.currentState;
      form.save();
      validateAndSubmit();
    }
//    else {
//      setState(() {
//        _autoValidate = true;
//      });
//    }
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_formKey.currentState.validate()) {
      String userId = "";
      try {
        userId = await widget.auth.signUp(_email, _password);
        //widget.auth.sendEmailVerification();
        //_showVerifyEmailSentDialog();
        print('Signed up user: $userId');

        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }
  }


  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }
}

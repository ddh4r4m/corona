import 'package:flutter/material.dart';
import 'package:corona/services/auth_service.dart';
import 'package:corona/services/authentication.dart';
import 'package:corona/widget/provider_widget.dart';
import 'package:corona/views/SignUpScreen.dart';
class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var divWidth;
  bool _autoValidate = false;
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final TextEditingController _emailTextController =
      new TextEditingController();
  final TextEditingController _passwordTextController =
      new TextEditingController();
  var kMarginPadding = 16.0;
  var kFontSize = 13.0;
  String _email, _password, _name, _warning, _errorMessage;
  bool _victim;
  bool _isLoginForm = true;
  bool _isLoading;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    divWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body:Center(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Center(
                child: Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: <Widget>[_buildEmailSignUpForm()],
                    )),
              ),
            )
        ),
      )
//      appBar: AppBar(
//        backgroundColor: Colors.white,
//        elevation: 0.0,
//      ),
    );
  }

  Widget _buildForm() {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            child: Text('Hello',
                style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold)),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
              child: Row(
                children: <Widget>[
                  Text('There',
                      style: TextStyle(
                          fontSize: 80.0, fontWeight: FontWeight.w900)),
                  Text('.',
                      style: TextStyle(
                          fontSize: 80.0,
                          fontWeight: FontWeight.w900,
                          color: Colors.blue))
                ],
              )),
          Container(
              padding: EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  new TextFormField(
                      controller: _emailTextController,
                      validator: _validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (value) => _email = value,
                      decoration: InputDecoration(
                          labelText: "EMAIL*",
                          hintText: "Enter your email",
                          labelStyle: new TextStyle(fontSize: 13))),
                  SizedBox(height: 10.0),
                  new TextFormField(
                      style: new TextStyle(
                          fontSize: kMarginPadding, color: Colors.black38),
                      obscureText: true,
                      onSaved: (value) => _password = value,
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Please enter your password";
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordTextController,
                      decoration: InputDecoration(
                          labelText: "PASSWORD*",
                          hintText: "Enter a password",
                          labelStyle: new TextStyle(fontSize: kFontSize))),
                  SizedBox(height: 10.0),
                  TextField(
                    decoration: InputDecoration(
                        labelText: 'NICK NAME ',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue))),
                  ),
                  SizedBox(height: 50.0),
                  Container(
                      height: 40.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.lightBlueAccent,
                        color: Colors.blue,
                        elevation: 7.0,
                        child: GestureDetector(
//                          onTap: () {},
                          onTap: () => _loginButtonTapped(),
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      )),
                  SizedBox(height: 20.0),
                  Container(
                    height: 40.0,
                    color: Colors.transparent,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black,
                              style: BorderStyle.solid,
                              width: 1.0),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.0)),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Center(
                          child: Text('SIGN UP',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat')),
                        ),
                      ),
                    ),
                  ),
//                  SizedBox(
//                    height: 10.0,
//                  ),
//                  new RaisedButton(
//                    onPressed: () => _loginButtonTapped(),
//                    child: new Text("Login"),
//                  ),
                ],
              )),
          // SizedBox(height: 15.0),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: <Widget>[
          //     Text(
          //       'New to Spotify?',
          //       style: TextStyle(
          //         fontFamily: 'Montserrat',
          //       ),
          //     ),
          //     SizedBox(width: 5.0),
          //     InkWell(
          //       child: Text('Register',
          //           style: TextStyle(
          //               color: Colors.green,
          //               fontFamily: 'Montserrat',
          //               fontWeight: FontWeight.bold,
          //               decoration: TextDecoration.underline)),
          //     )
          //   ],
          // )
        ]);
  }


  Widget _buildEmailSignUpForm() {
    //Form 1
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
          child: Text('Hello',
              style: TextStyle(fontSize: 80.0, fontWeight: FontWeight.bold)),
        ),
        new Container(
            padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            child: Row(
              children: <Widget>[
                Text('There',
                    style:
                        TextStyle(fontSize: 80.0, fontWeight: FontWeight.w900)),
                Text('.',
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue))
              ],
            )),
        new Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
          child: new TextFormField(
              controller: _emailTextController,
              validator: _validateEmail,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => _email = value,
              decoration: InputDecoration(
                  labelText: "EMAIL*",
                  hintText: "Enter your email",
                  labelStyle: new TextStyle(fontSize: 13))),
        ),
        SizedBox(
          height: 10.0,
        ),
        new Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          margin: EdgeInsets.only(left: kMarginPadding, right: kMarginPadding),
          child: new TextFormField(
              style: new TextStyle(
                  fontSize: kMarginPadding, color: Colors.black38),
              obscureText: true,
              onSaved: (value) => _password = value,
              validator: (String value) {
                if (value.isEmpty) {
                  return "Please enter your password";
                } else {
                  return null;
                }
              },
              controller: _passwordTextController,
              decoration: InputDecoration(
                  labelText: "Password*",
                  hintText: "Enter a password",
                  labelStyle: new TextStyle(fontSize: kFontSize))),
        ),
        SizedBox(
          height: 30.0,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: new Center(
           child : ButtonTheme(
             minWidth: 250,
             child: RaisedButton(
               elevation: 10,
               textColor: Colors.white,
               onPressed: () => _loginButtonTapped(),
               child: new Text("Login"),
               color: Colors.lightBlue,
             ),
           )
        )),
        Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: new Center(
                child : ButtonTheme(
                  minWidth: 250,
                  child: FlatButton(
                    textColor: Colors.blue,
                    onPressed: () => Navigator.of(context).pushReplacementNamed('/SignUp'),
                    child: new Text("SignUp"),
                  ),
                )
            )),
//        new FlatButton(
//            onPressed: () {},
//            child: new Text(
//              'Forgot password',
//            )),
        SizedBox(
          height: 0,//EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        ),
      ],
    );
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

  _loginButtonTapped() {
    FocusScope.of(context).requestFocus(new FocusNode());
    if (_formKey.currentState.validate()) {
      final form = _formKey.currentState;
      form.save();
      validateAndSubmit();
//      try {
//        final auth = Provider.of(context).auth;
//        auth.signInWithEmailAndPassword(_email, _password);
//        Navigator.of(context).pushReplacementNamed('/HomeScreen');
//      } catch (e) {
//        print(e);
//        setState(() {
//          _warning = e.message;
//        });
//      }
    }
  }

  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (_formKey.currentState.validate()) {
      String userId = "";
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password,_name,_victim);
          //widget.auth.sendEmailVerification();
          //_showVerifyEmailSentDialog();
          print('Signed up user: $userId');
        }
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
}

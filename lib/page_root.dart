import 'package:flutter/material.dart';
import 'page_login.dart';
import 'page_auth.dart';
import 'page_home.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
  State<StatefulWidget> createState() => new RootPageState();
}

enum AuthStatus {
  notSignin,
  signin
}

class RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignin;

  @override
  void initState() {
    super.initState();
    widget.auth.currentUser().then((userId){
      setState(() {
        _authStatus = userId == null ? AuthStatus.notSignin : AuthStatus.signin;
      });
    });
  }

  void _signIn(){
    setState(() {
      _authStatus = AuthStatus.signin;
    });
  }

  void _signOut(){
    setState(() {
     _authStatus = AuthStatus.notSignin; 
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(_authStatus){
      case AuthStatus.notSignin:
        return new LoginPage(
          auth: widget.auth,
          onSignIn: _signIn,
        );
      case AuthStatus.signin:
        return new HomePage(
          auth: widget.auth,
          onsignOut: _signOut,
        );
    }
  }
}
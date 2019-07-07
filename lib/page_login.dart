import 'package:flutter/material.dart';
import 'page_auth.dart';

class LoginPage extends StatefulWidget{
  LoginPage({this.auth, this.onSignIn});
  final BaseAuth auth;
  final VoidCallback onSignIn;

  @override
  State<StatefulWidget> createState() => new LoginPageState();
}

enum FormType{
  login,
  register
}

class LoginPageState extends State<LoginPage>{
  final formKey = new GlobalKey<FormState>();
  String _username;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    } 
    return false;
  }

  void validateAndSubmit() async{
    if(validateAndSave()){
      try {
        if(_formType == FormType.login){
          String userId = await widget.auth.signInWithEmailAndPassword(_username, _password);
          print('Sign in: $userId');
        } else {
          String userId = await widget.auth.createUserWithEmailAndPassword(_username, _password);
          print('Sign up: $userId');
        }
        widget.onSignIn();
      } catch (e) {
        print('Username: $_username, Password: $_password');
        print('Error: $e');
      }
    }
  }

  void moveToRegister(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register; 
    });
  }

  void moveToLogin(){
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.login; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('MyApp'),
      ),
      body: new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: formKey,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buildInputs() + buildButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs(){
    return [
      new TextFormField(
        decoration: new InputDecoration(
          labelText: 'Username'
        ),
        validator: (value) => value.isEmpty ? 'Username can\'t be empty': null,
        onSaved: (value) => _username = value,
      ),
      new TextFormField(
        decoration: new InputDecoration(
          labelText: 'Password'
        ),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        obscureText: true,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildButtons(){
    if (_formType == FormType.login){
      return [
        new RaisedButton(
          child: new Text(
            'Login',
            style: new TextStyle(
              fontSize: 20.0
            ),
          ),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            'Don\'t Have an account? Register',
            style: new TextStyle(fontSize: 16.0),
          ),
          onPressed: moveToRegister,
        )
      ];
    } else {
      return [
        new RaisedButton(
          child: new Text(
            'Register',
            style: new TextStyle(
              fontSize: 20.0
            ),
          ),
          onPressed: validateAndSubmit,
        ),
        new FlatButton(
          child: new Text(
            'Have an account? Login',
            style: new TextStyle(fontSize: 16.0),
          ),
          onPressed: moveToLogin,
        )
      ];
    }
  }
}
import 'package:facebook_clone/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone/constants/constants.dart';
import 'package:facebook_clone/screens/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController= TextEditingController();
  bool isVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return isLoading ? Loading() : Material(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(top: height * .1),
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Facebook',
                style: TextStyle(
                  letterSpacing: .5,
                  color: Colors.indigoAccent,
                  fontWeight: FontWeight.bold,
                  fontSize:20
                )
              ),
               
              SizedBox(height:20),
              Text(
                'Connect with friends and stay safe',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height:10),
              Visibility(
                      visible: isVisible,
                      child: Text(
                        'Invalid email or password',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize:16
                        )
                      )
                    ),
              SizedBox(height:20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _textField(emailController, 'Email Address', emailValidator, false),
                    SizedBox(height:20),
                    _textField(passwordController, 'Password', passwordValidator, true),
                  ]
                )
              ),
              SizedBox(height:20),
              Text(
                'Sign to continue',
                style: TextStyle(
                  color: Colors.grey[400]
                ),
              ),
              SizedBox(height:40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _button(true, _submit, 'Sign in'),
                        _button(false, widget.toggleView, 'Register'),

                    ],)
                    
            ]
          ),
        ),
      ),
    );
  }
  _textField(TextEditingController controller, String label, Function validator, bool obscure){
    return TextFormField(
      obscureText: obscure,
      validator: validator,
      controller: controller,
      decoration: decoration.copyWith(
        labelText: label,
      )
    );
  }

  _submit() async{
      if(_formKey.currentState.validate()){
        setState(() {
          isLoading = !isLoading;
        });
        isVisible = false;
        dynamic result =  await _auth.signIn(emailController.text, passwordController.text);
        if (result == null){
          setState(() {
        isVisible = true;
         isLoading = !isLoading;
      });
        }
        
      }
    }

  
  _button(bool isSignIn, Function pressed, String text){
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      width: isSignIn ? width * .45 : width *.3,
      child: RaisedButton(
        color: isSignIn ? Colors.lightBlueAccent : Colors.blueGrey[900],
        onPressed: pressed,
        textColor: Colors.white,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16
          )
          ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )
        )
    );
  }

}
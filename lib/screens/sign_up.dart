import 'package:facebook_clone/screens/loading.dart';
import 'package:facebook_clone/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:facebook_clone/constants/constants.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  bool isVisible= false;
  bool isLoading = false;
  final AuthService _auth = AuthService();

  TextEditingController emailController= TextEditingController();
  TextEditingController nameController= TextEditingController();
  TextEditingController passwordController= TextEditingController();

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
                  letterSpacing: 0.5,
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
                        'Invalid email',
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
                    _textField(nameController, 'Name', nameValidator, false),
                    SizedBox(height:20),
                    _textField(emailController, 'Email Address', emailValidator, false),
                    SizedBox(height:20),
                    _textField(passwordController, 'Password', passwordValidator, true),
                  ]
                )
              ),
              SizedBox(height:20),
              Wrap(
                children: [
                  Text(
                  'By signing up you have accepted the ',
                  style: TextStyle(
                    color: Colors.grey[400]
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Text(
                    'Terms and',
                    style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                InkWell(
                  onTap: (){},
                  child: Text(
                    'conditions ',
                    style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.bold
                  ),
                  ),
                ),
                Text(
                  'of this service',
                  style: TextStyle(
                    color: Colors.grey[400]
                  ),
                ),
                ]
              ),
              SizedBox(height:40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _button(false, widget.toggleView, 'Sign in'),
                        _button(true, _submit, 'Register'),

                    ],),
                   
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
        dynamic result = await _auth.register(emailController.text, passwordController.text);
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
import 'package:flutter/material.dart';
import 'package:facebook_clone/constants/constants.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController;
  TextEditingController nameController;
  TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Material(
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
              SizedBox(height:20),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    _textField(emailController, 'Name', nameValidator),
                    SizedBox(height:20),
                    _textField(emailController, 'Email Address', emailValidator),
                    SizedBox(height:20),
                    _textField(passwordController, 'Password', passwordValidator),

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
              )
            ]
          ),
        ),
      ),
    );
  }

    _textField(TextEditingController controller, String label, Function validator){
    return TextFormField(
      validator: validator,
      controller: controller,
      decoration: decoration.copyWith(
        labelText: label,
      )
    );
    }

    submit(){
      if(_formKey.currentState.validate()){
        print('Success');
      }
    }

}
import 'package:flutter/material.dart';

Function emailValidator = (String val){
    if (val.isEmpty){
      return 'Enter email';
    }
    if (!val.contains('@')){
      return 'Invaid email';
    }
    return null;
  };
Function nameValidator = (String val){
    if (val.isEmpty){
      return 'Enter name';
    }
    return null;
  };

Function passwordValidator = (String val){
    if (val.isEmpty){
      return 'Enter password';
    }
    if (val.length <8){
      return 'Password must contain at least 8 characters';
    }
    return null;
  };

const decoration = InputDecoration(
        labelStyle: TextStyle(
          color: Colors.grey,
          fontSize:18
        )
      );

InputDecoration postDecoration = InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey
         ) ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: Colors.grey
          ),
        ),
        hintStyle: TextStyle(
          color: Colors.grey,
        )
      );
  
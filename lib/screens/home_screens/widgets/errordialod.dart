import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog{
  Showerrordialog(BuildContext context, String errorMessage){
    return SnackBar(
      content: Text(errorMessage,style: const TextStyle(
        fontSize: 16,
      ),),
      padding: const EdgeInsets.all(16),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    );
  }
}
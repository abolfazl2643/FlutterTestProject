import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minigram/views/Athentecation/singup.dart';
import 'package:minigram/views/home/home.dart';
import 'package:provider/provider.dart';

class wrapper extends StatefulWidget {
  @override
  _wrapperState createState() => _wrapperState();
}

class _wrapperState extends State<wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user!=null){
      return home();
    }else{
      return SignUp();
    }
  }
}

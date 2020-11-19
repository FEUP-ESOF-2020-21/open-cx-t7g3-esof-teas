import 'package:hello/pages/createConf.dart';

import '../pages/login.dart';
import '../pages/create_conference.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key,}) : super(key : key);

  @override
  Widget build(BuildContext context){
    final firebaseUser =  context.watch<User>();

    if(firebaseUser != null){
      return CreateConf();
    }
    return Login(title: "ScheduleIT");
  }
}
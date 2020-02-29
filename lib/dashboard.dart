import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/login.dart';


class DashboardScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: <Widget>[
          RaisedButton(
            child: Text('Log Out',style: TextStyle(fontSize: 18,color: Colors.white),),
            color: Colors.blue,
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          ),
        ],
      ),
      body: Container(
        child: Text('Welcome To Your Dashboard'),
      ),
    );
  }
  
}


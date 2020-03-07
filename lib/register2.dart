import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen2 extends StatefulWidget{
  @override
  _RegisterScreen2State createState() => _RegisterScreen2State();
}

class _RegisterScreen2State extends State<RegisterScreen2> {
    void initState()
  {
    super.initState();
  }


  final _formkey = GlobalKey<FormState>();

  TextEditingController _namecontroller = TextEditingController();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  TextEditingController _countrycontroller = TextEditingController();


  @override
  void dispose()
  {
    _namecontroller.dispose();

    _emailcontroller.dispose();

    _passwordcontroller.dispose();

    _countrycontroller.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Register 2 Full User'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _namecontroller,
                decoration: InputDecoration(
                  hintText: 'name',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please Fill name Input';
                  }
                  // return 'Valid Name';
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailcontroller,
                decoration: InputDecoration(
                  hintText: 'Email',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please Fill Email Input';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordcontroller,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please Fill Password Input';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _countrycontroller,
                decoration: InputDecoration(
                  hintText: 'Country',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please Fill Country Input';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Resgister Full User',style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  if(_formkey.currentState.validate()){
                    var result = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailcontroller.text, password: _passwordcontroller.text);
                    if(result != null)
                    {
                      Firestore.instance.collection('users').document(result.uid).setData({
                        'name':_namecontroller.text,
                        'country':_countrycontroller.text
                      });
                    }else{
                      print('please try later');
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
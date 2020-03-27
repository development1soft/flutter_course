import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/login.dart';


class AddPost extends StatefulWidget{
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  final FirebaseMessaging _fcm = FirebaseMessaging();
  
  void initState()
  {
    super.initState();

    updatePost("p3vjZpKzHL8mybS4aYoB");    

    _fcm.getToken().then((token){
      Firestore.instance.collection('tokens').add({
        'token':token
      });
    });

  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController _post_title = TextEditingController();

  TextEditingController _post_descripition = TextEditingController();

  @override
  void dispose()
  {
    _post_title.dispose();

    _post_descripition.dispose();

    super.dispose();
  }

  updatePost(String ID){
    Firestore.instance.collection('posts').document(ID).setData({
      'title':"Title Edited",
      'description':"Description Edited"
    }).then((value){
      print('record updated successflly');
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard / Add Post'),
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
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formkey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _post_title,
                decoration: InputDecoration(
                  hintText: 'Post Title',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please Fill Post Title Input';
                  }
                  // return 'Valid Name';
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                controller: _post_descripition,
                decoration: InputDecoration(
                  hintText: 'Description',
                ),
                validator: (value){
                  if(value.isEmpty){
                    return 'Please Fill Description Input';
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Add Post',style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  if(_formkey.currentState.validate()){

                    // add post
                    var current_user = await FirebaseAuth.instance.currentUser();
                    Firestore.instance.collection('posts').document().setData({
                      'post_title':_post_title.text,
                      'post_description' : _post_descripition.text,
                      'user':{
                        'uid':current_user.uid,
                        'email':current_user.email,
                      }
                    });
                  }
                },
              ),
              RaisedButton(
                color: Colors.blue,
                child: Text('Delete Post',style: TextStyle(color: Colors.white),),
                onPressed: () async{
                  if(_formkey.currentState.validate()){

                    // Delete post

                    Firestore.instance.collection('posts').document('hIbH9XJv5Fkt2YzN2wII').delete().then((onValue){
                      print('Post Deleted Successfully');
                    });


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


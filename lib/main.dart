import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_firebase_auth/auth.dart';
import 'package:provider/provider.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'auth.dart';

void main() => runApp(
  ChangeNotifierProvider<AuthService>(
    child: MyApp(),
     create: (BuildContext context) {
      return AuthService();
    },
  )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: Provider.of<AuthService>(context).getUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.error != null){
              print("Error");
              return Text(snapshot.error.toString());
            }
            return snapshot.hasData ? HomePage(snapshot.data) : LoginPage();
          }
          else{
            return LoadingCircle();
          }
        },
      ),
    );
  }
}

class LoadingCircle extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
      return Center(
        child: Container(
          child: CircularProgressIndicator(),
          alignment: Alignment(0.0, 0.0),
        ),
      );
  }
}



import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:jwt_login_register/services/api_service.dart';
import 'package:jwt_login_register/services/shared_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  SharedService.logout(context);
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.grey[200],
                ))
          ],
        ),
        backgroundColor: Colors.grey[200],
        body: userProfile());
  }

  Widget userProfile() {
    return FutureBuilder(
        future: APIservice.getUserProfile(),
        builder: (BuildContext context, AsyncSnapshot<String> model) {
          if (model.hasData) {
            return Center(
              child: Text(
                model.data!,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/local_db/UserDbModel.dart';
import 'package:mvvm/view_model/SplashViewmodel.dart';
import 'package:provider/provider.dart';

import '../objectbox.g.dart';
import '../utils/utils.dart';
import '../view_model/services/SplashServices.dart';
import 'HomeScreen.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  late Store _store;
  bool hasBeenInitialized = false;
  Box<UserModelDb>? userModelBox;

  @override
  void initState() {
    super.initState();

    openStore().then((Store store) {
      _store = store;
      userModelBox = store.box<UserModelDb>();

      splashServices.checkAuth(context).then((isLoggedIn) {

        Utils.log("isLoggedIn--> $isLoggedIn");

        if (isLoggedIn == true) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) =>
                    HomeScreen(userModelBox: userModelBox!)),
          );
        } else if (isLoggedIn == false) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) =>
                  LoginScreen(userModelBox: userModelBox!),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text("Splash Screen", style: Theme.of(context).textTheme.headline4,),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
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

  /* late Store _store;
  bool hasBeenInitialized = false;
  Box<UserModelDb>? userModelBox;*/

  @override
  void initState() {
    super.initState();

    splashServices.checkAuth(context).then((isLoggedIn) {
      Utils.log("isLoggedIn--> $isLoggedIn");

      if (isLoggedIn == true) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => HomeScreen(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      } else if (isLoggedIn == false) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => LoginScreen(),
          ),
          (route) => false, //if you want to disable back feature set to false
        );
      }
    });

    /* openStore().then((Store store) {
      _store = store;
      userModelBox = store.box<UserModelDb>();

      splashServices.checkAuth(context).then((isLoggedIn) {
        Utils.log("isLoggedIn--> $isLoggedIn");

        if (isLoggedIn == true) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
                builder: (BuildContext context) => HomeScreen()),
          );
        } else if (isLoggedIn == false) {
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => LoginScreen(),
            ),
          );
        }
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "Splash Screen",
                style: Theme.of(context).textTheme.headline4,
              ),
            )
          ],
        ),
      ),
    );
  }
}

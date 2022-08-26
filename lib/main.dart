import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/Routes.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:mvvm/view/LoginScreen.dart';
import 'package:mvvm/view_model/AuthViewmodel.dart';
import 'package:mvvm/view_model/SplashViewmodel.dart';
import 'package:mvvm/view_model/UserViewmodel.dart';
import 'package:provider/provider.dart';

import 'data/local_db/UserDbModel.dart';
import 'objectbox.g.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}


class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MainScreen> {

  late Store _store;
  bool hasBeenInitialized = false;
  late Box<UserModelDb> userModelBox;

  @override
  void initState() {
    super.initState();

    openStore().then((Store store) {
      _store = store;
      userModelBox = store.box<UserModelDb>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
          ChangeNotifierProvider(create: (_) => SplashViewModel())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primarySwatch: Colors.blue,
          ),
          home: LoginScreen(userModelBox: userModelBox),
          initialRoute: RoutesName.splash,
          onGenerateRoute: (settings) {
            Routes.generateRoute(settings, userModelBox);
          },
        ));
  }
}


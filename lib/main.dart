import 'package:flutter/material.dart';
import 'package:mvvm/repository/AuthRepository.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:mvvm/view/HomeScreen.dart';
import 'package:mvvm/view/LoginScreen.dart';
import 'package:mvvm/view/SignUpScreen.dart';
import 'package:mvvm/view/SplashScreen.dart';
import 'package:mvvm/view_model/AuthViewmodel.dart';
import 'package:mvvm/view_model/UserViewmodel.dart';
import 'package:provider/provider.dart';
import 'data/local_db/UserDbModel.dart';
import 'data/network/NetworkApiService.dart';
import 'objectbox.g.dart';

/*void main() {
  runApp(const MyApp());
}*/

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
  bool hasBeenInitialized = false;
  late Box<UserModelDb> userModelBox;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
/*
        home: const SplashScreen(),
*/
        initialRoute: RoutesName.splash,
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          RoutesName.splash: (context) => SplashScreen(),
          RoutesName.home: (context) => HomeScreen(),
          RoutesName.login: (context) => LoginScreen(),
          RoutesName.signup: (context) => SignUpScreen()
        });
  }
}

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  openStore().then((Store store) {
    final userViewModel = UserViewModel();
    final authViewModel = AuthViewModel(
      authRepo: AuthRepository(
          apiService: NetworkApiService(),
          userModelBox: store.box<UserModelDb>()),
    );

    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider<UserViewModel>.value(value: userViewModel),
          ChangeNotifierProvider<AuthViewModel>.value(value: authViewModel),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:
              MyApp()
          ,
        )));
  });
}

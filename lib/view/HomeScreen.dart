import 'package:flutter/material.dart';
import 'package:mvvm/data/local_db/UserDbModel.dart';
import 'package:mvvm/view/LoginScreen.dart';
import 'package:mvvm/view_model/AuthViewmodel.dart';
import 'package:mvvm/view_model/UserViewmodel.dart';
import 'package:provider/provider.dart';

import '../res/components/RoundButton.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);

      authViewModel.getToken();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text("Token = ${authViewModel.savedToken}"),
              Center(
                child: RoundButton(
                  title: "Logout",
                  onPress: () {
                    userPreferences.removeUserToken().then((value) {
                      /* Navigator.pushNamed(context, RoutesName.login);*/
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                            builder: (BuildContext context) => LoginScreen()),
                      );
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

/*@override
  void dispose() {
    super.dispose();
    */ /*_store.close();*/ /*
  }*/
}

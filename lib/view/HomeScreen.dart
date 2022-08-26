import 'package:flutter/material.dart';
import 'package:mvvm/data/local_db/UserDbModel.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
import 'package:mvvm/view/LoginScreen.dart';
import 'package:mvvm/view_model/UserViewmodel.dart';
import 'package:provider/provider.dart';

import '../objectbox.g.dart';
import '../res/components/RoundButton.dart';
import '../utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.userModelBox}) : super(key: key);

  final Box<UserModelDb> userModelBox;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text("Token = ${getUserToken()}"),
            Center(
              child: RoundButton(
                title: "Logout",
                onPress: () {
                  userPreferences.removeUserToken().then((value) {
                   /* Navigator.pushNamed(context, RoutesName.login);*/
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              LoginScreen(userModelBox: widget.userModelBox)),
                    );
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  String? getUserToken() {
    List<UserModelDb>? listOfUserModel =
        widget.userModelBox.getAll().reversed.toList() ?? [];

    Utils.log("Token is = ${listOfUserModel.first.token}");

    return listOfUserModel.first.token;
  }

  @override
  void dispose() {
    super.dispose();
    /*_store.close();*/
  }
}

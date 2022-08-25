import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/RoutesName.dart';
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
  Widget build(BuildContext context) {
    final userPreferences = Provider.of<UserViewModel>(context);

    userPreferences.getUserToken().then((value) async {
      Utils.log("Token -> ${value.token.toString()}");
    });

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: RoundButton(
                title: "Logout",
                onPress: () {
                  userPreferences.removeUserToken().then((value) {
                    Navigator.pushNamed(context, RoutesName.login);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

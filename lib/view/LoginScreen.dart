import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/data/local_db/UserDbModel.dart';
import 'package:mvvm/res/components/RoundButton.dart';
import 'package:mvvm/view_model/AuthViewmodel.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../objectbox.g.dart';
import '../res/components/CustomTextButton.dart';
import '../utils/routes/RoutesName.dart';
import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.userModelBox}) : super(key: key);

  final Box<UserModelDb>? userModelBox;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier _obsecurePassword = ValueNotifier(true);

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              focusNode: emailNode,
              decoration: const InputDecoration(
                  hintText: "Email", prefixIcon: Icon(Icons.alternate_email)),
              controller: _emailController,
              onFieldSubmitted: (value) {
                Utils.changeFocusNode(context, emailNode, passwordNode);
              },
            ),
            ValueListenableBuilder(
                valueListenable: _obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    obscureText: value,
                    focusNode: passwordNode,
                    obscuringCharacter: "@",
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password),
                        suffixIcon: InkWell(
                            onTap: () {
                              _obsecurePassword.value =
                                  !_obsecurePassword.value;
                            },
                            child: Icon(_obsecurePassword.value
                                ? Icons.visibility_off
                                : Icons.visibility))),
                    controller: _passwordController,
                  );
                }),
            SizedBox(
              height: height * .07,
            ),
            RoundButton(
                title: "Login",
                isLoading: authViewModel.isLoginApiLoading,
                onPress: () {
                  if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter the email.", context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Please enter the password.", context);
                  } else if (_passwordController.text.length < 6) {
                    Utils.flushBarErrorMessage(
                        "Password is too small.", context);
                  } else {
                    /*Map data = {
                      "email": _emailController.text.toString(),
                      "password": _passwordController.text.toString(),
                    };*/
                    Map data = {
                      "email": "eve.holt@reqres.in",
                      "password": "cityslicka",
                    };

                    authViewModel.login(
                      data,
                      context,
                      widget.userModelBox!,
                    );
                  }
                }),
            SizedBox(
              height: height * .03,
            ),
            CustomTextButton(
                title: "Don't have an account? Sign up",
                onPress: () {
                  Navigator.pushNamed(context, RoutesName.signup);
                })
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    emailNode.dispose();
    passwordNode.dispose();
    /* _store.close();*/
  }
}

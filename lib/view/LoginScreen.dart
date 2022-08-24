import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/components/RoundButton.dart';

import '../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
    final height = MediaQuery.of(context).size.height*1;

    return Scaffold(
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
            SizedBox(height: height*.1,),
            RoundButton(title: "Login", onPress: (){

            })
          ],
        ),
      ),
    );
  }
}

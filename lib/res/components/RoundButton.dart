import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/res/Colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final VoidCallback onPress;

  const RoundButton(
      {Key? key,
      required this.title,
      this.isLoading = false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 200,
        decoration: BoxDecoration(
          color: AppColors.blackColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
            child: Text(
          title,
          style: TextStyle(color: AppColors.whiteColor),
        )),
      ),
    );
  }
}

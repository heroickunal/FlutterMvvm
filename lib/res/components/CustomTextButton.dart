import 'package:flutter/material.dart';
import 'package:mvvm/res/Colors.dart';

class CustomTextButton extends StatelessWidget {
  final String title;
  final bool isLoading;
  final VoidCallback onPress;

  const CustomTextButton(
      {Key? key,
      required this.title,
      this.isLoading = false,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: AppColors.whiteColor,
                )
              : Text(
                  title,
                  style: const TextStyle(color: AppColors.blackColor),
                )),
    );
  }
}

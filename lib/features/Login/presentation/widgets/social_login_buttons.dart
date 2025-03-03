import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: Image.asset(AssetsData.google),
        ),
        SizedBox(
          width: 16,
        ),
        IconButton(
          onPressed: () {},
          icon: Image.asset(AssetsData.face),
        ),
      ],
    );
  }
}

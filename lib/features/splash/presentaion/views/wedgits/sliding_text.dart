import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/assets.dart';
import 'package:flutter/material.dart';

class SlidingImage extends StatelessWidget {
  const SlidingImage({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slidingAnimation,
      builder: (context, _) {
        return SlideTransition(
          position: slidingAnimation,
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return kButtonColor.createShader(bounds);
            },
            child: Image.asset(
              AssetsData.sliding,
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}

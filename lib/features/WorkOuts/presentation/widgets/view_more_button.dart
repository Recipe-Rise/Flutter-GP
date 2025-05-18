import 'package:flutter/material.dart';

import '../../../../core/utils/styles.dart';

class ViewMoreButton extends StatelessWidget {
  const ViewMoreButton({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.025,
        vertical: size.height * 0.010,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(size.width * 0.04),
      ),
      child: Text('View more',
          style: Styles.textStyle14.copyWith(color: Colors.blue)),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/styles.dart';
import '../views/workout_screen.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.04,
        size.height * 0.02,
        size.width * 0.04,
        0,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomIconButton(
                icon: Icons.chevron_left,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const WorkoutsScreen(),
                    ),
                  );
                },
              ),
              Text('Full Body Workout',
                  style:
                  Styles.textStyle22.copyWith(fontWeight: FontWeight.bold)),
              CustomIconButton(
                icon: Icons.more_horiz,
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: size.height * 0.020),
          Center(
            child: SvgPicture.asset(
              AssetsData.full_body,
              height: size.height * 0.25,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: size.height * 0.025,
          )
        ],
      ),
    );
  }
}
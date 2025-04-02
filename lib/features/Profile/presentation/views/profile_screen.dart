import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_bottom_nav_bar.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_header.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_menu_section.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_stats_section.dart';
import 'package:fitfork_gp/features/Register/presentation/cubit/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        final registerData = context.read<RegisterCubit>().registerData;
        final bmi = context.read<RegisterCubit>().calculateBMI();
        final bmr = context.read<RegisterCubit>().calculateBMR();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
            centerTitle: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () {},
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                  ),
                  ProfileHeader(userData: registerData),
                  const SizedBox(height: 32),
                  ProfileStatsSection(
                      userData: registerData, bmi: bmi, bmr: bmr),
                  const SizedBox(height: 50),
                  const ProfileMenuSection(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const ProfileBottomNavBar(selectedIndex: 3),
        );
      },
    );
  }
}

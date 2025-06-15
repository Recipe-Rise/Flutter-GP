import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fitfork_gp/features/Profile/presentation/cubit/cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Login/presentation/views/login_screen.dart';
import '../widgets/quick_action_item.dart';


void sendEmail(String message) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: 'paula3del@gmail.com',
    query: 'subject=Contact Us&body=$message',
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    print('Error: Could not launch email client');
  }
}


class AppSettingsScreen extends StatelessWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            QuickActionItem(
              icon: Icons.logout,
              label: 'Logout',
              iconColor: Colors.red,
              backgroundColor: const Color(0xFFFFF0F0),
              onTap: (){
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route<dynamic> route) => false, // This removes all previous routes
                );
              },
            ),


            QuickActionItem(
              icon: Icons.mail,
              label: 'Contact Us',
              iconColor: Colors.blue,
              backgroundColor: const Color(0xFFE0F7FA),
              onTap: () {
                showContactUsDialog(context);
              },
            ),


            // ElevatedButton.icon(
            //   onPressed: () {
            //     ProfileCubit.get(context).LogOut();
            //     Fluttertoast.showToast(
            //       msg: 'Logged out successfully!',
            //       toastLength: Toast.LENGTH_SHORT,
            //       gravity: ToastGravity.BOTTOM,
            //       backgroundColor: Colors.green,
            //       textColor: Colors.white,
            //       fontSize: 16.0,
            //     );
            //   },
            //   icon: const Icon(Icons.logout),
            //   label: const Text('Logout'),
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.red,
            //     foregroundColor: Colors.white,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

void showContactUsDialog(BuildContext context) {
  final TextEditingController messageController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage('assets/images/IMG_0830.jpg'),
            ),
            const SizedBox(width: 10),
            const Text('Contact Us'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Send a message to Bavley Adel:'),
            const SizedBox(height: 10),
            TextField(
              controller: messageController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Type your message here...',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              sendEmail(messageController.text);
              Navigator.of(context).pop();
            },
            child: const Text('Send'),
          ),
        ],
      );
    },
  );
}

// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:dio/dio.dart';
// import 'package:fitfork_gp/constants.dart';
// import 'package:fitfork_gp/core/utils/app_navigator.dart';
// import 'package:fitfork_gp/features/Profile/presentation/views/edit_profile_screen.dart';
// import 'package:fitfork_gp/features/Profile/presentation/widgets/basal_mtabolic_rate_card.dart';
// import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_app_bar.dart';
// import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_avatar.dart';
// import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_info_card.dart';
// import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_name.dart';
// import 'package:fitfork_gp/features/Profile/presentation/widgets/quick_actions_section.dart';
// import 'package:fitfork_gp/shared/cubit/appCubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:generative_ai_dart/generative_ai_dart.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../../../Login/presentation/views/login_screen.dart';
// import '../cubit/cubit.dart';
// import '../cubit/states.dart';
// import 'package:http_parser/http_parser.dart';
//
//
// class ProfileScreen2 extends StatefulWidget {
//   const ProfileScreen2({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen2> createState() => _ProfileScreen2State();
// }
//
// class _ProfileScreen2State extends State<ProfileScreen2> {
//
//
//   File? _imageFile;
//   Uint8List? _imageBytes;
//   String? _imageUrl;
//
//   final ImagePicker _picker = ImagePicker();
//   final Dio _dio = Dio();
//
//
//   @override
//   void initState() {
//     super.initState();
//     ProfileCubit.get(context).GetAllUserData();
//     _fetchUserImage();
//   }
//
//   Future<void> _fetchUserImage() async {
//     try {
//       final response = await _dio.get(
//         'http://10.0.2.2:5000/user/get_image/$user_id',
//         options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           validateStatus: (status) => status != null && status < 500,
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         setState(() {
//           _imageBytes = Uint8List.fromList(response.data);
//         });
//       } else {
//         print('Failed to fetch image. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error fetching image: $e');
//     }
//   }
//
//
//   // Future<void> _fetchUserImage() async {
//   //   try {
//   //     final response = await _dio.get(
//   //         'http://10.0.2.2:5000/user/get_image/$user_id',
//   //         options: Options(
//   //             responseType: ResponseType.bytes,
//   //         ),
//   //     );
//   //     if (response.statusCode == 200) {
//   //       setState(() {
//   //         // _imageUrl = null;
//   //         // _imageFile = File.fromRawPath(response.data);
//   //         _imageBytes = Uint8List.fromList(response.data);// Assuming the API returns the image URL
//   //       });
//   //     } else {
//   //       throw Exception('Failed to load image');
//   //     }
//   //   } catch (e) {
//   //     print('Error fetching image: $e');
//   //   }
//   // }
//
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path);
//         _imageBytes = null;
//       });
//     }
//   }
//
//   Future<void> _uploadImage() async {
//     if (_imageFile == null) return;
//
//     try {
//       final fileName = _imageFile!.path.split('/').last;
//
//       final formData = FormData.fromMap({
//         'image': await MultipartFile.fromFile(
//           _imageFile!.path,
//           filename: fileName,
//           contentType: MediaType('image', fileName.endsWith('.png') ? 'png' : 'jpeg'),
//         ),
//       });
//
//       final response = await _dio.post(
//         'http://10.0.2.2:5000/user/image_upload/$user_id',
//         data: formData,
//         options: Options(
//           contentType: 'multipart/form-data',
//         ),
//       );
//
//       if (response.statusCode == 200) {
//         print('Image uploaded successfully');
//         _fetchUserImage();
//       } else {
//         print('Upload failed: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error uploading image: $e');
//     }
//   }
//
//
//   // Future<void> _uploadImage() async {
//   //   if (_imageFile == null) return;
//   //
//   //   try {
//   //     final formData = FormData.fromMap({
//   //       'image': await MultipartFile.fromFile(_imageFile!.path),
//   //     });
//   //
//   //     final response = await _dio.post(
//   //       'http://10.0.2.2:5000/user/image_upload/$user_id',
//   //       data: formData,
//   //     );
//   //
//   //     if (response.statusCode == 200) {
//   //       print('Image uploaded successfully');
//   //       _fetchUserImage(); // Refresh the image after upload
//   //     } else {
//   //       throw Exception('Failed to upload image');
//   //     }
//   //   } catch (e) {
//   //     print('Error uploading image: $e');
//   //   }
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProfileCubit, ProfileStates>(
//       listener: (context, state) {
//         if (state is ProfileLogoutSuccessState){
//           Navigator.pushAndRemoveUntil(context,
//               MaterialPageRoute(builder : (context)=> LoginScreen()),
//                   (Route<dynamic> route) => false);
//           Fluttertoast.showToast(
//               msg: state.logoutModel.message!,
//               toastLength: Toast.LENGTH_LONG,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIosWeb: 5,
//               backgroundColor: Colors.green,
//               textColor: Colors.white,
//               fontSize: 16.0
//           );
//         }
//         else if (state is ProfileUpdateSuccessState) {
//           Fluttertoast.showToast(
//             msg: 'Profile updated successfully!',
//             toastLength: Toast.LENGTH_LONG,
//             gravity: ToastGravity.BOTTOM,
//             backgroundColor: Colors.green,
//             textColor: Colors.white,
//             fontSize: 16.0,
//           );
//         }
//       },
//       builder: (context, state) {
//
//         final userData = ProfileCubit.get(context).getUserData;
//
//         return Scaffold(
//           backgroundColor: const Color(0xFFF2F2F2),
//           body: SafeArea(
//             child: Column(
//               children: [
//                 const ProfileAppBar(),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Column(
//                         children: [
//                           const SizedBox(height: 20),
//
//                           Center(
//                             child: CircleAvatar(
//                               radius: 60,
//                               backgroundImage: _imageFile != null
//                                   ? FileImage(_imageFile!)
//                                   : _imageBytes != null
//                                   ? MemoryImage(_imageBytes!)
//                                   : null,
//                               child: _imageFile == null && _imageBytes == null
//                                   ? const Icon(Icons.person, size: 60, color: Colors.white)
//                                   : null,
//                               backgroundColor: Colors.grey[300],
//                             ),
//                           ),
//
//                           const SizedBox(height: 16),
//                           ElevatedButton.icon(
//                             onPressed: () => _pickImage(ImageSource.gallery),
//                             icon: const Icon(Icons.photo_library),
//                             label: const Text('Choose from Gallery'),
//                           ),
//                           ElevatedButton.icon(
//                             onPressed: () => _pickImage(ImageSource.camera),
//                             icon: const Icon(Icons.camera_alt),
//                             label: const Text('Take a Photo'),
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton(
//                             onPressed: _uploadImage,
//                             child: const Text('Upload Image'),
//                           ),
//
//                           // ProfileAvatar(gender: userData?.gender ?? 'Unknown'),
//
//                           const SizedBox(height: 16),
//                           ProfileName(name: userData?.name ?? 'Unknown'),
//                           const SizedBox(height: 20),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ProfileInfoCard(
//                                   title: 'Age',
//                                   value: '${userData?.age ?? 0} years',
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: ProfileInfoCard(
//                                   title: 'Weight',
//                                   value: '${userData?.weight ?? 0} kg',
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: ProfileInfoCard(
//                                   title: 'Height',
//                                   value: '${userData?.height ?? 0} cm',
//                                 ),
//                               ),
//                               const SizedBox(width: 16),
//                               Expanded(
//                                 child: ProfileInfoCard(
//                                   title: 'BMI',
//                                   value:
//                                   (double.parse(userData?.bmi ?? '0')).toStringAsFixed(1),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: 16),
//                           BasalMetabolicRateCard(
//                             value:
//                             '${double.parse(userData?.bmr ?? '0').toStringAsFixed(0)} kcal/day',
//                             description:
//                             'The amount of energy you need while resting',
//                           ),
//                           const SizedBox(height: 16),
//                           const QuickActionsSection(),
//                           const SizedBox(height: 24),
//                           CustomGradientButton(
//                             text: 'Edit Profile',
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => EditProfileScreen(
//                                     profileData: {
//                                       'name': userData?.name,
//                                       'email': userData?.email,
//                                       'age': userData?.age,
//                                       'weight': userData?.weight,
//                                       'height': userData?.height,
//                                       'fitness_goal': userData?.fitness_goal,
//                                       'gender': userData?.gender,
//                                       'activity_level': userData?.activity_level,
//                                     },
//                                   ),
//                                 ),
//                               );
//                               ProfileCubit.get(context).GetAllUserData();
//                             },
//                             gradient: kButtonColor,
//                             width: double.infinity,
//                             height: 60,
//                             borderRadius: 32,
//                             icon: Icons.edit_outlined,
//                           ),
//                           const SizedBox(height: 24),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             backgroundColor: Colors.white,
//             elevation: 8,
//             selectedItemColor: const Color(0xFF4da0ff),
//             unselectedItemColor: Colors.grey,
//             currentIndex: 4, // Profile tab is index 4
//             onTap: (index) {
//               if (index != 4) {
//                 AppNavigator.navigateToTabScreen(context, index);
//               }
//             },
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.dumbbell),
//                 label: 'Workouts',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.message),
//                 label: 'Chatbot',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.utensils),
//                 label: 'Recipes',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(FontAwesomeIcons.user),
//                 label: 'Profile',
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
//
// class CustomGradientButton extends StatelessWidget {
//   final String text;
//   final VoidCallback? onPressed;
//   final Gradient gradient;
//   final double width;
//   final double height;
//   final double borderRadius;
//   final IconData? icon;
//
//   const CustomGradientButton({
//     super.key,
//     required this.text,
//     this.onPressed,
//     required this.gradient,
//     this.width = 280,
//     this.height = 60,
//     this.borderRadius = 32,
//     this.icon,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onPressed,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 16),
//         child: Container(
//           width: width,
//           height: height,
//           decoration: BoxDecoration(
//             gradient: gradient,
//             borderRadius: BorderRadius.circular(borderRadius),
//           ),
//           child: Center(
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 if (icon != null)
//                   Padding(
//                     padding: const EdgeInsets.only(right: 8),
//                     child: Icon(icon, color: Colors.white),
//                   ),
//                 Text(
//                   text,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: onPressed != null
//                         ? Colors.white
//                         : Colors.white.withOpacity(0.6),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'dart:typed_data';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fitfork_gp/constants.dart';
import 'package:fitfork_gp/core/utils/app_navigator.dart';
import 'package:fitfork_gp/core/utils/styles.dart';
import 'package:fitfork_gp/features/Profile/presentation/views/edit_profile_screen.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/basal_mtabolic_rate_card.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_app_bar.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_avatar.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_info_card.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/profile_name.dart';
import 'package:fitfork_gp/features/Profile/presentation/widgets/quick_actions_section.dart';
import 'package:fitfork_gp/shared/cubit/appCubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:generative_ai_dart/generative_ai_dart.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Login/presentation/views/login_screen.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import 'package:http_parser/http_parser.dart';

class ProfileScreen2 extends StatefulWidget {
  const ProfileScreen2({Key? key}) : super(key: key);

  @override
  State<ProfileScreen2> createState() => _ProfileScreen2State();
}

class _ProfileScreen2State extends State<ProfileScreen2> {
  File? _imageFile;
  Uint8List? _imageBytes;
  String? _imageUrl;
  bool _isLoadingImage = false;
  bool _isUploadingImage = false;

  final ImagePicker _picker = ImagePicker();
  late Dio _dio;

  @override
  void initState() {
    super.initState();
    _initializeDio();
    ProfileCubit.get(context).GetAllUserData();
    _fetchUserImage();
  }

  void _initializeDio() {
    _dio = Dio();

    _dio.options.connectTimeout = Duration(seconds: 30);
    _dio.options.receiveTimeout = Duration(seconds: 60);
    _dio.options.sendTimeout = Duration(seconds: 60);

    _dio.interceptors.add(LogInterceptor(
      requestBody: false,
      responseBody: false,
      logPrint: (o) => print('DIO LOG: $o'),
    ));
  }

  Future<void> _fetchUserImage() async {
    setState(() {
      _isLoadingImage = true;
    });

    int maxRetries = 3;
    int currentRetry = 0;

    while (currentRetry < maxRetries) {
      try {
        final response = await _dio.get(
          'https://recipe-rise.azurewebsites.net/user/get_image/$user_id',
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            validateStatus: (status) => status != null && status < 500,
            headers: {
              'Accept': 'image/*',
              'Connection': 'keep-alive',
            },
          ),
        );

        if (response.statusCode == 200 && response.data != null) {
          setState(() {
            _imageBytes = Uint8List.fromList(response.data);
            _isLoadingImage = false;
          });
          print('Image fetched successfully');
          return; // Success, exit the retry loop

        }
        else if (response.statusCode == 404) {
          setState(() {
            _imageBytes = null; // No image found, show default icon
          });
          print('No image found for user');
          break;
        }

        else {
          print('Failed to fetch image. Status code: ${response.statusCode}');
        }
      } on DioException catch (dioError) {
        currentRetry++;
        print('Dio error fetching image (attempt $currentRetry): ${dioError.type} - ${dioError.message}');

        if (dioError.response != null) {
          print('Response status: ${dioError.response?.statusCode}');
          print('Response data: ${dioError.response?.data}');
        }

        if (currentRetry < maxRetries) {
          // Exponential backoff: wait 2^currentRetry seconds
          await Future.delayed(Duration(seconds: pow(2, currentRetry).toInt()));
        } else {
          print('All retry attempts failed for image fetch');
        }
      } catch (e) {
        currentRetry++;
        print('General error fetching image (attempt $currentRetry): $e');

        if (currentRetry < maxRetries) {
          await Future.delayed(Duration(seconds: pow(2, currentRetry).toInt()));
        } else {
          print('All retry attempts failed for image fetch');
        }
      }
    }

    setState(() {
      _isLoadingImage = false;
    });
  }

  // Alternative method using HTTP client as fallback
  Future<void> _fetchUserImageWithHttpClient() async {
    setState(() {
      _isLoadingImage = true;
    });

    try {
      final httpClient = HttpClient();

      // Configure timeout
      httpClient.connectionTimeout = Duration(seconds: 30);
      httpClient.idleTimeout = Duration(seconds: 30);

      final request = await httpClient.getUrl(
          Uri.parse('http://10.0.2.2:5000/user/get_image/$user_id')
      );

      request.headers.set('Accept', 'image/*');

      final response = await request.close();

      if (response.statusCode == 200) {
        final bytes = await consolidateHttpClientResponseBytes(response);
        setState(() {
          _imageBytes = bytes;
          _isLoadingImage = false;
        });
        print('Image fetched successfully with HTTP client');
      } else {
        print('HTTP request failed with status: ${response.statusCode}');
        setState(() {
          _isLoadingImage = false;
        });
      }

      httpClient.close();
    } catch (e) {
      print('Error with HTTP client: $e');
      setState(() {
        _isLoadingImage = false;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
          _imageBytes = null; // Clear the network image when new image is picked
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      _showErrorSnackBar('Failed to pick image: $e');
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      _showErrorSnackBar('Please select an image first');
      return;
    }

    setState(() {
      _isUploadingImage = true;
    });

    try {
      final fileName = _imageFile!.path.split('/').last;
      final fileExtension = fileName.split('.').last.toLowerCase();

      String contentType = 'image/jpeg';
      if (fileExtension == 'png') {
        contentType = 'image/png';
      } else if (fileExtension == 'gif') {
        contentType = 'image/gif';
      } else if (fileExtension == 'webp') {
        contentType = 'image/webp';
      }

      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          _imageFile!.path,
          filename: fileName,
          contentType: MediaType.parse(contentType),
        ),
      });

      final response = await _dio.post(
        'https://recipe-rise.azurewebsites.net/user/image_upload/$user_id',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully');
        _showSuccessSnackBar('Image uploaded successfully');

        // Clear the picked file and refresh image from server
        setState(() {
          _imageFile = null;
          _isUploadingImage = false;
        });

        // Wait a moment before fetching to ensure server has processed
        await Future.delayed(Duration(milliseconds: 500));
        await _fetchUserImage();
      } else {
        print('Upload failed: ${response.statusCode}');
        _showErrorSnackBar('Upload failed with status: ${response.statusCode}');
        setState(() {
          _isUploadingImage = false;
        });
      }
    } on DioException catch (dioError) {
      print('Upload Dio error: ${dioError.type} - ${dioError.message}');
      _showErrorSnackBar('Upload failed: ${dioError.message}');
      setState(() {
        _isUploadingImage = false;
      });
    } catch (e) {
      print('Error uploading image: $e');
      _showErrorSnackBar('Error uploading image: $e');
      setState(() {
        _isUploadingImage = false;
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showImageSourceDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Image Source'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.of(context).pop();
                  _pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfileImage() {
    return Stack(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[300],
          child: _isLoadingImage
              ? CircularProgressIndicator()
              : ClipOval(
            child: _imageFile != null
                ? Image.file(
              _imageFile!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            )
                : _imageBytes != null
                ? Image.memory(
              _imageBytes!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            )
                : Icon(
              Icons.person,
              size: 60,
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: _showImageSourceDialog,
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {
        if (state is ProfileLogoutSuccessState) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
                (Route<dynamic> route) => false,
          );
          Fluttertoast.showToast(
            msg: state.logoutModel.message!,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 5,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (state is ProfileUpdateSuccessState) {
          Fluttertoast.showToast(
            msg: 'Profile updated successfully!',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
      builder: (context, state) {
        final userData = ProfileCubit.get(context).getUserData;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Center(
                child: const Text('Profile',
                style: Styles.textStyle26,
                ),
            ),

          ),
          body: SafeArea(
            child: Column(

              children: [

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),

                          _buildProfileImage(),

                          const SizedBox(height: 16),

                          if (_imageFile != null) ...[
                            Container(
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.blue.withOpacity(0.3)),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.info, color: Colors.blue, size: 20),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      'New image selected. Tap "Upload Image" to save.',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                          ],

                          Row(
                            children: [
                              // Expanded(
                              //   child: ElevatedButton.icon(
                              //     onPressed: _showImageSourceDialog,
                              //     icon: const Icon(Icons.photo_library),
                              //     label: const Text('Change Image'),
                              //     style: ElevatedButton.styleFrom(
                              //       padding: EdgeInsets.symmetric(vertical: 12),
                              //     ),
                              //   ),
                              // ),
                              if (_imageFile != null) ...[
                                SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton.icon(
                                    onPressed: _isUploadingImage ? null : _uploadImage,
                                    icon: _isUploadingImage
                                        ? SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                        : const Icon(Icons.upload),
                                    label: Text(_isUploadingImage ? 'Uploading...' : 'Upload'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),

                          const SizedBox(height: 10),
                          ProfileName(name: userData?.name ?? 'Unknown'),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ProfileInfoCard(
                                  title: 'Age',
                                  value: '${userData?.age ?? 0} years',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ProfileInfoCard(
                                  title: 'Weight',
                                  value: '${userData?.weight ?? 0} kg',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ProfileInfoCard(
                                  title: 'Height',
                                  value: '${userData?.height ?? 0} cm',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: ProfileInfoCard(
                                  title: 'BMI',
                                  value: (double.parse(userData?.bmi ?? '0')).toStringAsFixed(1),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          BasalMetabolicRateCard(
                            value: '${double.parse(userData?.bmr ?? '0').toStringAsFixed(0)} kcal/day',
                            description: 'The amount of energy you need while resting',
                          ),
                          const SizedBox(height: 16),
                          const QuickActionsSection(),
                          const SizedBox(height: 24),
                          // CustomGradientButton(
                          //   text: 'Edit Profile',
                          //   onPressed: () {
                          //     Navigator.push(
                          //       context,
                          //       MaterialPageRoute(
                          //         builder: (context) => EditProfileScreen(
                          //           profileData: {
                          //             'name': userData?.name,
                          //             'email': userData?.email,
                          //             'age': userData?.age,
                          //             'weight': userData?.weight,
                          //             'height': userData?.height,
                          //             'fitness_goal': userData?.fitness_goal,
                          //             'gender': userData?.gender,
                          //             'activity_level': userData?.activity_level,
                          //           },
                          //         ),
                          //       ),
                          //     ).then((_) {
                          //       // Refresh data when returning from edit screen
                          //       ProfileCubit.get(context).GetAllUserData();
                          //     });
                          //   },
                          //   gradient: kButtonColor,
                          //   width: double.infinity,
                          //   height: 60,
                          //   borderRadius: 32,
                          //   icon: Icons.edit_outlined,
                          // ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: Container(
            width: 56, // Default FAB size
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(
                      profileData: {
                        'name': userData?.name,
                        'email': userData?.email,
                        'age': userData?.age,
                        'weight': userData?.weight,
                        'height': userData?.height,
                        'fitness_goal': userData?.fitness_goal,
                        'gender': userData?.gender,
                        'activity_level': userData?.activity_level,
                      },
                    ),
                  ),
                ).then((_) {
                  ProfileCubit.get(context).GetAllUserData();
                });
              },
              child: const Icon(
                  Icons.edit,
              color: Colors.white,
              ),
              backgroundColor: Colors.transparent,
            ),
          ),

          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 8,
            selectedItemColor: const Color(0xFF4da0ff),
            unselectedItemColor: Colors.grey,
            currentIndex: 4, // Profile tab is index 4
            onTap: (index) {
              if (index != 4) {
                AppNavigator.navigateToTabScreen(context, index);
              }
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.dumbbell),
                label: 'Workouts',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.message),
                label: 'Chatbot',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.utensils),
                label: 'Recipes',
              ),
              BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _dio.close();
    super.dispose();
  }
}

class CustomGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Gradient gradient;
  final double width;
  final double height;
  final double borderRadius;
  final IconData? icon;

  const CustomGradientButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.gradient,
    this.width = 280,
    this.height = 60,
    this.borderRadius = 32,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(icon, color: Colors.white),
                  ),
                Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: onPressed != null
                        ? Colors.white
                        : Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

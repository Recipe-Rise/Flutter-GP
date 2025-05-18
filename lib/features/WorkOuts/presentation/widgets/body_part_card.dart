import 'package:flutter/material.dart';

class BodyPartCard extends StatelessWidget {
  final String name;
  final String imageUrl;
  final VoidCallback onArrowPressed;

  const BodyPartCard({
    Key? key,
    required this.name,
    required this.imageUrl,
    required this.onArrowPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Card(
      color: Colors.white,
      elevation: 1.75,
      margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                imageUrl,
                width: size.width * 0.21,
                height: size.width * 0.21,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.broken_image,
                    size: 50,
                    color: Colors.grey,
                  );
                },
              ),
            ),

            SizedBox(width: size.width * 0.04,),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: size.width * 0.045,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            IconButton(
              icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              onPressed: onArrowPressed,
            ),

          ],
        ),
      ),
    );
  }
}
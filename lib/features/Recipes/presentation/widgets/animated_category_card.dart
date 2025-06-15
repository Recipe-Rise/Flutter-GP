import 'package:flutter/material.dart';

class AnimatedCategoryCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final IconData icon;
  final VoidCallback onTap;

  const AnimatedCategoryCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.icon,
    required this.onTap,
  });

  @override
  State<AnimatedCategoryCard> createState() => _AnimatedCategoryCardState();
}

class _AnimatedCategoryCardState extends State<AnimatedCategoryCard>
    with SingleTickerProviderStateMixin {
  bool _isTapped = false;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(_animationController);
    _colorAnimation = ColorTween(
      begin: widget.backgroundColor,
      end: widget.backgroundColor.withOpacity(0.7),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return RepaintBoundary(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _isTapped = !_isTapped;
          });
          if (_isTapped) {
            _animationController.forward();
          } else {
            _animationController.reverse();
          }
          widget.onTap();
        },
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _colorAnimation.value ?? widget.backgroundColor,
                      widget.backgroundColor.withOpacity(0.6),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: _animationController.value * 2 * 3.14159,
                      child: Icon(
                        widget.icon,
                        size: screenWidth * 0.1, // Responsive icon size
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.04), // Responsive spacing
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: screenWidth * 0.05, // Responsive font size
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.02), // Responsive spacing
                          Text(
                            widget.subtitle,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04, // Responsive font size
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
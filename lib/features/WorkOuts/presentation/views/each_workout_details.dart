import 'package:flutter/material.dart';

class EachWorkoutDetails extends StatelessWidget {
  final dynamic exercise;
  const EachWorkoutDetails({super.key,required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ExerciseDetailsPage(exercise: exercise),
    );
  }
}
class ExerciseDetailsPage extends StatefulWidget {
  final dynamic exercise;
  const ExerciseDetailsPage({Key? key , required this.exercise}) : super(key: key);

  @override
  State<ExerciseDetailsPage> createState() => _ExerciseDetailsPageState();
}

class _ExerciseDetailsPageState extends State<ExerciseDetailsPage> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Trigger animations after a short delay
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _isVisible = true;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.exercise.name ?? 'Workout Details'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 500),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF5B84C4), Color(0xFF4267B2)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                height: 180,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      widget.exercise.gifUrl!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.fitness_center, color: Colors.white.withOpacity(0.8), size: 40),
                            const SizedBox(height: 8),
                            Text(
                              'Image not available',
                              style: TextStyle(color: Colors.white.withOpacity(0.8)),
                            ),
                          ],
                        );
                      },
                    ),

                      // Positioned(
                      //   left: 20,
                      //   bottom: 0,
                      //   child: Image.network(
                      //     exercise.gifUrl!,
                      //     height: 150,
                      //     errorBuilder: (context, error, stackTrace) {
                      //       return SizedBox(
                      //         height: 150,
                      //         width: 200,
                      //         child: Column(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           children: [
                      //             Icon(Icons.fitness_center, color: Colors.white.withOpacity(0.8), size: 40),
                      //             const SizedBox(height: 8),
                      //             Text(
                      //               'Squat Start',
                      //               style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // ),

                      // Center(
                      //   child: Container(
                      //     width: 50,
                      //     height: 50,
                      //     decoration: BoxDecoration(
                      //       color: Colors.white.withOpacity(0.2),
                      //       shape: BoxShape.circle,
                      //     ),
                      //     child: const Icon(
                      //       Icons.play_arrow,
                      //       color: Colors.white,
                      //       size: 30,
                      //     ),
                      //   ),
                      // ),

                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.exercise.name ?? 'Exercise Name',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Target : ${widget.exercise.target ?? 'N/A'}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Secondary Muscles',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    if (widget.exercise.secondaryMuscles != null && widget.exercise.secondaryMuscles!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: widget.exercise.secondaryMuscles!.map<Widget>((muscle) {
                          return ListTile(
                            // contentPadding: EdgeInsets.,
                            leading: const Icon(
                              Icons.circle_sharp,
                              size: 10,
                              color: Color(0xFF1E64EF),
                            ),
                            title: Text(
                              muscle,
                              style: const TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    else
                      Text(
                        'No secondary muscles available.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 14,
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'How To Do It',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${widget.exercise.instructions?.length ?? 0} Steps',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    if (widget.exercise.instructions != null)
                      for (int i = 0; i < widget.exercise.instructions!.length; i++)
                        _buildInstructionStep(
                          (i + 1).toString().padLeft(2, '0'),
                          'Step ${i + 1}',
                          widget.exercise.instructions![i],
                        ),

                    // _buildInstructionStep(
                    //   '01',
                    //   'Set Your Stance',
                    //   'Stand with your feet shoulder-width apart. Position the barbell in front of your shoulders with elbows high and pointing forward. Keep your chest up and core engaged.',
                    // ),
                    // _buildInstructionStep(
                    //   '02',
                    //   'Lower Your Body',
                    //   'Begin the movement by bending your knees and pushing your hips back. Keep your elbows up and maintain an upright posture.',
                    // ),
                    // _buildInstructionStep(
                    //   '03',
                    //   'Drive Up',
                    //   'Push through your heels and extend your knees to lift your body back up. Keep your back straight and your core tight as you rise.',
                    // ),
                    // _buildInstructionStep(
                    //   '04',
                    //   'Return to Start',
                    //   'Fully extend your legs and return to the starting position. Reset your posture and prepare for the next repetition.',
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInstructionStep(String number, String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: const Color(0xFF4267B2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),

              if (int.parse(number) < (widget.exercise.instructions?.length ?? 0))
                Container(
                  width: 2,
                  height: 60,
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  color: const Color(0xFF4267B2).withOpacity(0.3),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye,
                      color: Color(0xFF4267B2),
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

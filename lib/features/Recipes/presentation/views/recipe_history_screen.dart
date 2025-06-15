import 'package:fitfork_gp/features/Recipes/data/models/get_user_recipes_history.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/recipe_cubit.dart';
import 'package:fitfork_gp/features/Recipes/presentation/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  final int cookingTime;
  final String difficulty;
  final List<String> tags;
  final double rating;

  Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
    required this.cookingTime,
    required this.difficulty,
    required this.tags,
    required this.rating,
  });
}

class RecipeHistoryPage extends StatefulWidget {
  const RecipeHistoryPage({Key? key}) : super(key: key);

  @override
  State<RecipeHistoryPage> createState() => _RecipeHistoryPageState();
}

class _RecipeHistoryPageState extends State<RecipeHistoryPage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  String _selectedFilter = 'All';
  String _searchQuery = '';
  bool _isGridView = false;

  final List<Recipe> _recipes = [
    Recipe(
      id: '1',
      title: 'Mediterranean Quinoa Bowl',
      description: 'Fresh and healthy quinoa bowl with Mediterranean flavors',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      cookingTime: 25,
      difficulty: 'Easy',
      tags: ['Healthy', 'Vegetarian', 'Mediterranean'],
      rating: 4.8,
    ),
    Recipe(
      id: '2',
      title: 'Spicy Thai Curry',
      description: 'Authentic Thai red curry with coconut milk and vegetables',
      imageUrl: 'https://images.unsplash.com/photo-1455619452474-d2be8b1e70cd?w=400',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      cookingTime: 40,
      difficulty: 'Medium',
      tags: ['Spicy', 'Thai', 'Curry'],
      rating: 4.6,
    ),
    Recipe(
      id: '3',
      title: 'Classic Beef Wellington',
      description: 'Elegant beef wellington with mushroom duxelles',
      imageUrl: 'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=400',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      cookingTime: 120,
      difficulty: 'Hard',
      tags: ['Beef', 'Gourmet', 'Classic'],
      rating: 4.9,
    ),
    Recipe(
      id: '4',
      title: 'Fresh Garden Salad',
      description: 'Crisp vegetables with homemade vinaigrette',
      imageUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=400',
      createdAt: DateTime.now().subtract(const Duration(days: 10)),
      cookingTime: 15,
      difficulty: 'Easy',
      tags: ['Healthy', 'Vegetarian', 'Fresh'],
      rating: 4.3,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  List<Recipe> get _filteredRecipes {
    List<Recipe> filtered = _recipes;

    if (_selectedFilter != 'All') {
      filtered = filtered.where((recipe) =>
      recipe.difficulty == _selectedFilter ||
          recipe.tags.contains(_selectedFilter)
      ).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((recipe) =>
      recipe.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe.description.toLowerCase().contains(_searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }


  List<GetUserRecipeHistory> hRecipes = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RecipeRecommendationCubit,RecipesRecommendationStates>(
      listener: (context,state){
        if(state is GetUserRecipeHistorySuccessState){
          hRecipes = state.hRecipes;
        } else if (state is GetUserRecipeHistoryErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context,state){


        if(state is GetUserRecipeHistoryLoadingState){
          return const Center(
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 31, 22, 199),
            ),
          );
        }

        else{

          List<GetUserRecipeHistory> filteredRecipes = hRecipes;

          if (_searchQuery.isNotEmpty) {
            filteredRecipes = hRecipes.where((recipe) =>
                recipe.name!.toLowerCase().contains(_searchQuery.toLowerCase())
            ).toList();
          }

        return Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          body: CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: _buildFiltersAndSearch(),
                  ),
                ),
              ),
              _isGridView ? _buildGridView(filteredRecipes) : _buildListView(filteredRecipes),
            ],
          ),
        );
        }
      },
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(

      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Recipe History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 78, 141, 224),
                Color.fromARGB(255, 31, 22, 199)
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.restaurant_menu,
              size: 80,
              color: Colors.white.withOpacity(0.3),
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
              _isGridView ? Icons.view_list : Icons.grid_view
          ),
          color: Colors.white,
          onPressed: () {
            setState(() {
              _isGridView = !_isGridView;
            });
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildFiltersAndSearch() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search recipes...',
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color:Color(0xFF74B9FF) ),
                hintStyle: TextStyle(color: Color(0xFF74B9FF)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Filter Chips
          // SizedBox(
          //   height: 40,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: ['All', 'Easy', 'Medium', 'Hard', 'Healthy', 'Vegetarian']
          //         .map((filter) => _buildFilterChip(filter))
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String filter) {
    final isSelected = _selectedFilter == filter;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 12),
      child: FilterChip(
        label: Text(filter),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedFilter = selected ? filter : 'All';
          });
        },
        backgroundColor: Colors.white,
        selectedColor: const Color(0xFF6C5CE7),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : const Color(0xFF2D3436),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
        elevation: isSelected ? 4 : 1,
        shadowColor: const Color(0xFF6C5CE7).withOpacity(0.3),
      ),
    );
  }

  Widget _buildListView(List<GetUserRecipeHistory> recipes) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (context, index) {
          final recipe = hRecipes[index];
          return FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300 + (index * 100)),
                curve: Curves.easeOutCubic,
                child: _buildRecipeCard(recipe, index),
              ),
            ),
          );
        },
        childCount: recipes.length,
      ),
    );
  }

  Widget _buildGridView(List<GetUserRecipeHistory> recipes) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        delegate: SliverChildBuilderDelegate(
              (context, index) {
            final recipe = hRecipes[index];
            return FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: _buildGridRecipeCard(recipe, index),
              ),
            );
          },
          childCount: recipes.length,
        ),
      ),
    );
  }

  Widget _buildRecipeCard(GetUserRecipeHistory recipe, int index) {

    final DateTime dateTime = DateTime.parse(recipe.dateAndTime!);
    final String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    final String formattedTime = DateFormat('hh:mm a').format(dateTime);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showRecipeDetails(recipe),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Recipe Image
              // Hero(
              //   tag: 'recipe-${recipe.id}',
              //   child: Container(
              //     width: 80,
              //     height: 80,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(12),
              //       image: DecorationImage(
              //         image: NetworkImage(recipe.imageUrl),
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(width: 16),
              // Recipe Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipe.name!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3436),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.ingredients!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildInfoChip(Icons.schedule, '${recipe.minutes?.toInt()}m'),
                        const SizedBox(width: 8),
                        _buildInfoChip(Icons.format_list_numbered_outlined, '${recipe.nSteps?.toInt()} steps'),
                        const Spacer(),
                        Row(
                          children: [
                            const Icon(Icons.local_fire_department_sharp, color: Colors.amber, size: 16),
                            Text(
                              recipe.calories.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2D3436),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Added on: $formattedDate at $formattedTime',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridRecipeCard(GetUserRecipeHistory recipe, int index) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _showRecipeDetails(recipe),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image area using fixed height based on total height
                Container(
                  height: constraints.maxHeight * 0.5, // 50% for image
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    color: const Color(0xFF74B9FF).withOpacity(0.1),
                  ),
                  child: const Center(
                    child: Text("🥪", style: TextStyle(fontSize: 50)),
                  ),
                ),

                // Recipe details
                Container(
                  height: constraints.maxHeight * 0.5, // 50% for text
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoChip(Icons.schedule, '${recipe.minutes?.toInt() ?? 0}m'),
                          Row(
                            children: [
                              const Icon(Icons.local_fire_department_rounded,
                                  color: Colors.amber, size: 14),
                              const SizedBox(width: 2),
                              Text(
                                '${recipe.calories?.toInt() ?? 0}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF74B9FF).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: const Color(0xFF1D5998)  ),
          const SizedBox(width: 4),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF4080CB),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showRecipeDetails(GetUserRecipeHistory recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // Recipe Image
                // Hero(
                //   tag: 'recipe-${recipe.id}',
                //   child: Container(
                //     height: 200,
                //     width: double.infinity,
                //     margin: const EdgeInsets.symmetric(horizontal: 20),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(16),
                //       image: DecorationImage(
                //         image: NetworkImage(recipe.imageUrl),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recipe.name!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipe.ingredients!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          _buildDetailInfo(Icons.schedule, 'Cooking Time', '${recipe.minutes} min'),
                          const SizedBox(width: 20),
                          _buildDetailInfo(Icons.format_list_numbered_outlined, 'Steps', '${recipe.nSteps} steps'),
                          const SizedBox(width: 20),
                          _buildDetailInfo(Icons.local_fire_department_sharp, 'Calories', recipe.calories.toString()),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Steps',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3436),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: recipe.steps!.map((step) => Chip(
                          label: Text(step),
                          backgroundColor: const Color(0xFF6C5CE7).withOpacity(0.1),
                          labelStyle: const TextStyle(
                            color: Color(0xFF6C5CE7),
                            fontWeight: FontWeight.w500,
                          ),
                        )).toList(),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailInfo(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF6C5CE7)),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2D3436),
            ),
          ),
        ],
      ),
    );
  }
}
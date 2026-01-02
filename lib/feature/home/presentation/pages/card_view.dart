import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/feature/home/data/recipe_model.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_bloc.dart';
import 'package:voicecook/feature/home/presentation/bloc/home_event.dart';

class CardView extends StatefulWidget {
  final List<RecipeModel> recipes;
  const CardView({super.key, required this.recipes});

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: widget.recipes.length,
                itemBuilder: (context, index) {
                  final item = widget.recipes[index];
                  bool isFav = item.isFavorite;

                  return GestureDetector(
                    onTap: () {
                      context.read<HomeBloc>().add(
                        NavToDeatilEvent(recipe: item),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      clipBehavior: Clip.antiAlias,
                      elevation: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  item.imageUrl,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.favorite,
                                    color: isFav ? Colors.red : Colors.white,

                                    size: 28,
                                  ),
                                  onPressed: () {
                                    context.read<HomeBloc>().add(
                                      AddToFavoriteEvent(recipe: item),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: FittedBox(
                              child: Text(
                                item.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              item.description,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          const SizedBox(height: 6),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/feature/category/data/category_model.dart';
import 'package:voicecook/feature/category/presentation/bloc/category_bloc.dart';
import 'package:voicecook/feature/category/presentation/bloc/category_event.dart';
import 'package:voicecook/feature/category/presentation/bloc/category_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(GetCategoryEvent()),
      child: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CategoryLoadedState) {
            return CategoryView(categoryModel: state.category);
          } else if (state is CategoryErrorState) {
            return Center(child: Text(state.error));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  final List<CategoryModel> categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: categoryModel.length,
      itemBuilder: (context, index) {
        final item = categoryModel[index];
        return GestureDetector(
          onTap: () {
            context.read<CategoryBloc>().add(
              GetCategoryListEvent(recipe: item),
            );
          },
          child: Container(
            width: 100,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(item.imageUrl),
                  backgroundColor: Colors.grey[200],
                ),
                const SizedBox(height: 8),
                Text(
                  item.categoryName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voicecook/feature/category/data/category_model.dart';
import 'package:voicecook/feature/category/presentation/bloc/category_bloc.dart';
import 'package:voicecook/feature/category/presentation/bloc/categoty_event.dart';
import 'package:voicecook/feature/category/presentation/bloc/categoty_state.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(GetCategotyEvent()),
      child: Scaffold(
        body: BlocBuilder<CategoryBloc, CategoryState>(
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
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  final List<CategoryModel> categoryModel;
  const CategoryView({super.key, required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: categoryModel.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final item = categoryModel[index];
          return GestureDetector(
            onTap: () {
              context.read<CategoryBloc>().add(
                GetCategotyListEvent(recipe: item),
              );
            },
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Image.network(
                    item.imageUrl,
                    fit: BoxFit.fill,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  Container(
                    color: Colors.black54,
                    padding: EdgeInsets.all(8),
                    child: FittedBox(
                      child: Text(
                        item.categoryName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

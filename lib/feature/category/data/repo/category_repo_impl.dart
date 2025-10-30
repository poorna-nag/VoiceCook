import 'package:voicecook/feature/category/data/category_model.dart';
import 'package:voicecook/feature/category/data/repo/category_repo.dart';

class CategoryRepoImpl extends CategoryRepo {
  final List<CategoryModel> category = [
    CategoryModel(
      imageUrl: 'https://images.unsplash.com/photo-1543353071-087092ec393a',
      categoryName: 'Breakfast',
    ),
    CategoryModel(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRX5BrddVL-WBbGQ4-8NpnhdQfsijhFmWRYnA&s',
      categoryName: 'Lunch',
    ),
    CategoryModel(
      imageUrl:
          'https://img.freepik.com/free-photo/view-delicious-steak-dish_23-2150777653.jpg?semt=ais_hybrid&w=740&q=80',
      categoryName: 'Dinner',
    ),
    CategoryModel(
      imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836',
      categoryName: 'Snacks',
    ),
    CategoryModel(
      imageUrl: 'https://images.unsplash.com/photo-1505253758473-96b7015fcd40',
      categoryName: 'Desserts',
    ),
    CategoryModel(
      imageUrl: 'https://images.unsplash.com/photo-1551024601-bec78aea704b',
      categoryName: 'Beverages',
    ),

    CategoryModel(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRODgLERzVmHH9i3puxgqNnvoqPaFR61MKF-w&s',
      categoryName: 'Salads',
    ),

    CategoryModel(
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtVWB6JdLj0hhgtHD7lTtO9-5lxSUMvLBCEF5IxccCEg3WWz5JhyzaYqL-nSgChQp986Y&usqp=CAU',
      categoryName: 'Healthy',
    ),
  ];
  @override
  Future<List<CategoryModel>> getCategory() async {
    Future.delayed(Duration(milliseconds: 1));
    return category;
  }
}

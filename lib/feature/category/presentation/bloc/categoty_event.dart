import 'package:voicecook/feature/category/data/category_model.dart';


class CategotyEvent {}

class GetCategotyEvent extends CategotyEvent {}

class GetCategotyListEvent extends CategotyEvent {
  final CategoryModel recipe;

  GetCategotyListEvent({required this.recipe});
}

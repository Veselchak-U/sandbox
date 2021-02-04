import 'package:sandbox/app/data/models/category.dart';

enum MeasureUnit { gr, ml }

class ItemModel {
  final String id;
  final CategoryModel category;
  final String name;
  final String photoUrl;
  final int price;
  final int quantity;
  final MeasureUnit measureUnit;

  ItemModel({
    this.id,
    this.category,
    this.name,
    this.photoUrl,
    this.price,
    this.quantity,
    this.measureUnit,
  });
}

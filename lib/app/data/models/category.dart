class CategoryModel {
  CategoryModel({
    this.id,
    this.name,
  });

  final String id;
  final String name;

  @override
  String toString() => name;
}

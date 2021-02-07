import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sandbox/app/data/models/category.dart';
import 'package:sandbox/app/data/models/item.dart';
import 'package:sandbox/app/data/stub_data.dart';

class ShowcaseController extends GetxController {
  final categories = StubData.categories;
  final items = StubData.items;
  final categoryIndex = 0.obs;
  List<ShowcaseItem> showcaseItems;

  @override
  void onInit() {
    print('ShowcaseController onInit()');
    showcaseItems = convertToShowcaseItem(
      categories: StubData.categories,
      items: StubData.items,
    );
    super.onInit();
  }

  @override
  void onReady() {
    print('ShowcaseController onReady()');
    super.onReady();
  }

  @override
  void onClose() {
    print('ShowcaseController onClose()');
  }

  List<ShowcaseItem> convertToShowcaseItem({
    @required List<CategoryModel> categories,
    @required List<ItemModel> items,
  }) {
    assert(categories != null && categories.isNotEmpty);
    assert(items != null && items.isNotEmpty);

    final result = <ShowcaseItem>[];
    for (final category in categories) {
      final categoryItems =
          items.where((item) => item.category == category).toList();
      if (categoryItems.isNotEmpty) {
        result.add(ShowcaseItem(headerName: category.name));
        result.add(ShowcaseItem(items: categoryItems));
      }
    }
    return result;
  }

  void changeCategory({CategoryModel category, int index}) {
    if (category != null) {
      categoryIndex.value = categories.indexOf(category);
    } else if (index != null) {
      categoryIndex.value = index;
    }
  }
}

class ShowcaseItem<T> {
  ShowcaseItem({
    this.headerName,
    this.items,
  }) : assert(items != null || headerName != null);

  final String headerName;
  final List<T> items;
}

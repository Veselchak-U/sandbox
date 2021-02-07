import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sandbox/app/data/models/category.dart';
import 'package:sandbox/app/data/models/item.dart';

import 'package:sandbox/app/modules/showcase/controllers/showcase_controller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

const double kHorizontalPadding = 16.0;
const double kGoldenRatio = 1.618;
const borderWidth = 2.0;
const borderRadius = 16.0;

class ShowcaseView extends GetView<ShowcaseController> {
  @override
  Widget build(BuildContext context) {
    return _ShowcaseView(controller: controller);
  }
}

class _ShowcaseView extends StatefulWidget {
  _ShowcaseView({this.controller});

  final ShowcaseController controller;

  @override
  _ShowcaseViewState createState() => _ShowcaseViewState();
}

class _ShowcaseViewState extends State<_ShowcaseView> {
  ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionsListener;
  ShowcaseController controller;
  List<CategoryModel> categories;
  List<ShowcaseItem> items;
  RxInt categoryIndex;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    categories = controller.categories;
    items = controller.showcaseItems;
    categoryIndex = controller.categoryIndex;
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      // int min;
      // int max;
      int middle;
      if (positions.isNotEmpty) {
        // min = positions
        //     .where((position) => position.itemTrailingEdge > 0)
        //     .reduce((min, current) =>
        //         current.itemTrailingEdge < min.itemTrailingEdge ? current : min)
        //     .index;
        // max = positions
        //     .where((position) => position.itemLeadingEdge < 1)
        //     .reduce((max, current) =>
        //         current.itemLeadingEdge > max.itemLeadingEdge ? current : max)
        //     .index;
        middle = positions
            .firstWhere((position) => (position.itemLeadingEdge < 0.5 &&
                position.itemTrailingEdge > 0.5))
            .index;
      }
      // print('min = $min, middle = $middle, max = $max');
      // print('$positions');
      controller.changeCategory(index: middle ~/ 2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: _CategoryChips<CategoryModel>(
              selectedIndex: categoryIndex.value,
              items: categories,
              onSelected: (category) {
                controller.changeCategory(category: category);
                _scrollTocategory(categoryIndex.value * 2);
              },
            ),
          ),
          body: ScrollablePositionedList.builder(
            itemScrollController: itemScrollController,
            itemPositionsListener: itemPositionsListener,
            itemCount: items.length,
            itemBuilder: (context, index) {
              if (items[index].headerName != null) {
                return _Header(headerText: items[index].headerName);
              } else if (items[index].items != null) {
                return _Grid(items[index].items as List<ItemModel>);
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  void _scrollTocategory(int index) {
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOutCubic,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    Key key,
    @required this.headerText,
  }) : super(key: key);

  final String headerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kHorizontalPadding),
      child: Text(
        headerText,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}

class _Grid extends StatelessWidget {
  const _Grid(this.categoryItems);

  final List<ItemModel> categoryItems;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - (kHorizontalPadding * 3)) / 2;
    final cardHeight = cardWidth * kGoldenRatio;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: cardWidth / cardHeight,
        mainAxisSpacing: kHorizontalPadding,
        crossAxisSpacing: kHorizontalPadding,
        physics: const NeverScrollableScrollPhysics(),
        children: List.generate(
          categoryItems.length,
          (index) => _GridItem(categoryItems[index]),
        ),
      ),
    );
  }
}

class _GridItem extends StatelessWidget {
  const _GridItem(this.item);

  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    final measureUnit = item.measureUnit.toString().split('.').last;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColorLight,
          width: borderWidth,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(borderRadius),
        ),
      ),
      child: Text(
        '${item.name}\n'
        '${item.price}р.  ${item.quantity}$measureUnit',
      ),
    );
  }
}

class _CategoryChips<T> extends StatelessWidget {
  _CategoryChips({
    @required this.selectedIndex,
    @required this.items,
    @required this.onSelected,
  });

  final int selectedIndex;
  final List<T> items;
  final Function(T value) onSelected;

  @override
  Widget build(BuildContext context) {
    if (items == null || items.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
            items.length,
            (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ChoiceChip(
                    label: Text(items[index].toString()),
                    elevation: 2.0,
                    // selectedColor: Theme.of(context).accentColor,
                    selected: index == selectedIndex,
                    onSelected: (value) {
                      onSelected(value ? items[index] : null);
                    },
                  ),
                )),
      ),
    );
  }
}

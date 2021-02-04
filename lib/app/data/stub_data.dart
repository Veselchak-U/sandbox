import 'package:sandbox/app/data/models/category.dart';
import 'package:sandbox/app/data/models/item.dart';

class StubData {
  static final _categoryes = [
    CategoryModel(
      id: '1',
      name: 'Пицца',
    ),
    CategoryModel(
      id: '2',
      name: 'Закуски',
    ),
    CategoryModel(
      id: '3',
      name: 'Соусы',
    ),
    CategoryModel(
      id: '4',
      name: 'Напитки',
    ),
    CategoryModel(
      id: '5',
      name: 'Десерты',
    ),
  ];

  static final _photos = [
    'https://www.restoran.ru/upload/resize_cache/iblock/a4a/1200_800_11a88371ca9e7ba72ce6f5767ba9eff1a/ritstsa.jpg',
    'https://image1.thematicnews.com/uploads/topics/preview/00/05/39/01/74be8e0e21.jpg',
    'https://pizzaking96.ru/dir_images/catalogs_file1_31_l.jpg',
    'https://i.artfile.ru/3000x1936_960123_[www.ArtFile.ru].jpg',
    'https://wallbox.ru/wallpapers/main/201223/pirozhnoe-sladkoe-desert-395a31c.jpg',
  ];

  static final List<ItemModel> items = List.generate(
    _categoryes.length * 5,
    (index) {
      final subIndex = index ~/ 5;
      final id = '$index';
      final category = _categoryes[subIndex];
      final name = '${_categoryes[subIndex].name} ${index % 5}';
      final photoUrl = _photos[subIndex];
      final price = index * 150 % 1000;
      final quantity = index * 90 % 500;
      final measureUnit = subIndex % 2 == 0 ? MeasureUnit.gr : MeasureUnit.ml;
      return ItemModel(
        id: id,
        category: category,
        name: name,
        photoUrl: photoUrl,
        price: price,
        quantity: quantity,
        measureUnit: measureUnit,
      );
    },
  );
}

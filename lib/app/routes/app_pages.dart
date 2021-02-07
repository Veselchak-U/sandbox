import 'package:get/get.dart';

import 'package:sandbox/app/modules/showcase/bindings/showcase_binding.dart';
import 'package:sandbox/app/modules/showcase/views/showcase_view.dart';

part 'app_routes.dart';

class AppPages {
  // ignore: constant_identifier_names
  static const INITIAL = Routes.SHOWCASE;

  static final routes = [
    GetPage(
      name: _Paths.SHOWCASE,
      page: () => ShowcaseView(),
      binding: ShowcaseBinding(),
    ),
  ];
}

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:sandbox/app/modules/showcase/controllers/showcase_controller.dart';

class ShowcaseView extends GetView<ShowcaseController> {
  @override
  Widget build(BuildContext context) {
    final items = ShowcaseController().items;
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(items[index].category.name),
              subtitle: Text(
                  '${items[index].name}\n${items[index].price}р.  ${items[index].quantity}${items[index].measureUnit.toString().split(".").last}'),
              isThreeLine: true,
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app/UI/shared/menu/bottom_bar.dart';
import 'package:flutter_app/UI/shared/menu/simplified_top_menu.dart';
import 'package:flutter_app/UI/widgets/patterns/pattern_shop_bucket_card.dart';
import 'package:flutter_app/core/models/card_model.dart';
import 'package:scoped_model/scoped_model.dart';

class ShopCard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimplifiedTopMenu(),
      body: ScopedModelDescendant<CardModel>(
        builder: (context, child, model) {
          return model.get_all().length == 0
              ? empty_bucket()
              : bucket_with_items();
        },
      ),
      bottomNavigationBar:
          ScopedModelDescendant<CardModel>(builder: (context, child, model) {
        return BottomMenu(model: model);
      }),
    );
  }

  bucket_with_items() {
    return ScopedModelDescendant<CardModel>(builder: (context, child, model) {
      return ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: model.get_all().length,
        itemBuilder: (context, pos) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              model.remove_by_id(model.get_all()[pos].id);
            },
            child: PatternShopBucketCard(
                product: model.get_all()[pos], model: model),
          );
        },
      );
    });
  }

  empty_bucket() {
    return Center(child: Text("You haven't taken any item yet"));
  }
}

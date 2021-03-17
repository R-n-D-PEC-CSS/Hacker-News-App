import 'dart:async';
import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../blocs/stories_provider.dart';
import 'loading_container.dart';

class NewsListTile extends StatelessWidget {
  final int itemId;

  NewsListTile({this.itemId});

  Widget build(context) {
    final bloc = StoriesProvider.of(context);

    return StreamBuilder(
      stream: bloc.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot) {
        if (!snapshot.hasData) {
          return LoadingContainer();
        }

        return FutureBuilder(
          future: snapshot.data[itemId],
          builder: (context, AsyncSnapshot<ItemModel> itemSnapshot) {
            if (!itemSnapshot.hasData) {
              return LoadingContainer();
            }

            return buildTile(context, itemSnapshot.data);
          },
        );
      },
    );
  }

  Widget buildTile(BuildContext context, ItemModel item) {
    return Column(
      children: [
        ListTile(
          tileColor: Colors.black,
          onTap: () {
            Navigator.pushNamed(context, '/${item.id}');
          },
          title: Text(
            item.title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            '${item.score} points',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: Column(
            children: [
              Icon(
                Icons.comment,
                color: Colors.white,
              ),
              Text('${item.descendants}'),
            ],
          ),
        ),
      ],
    );
  }
}

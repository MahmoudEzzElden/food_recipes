import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RecipeTile extends StatelessWidget {
  final String? url;
  final String? recipeName;
  final ObjectKey? myKey;
 final void Function(DismissDirection)? onDismiss;

  const RecipeTile({Key? key, this.url, this.recipeName, this.myKey, this.onDismiss})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: myKey!,
      direction: DismissDirection.startToEnd,
      onDismissed: onDismiss,
      background: Container(
        alignment: Alignment.centerLeft,
        color: Colors.redAccent,
        child: Icon(Icons.delete_forever),
      ),
      child: Card(
        elevation: 4,
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: url!,
              height: 110,
              width: 110,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              recipeName!,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

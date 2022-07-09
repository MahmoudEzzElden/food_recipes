
import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String? title;
  final String? image;
 final void Function()? onTap;
  const DrawerTile({Key? key, this.title, this.image, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 20,
        backgroundColor: Colors.transparent,
        backgroundImage: AssetImage(image!),
      ),

      title: Text(title!,style: TextStyle(fontSize: 20),),
    );
  }
}

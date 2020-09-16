import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/models/product_manager.dart';
import 'package:provider/provider.dart';
import 'package:loja_virtual_version2/models/section_item.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);
  final SectionItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        print("Clicado");
        return showDialog(
            context: context,
            builder: (context) {
              return ListView(
                shrinkWrap: false,
                children: <Widget>[
                  AlertDialog(
                    actions: <Widget>[
                      IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                    backgroundColor: Colors.black.withAlpha(0),
                    clipBehavior: Clip.hardEdge,
                    actionsPadding: EdgeInsets.zero,
                    buttonPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    content: Container(
                        child: Hero(
                            tag: "showDialog",
                            child: Image.network(item.image)
                        )
                      ),
                  ),
                ],
              );
            });
      },
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().findProductById(item.product);
          Navigator.of(context).pushNamed("/product", arguments: product);
        }
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: FadeInImage.memoryNetwork(
          placeholder: kTransparentImage, 
          image: item.image, 
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

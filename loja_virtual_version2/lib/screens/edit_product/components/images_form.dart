import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/models/product.dart';
import 'package:loja_virtual_version2/screens/edit_product/components/image_source_sheet.dart';

class ImagesForm extends StatelessWidget {
  const ImagesForm(this.product);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return FormField<List<dynamic>>(
      initialValue: product.images,
      validator: (images) {
        if (images.isEmpty) {
          return "Insira ao menos uma imagem";
        } else {
          return null;
        }
      },
      //autovalidate: true,
      builder: (state) {
        void onImageSelected(File file) {
          state.value.add(file);
          state.didChange(state.value);
          Navigator.of(context).pop();
        }

        return Column(children: <Widget>[
          AspectRatio(
            aspectRatio: 1,
            child: Carousel(
              autoplay: false,
              dotSize: 5,
              dotBgColor: Colors.transparent,
              dotColor: Theme.of(context).primaryColor,
              dotSpacing: 10,
              images: state.value.map<Widget>((image) {
                return Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.centerLeft,
                  children: [
                    if (image is String)
                      Image.network(image, fit: BoxFit.cover)
                    else
                      Image.file(image as File, fit: BoxFit.cover),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.red,
                        onPressed: () {
                          state.value.remove(image);
                          state.didChange(state.value);
                        },
                      ),
                    ),
                  ],
                );
              }).toList()
                ..add(Material(
                  color: Colors.grey[100],
                  child: IconButton(
                    iconSize: 50,
                    color: Theme.of(context).primaryColor,
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () {
                      if (Platform.isIOS)
                        showCupertinoModalPopup(
                          context: context,
                          builder: (_) => ImageSourceSheet(
                            onImageSelected: onImageSelected,
                          ),
                        );
                      else
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => ImageSourceSheet(
                            onImageSelected: onImageSelected,
                          ),
                        );
                    },
                  ),
                )),
            ),
          ),
          if (state.hasError)
            Container(
              padding: const EdgeInsets.all(5),
              alignment: Alignment.centerLeft,
              child: Text(state.errorText,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  )),
            ),
        ]);
      },
    );
  }
}

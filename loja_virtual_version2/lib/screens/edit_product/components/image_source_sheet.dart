import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {

  ImageSourceSheet({this.onImageSelected});
  final Function(File) onImageSelected;
  final ImagePicker picker = ImagePicker();

  Future<void> editImage(String filePath, BuildContext context) async {
    final File croppedFile = await ImageCropper.cropImage(
      sourcePath: filePath,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
        toolbarTitle: "Editar imagem",
        toolbarColor: Theme.of(context).primaryColor,
        toolbarWidgetColor: Colors.white,
      ),
      iosUiSettings: IOSUiSettings(
        title: "Editar Imagem",
        cancelButtonTitle: "Cancelar",
        doneButtonTitle: "Concluir",
      )
    );
    if(croppedFile != null)
      onImageSelected(croppedFile);
  }

  void getImageCamera(BuildContext context) async {
    final PickedFile file = 
      await picker.getImage(source: ImageSource.camera);
    editImage(file.path, context);
  }

  void getImageGalery(BuildContext context) async { // source image, send to editImage()
    final PickedFile file = 
      await picker.getImage(source: ImageSource.gallery);
    editImage(file.path, context);
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid)
      return BottomSheet(
        onClosing: () {},
        builder: (_) => Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt),
                  SizedBox(
                    width: 10,
                  ),
                  const Text("Câmera"),
                ],
              ),
              onPressed: (){
                getImageCamera(context);
              }
            ),
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(
                    width: 10,
                  ),
                  const Text("Galeria"),
                ],
              ),
              onPressed:(){
                getImageGalery(context);
              },
            ),
          ],
        ),
      );
    else
      return CupertinoActionSheet(
        title: const Text("Selecionar foto para item"),
        message: const Text("Escolha origem da foto"),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: true,
            child: const Text("Câmera"),
            onPressed: (){
                getImageCamera(context);
              },
          ),
          CupertinoActionSheetAction(
            child: const Text("Galeria"),
            onPressed: (){
                getImageGalery(context);
              },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          child: const Text("Sair"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      );
  }
}

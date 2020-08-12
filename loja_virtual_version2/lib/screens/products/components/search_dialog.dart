import 'package:flutter/material.dart';

class SearchDialog extends StatelessWidget {

  const SearchDialog(this.initialText);

  final String initialText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 2, 
          left: 8,
          right: 8,
          child: Card(
            child: TextFormField(
              initialValue: initialText,
              autofocus: true,
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (text){
                Navigator.of(context).pop(text);
                print("--------------------------------- PESQUISA: "+text);
              },
              decoration: InputDecoration(
                prefixIcon: IconButton(
                  tooltip: "Voltar",
                  icon: Icon(Icons.arrow_back),
                  color: Colors.grey[800],
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                ),
                hintText: "Pesquise o produto",
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
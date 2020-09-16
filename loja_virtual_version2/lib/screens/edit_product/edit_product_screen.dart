import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/models/product.dart';
import 'package:loja_virtual_version2/screens/edit_product/components/images_form.dart';

class EditProductScreen extends StatelessWidget {

  EditProductScreen(this.product);
  final Product product;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Editar Anúncio"),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            ImagesForm(product),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    initialValue: product.name,
                    decoration: InputDecoration(
                      hintText: "Título",
                      // border: InputBorder.none // sem linha
                    ),
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      //color: Colors.grey[700],
                    ),
                    validator: (titulo){
                      if(titulo.length < 6 )
                        return 'Título muito curto.';
                      else 
                        return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      "A partir de",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13,
                      )
                    )
                  ),
                  Text(
                    'R\$ ...',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      'Descrição',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ),
                  TextFormField(
                    initialValue: product.description,
                    decoration: const InputDecoration(
                      hintText: "",
                    ),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: null,
                    validator: (desc){
                      if( desc.isEmpty )
                        return 'Descrição vazia.';
                      else 
                        return null;
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        print("Válido");
                      } else {
                        print("Invalido");
                      }
                    },
                    child: const Text("Salvar"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

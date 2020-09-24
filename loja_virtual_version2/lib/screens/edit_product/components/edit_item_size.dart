import 'package:flutter/material.dart';
import 'package:loja_virtual_version2/commom/custom_icon_button.dart';
import 'package:loja_virtual_version2/models/item_size.dart';

class EditItemSize extends StatelessWidget {

  const EditItemSize({Key key,this.size, this.onRemove, this.onMoveUp, this.onMoveDown}) : super( key: key );
  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDown;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 40,
          child: TextFormField(
            initialValue: size.name,
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
              labelText: 'Titulo',
              isDense: true,
            ),
            validator: (titulo){
              if(titulo.isEmpty)
                return "Inválido";
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 20,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Estoque',
              isDense: true,
            ),
            validator: (stock){
              if( int.tryParse(stock) == null )
                return "Inválido";
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        SizedBox(width: 4,),
        Expanded(
          flex: 40,
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            initialValue: size.price?.toStringAsFixed(2),
            decoration: InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: "R\$ ",
            ),
            validator: (price){
              if( num.tryParse( price ) == null )
                return "Inválido";
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIconButton(
          iconData: Icons.close,
          color: Colors.red,
          ontap: onRemove,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          ontap: onMoveUp,
        ),
        CustomIconButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          ontap: onMoveDown,
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:findyourfit/dress_model.dart' as alpha;
import 'package:get/get.dart';
import 'dress_model.dart';

class SellerInput extends StatefulWidget {
  Dress dress;

  SellerInput({this.dress});

  @override
  _SellerInputState createState() => _SellerInputState(dress);
}

class _SellerInputState extends State<SellerInput> {
  GlobalKey<FormState> _key = GlobalKey();
  bool _autoValidate = false;
  Dress dress;

  _SellerInputState(this.dress);

  String DressType, small, medium, large;
  String Kurta, Top, Formal_Shirt, Jeans;
  List<DropdownMenuItem<String>> items = [
    DropdownMenuItem(child: Text('Kurta')),
    DropdownMenuItem(child: Text('Top')),
    DropdownMenuItem(child: Text('Formal Shirt')),
    DropdownMenuItem(child: Text('Jeans')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seller Input',
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _key,
            autovalidate: _autoValidate,
            child: FormUI(),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(hintText: 'Description of Garment line1'),
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
          onSaved: (val) {
            widget.dress.dressName = val;
          },
        ),
        TextFormField(
          decoration:
          InputDecoration(hintText: 'Description Of Garment line2 '),
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
        ),
        DropdownButton(
          items: items,
          value: DressType,
          onChanged: (val) {
            hint:
            Text(
              DressType = val,
            );
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Price'),
          onSaved: (val) {
            widget.dress.price = val;
          },
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Display Image URL'),
          onSaved: (val) {
            widget.dress.imageURL = val;
          },
        ),
        RaisedButton(
          onPressed: _sendToServer,
          child: Text('Upload'),
          color: Colors.black,)
      ],


      // RaisedButton(
      //   onPressed: _sendToServer,
      //   child: Text('Upload'),
      //   color: Colors.black,)
      //
      //
      //
      // RaisedButton(
      // onPressed: _sendToServer,
      // child: Text('Upload'),
      // color: Colors.black,)
      // ],
      //
      //
      //     RaisedButton(
      //       onPressed: _sendToServer,
      //       child: Text('Upload'),
      //       color: Colors.black,)
      //   ],
    );
  }

  _sendToServer() {
    if (_key.currentState.validate()){
      _key.currentState.save();
    }else{
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
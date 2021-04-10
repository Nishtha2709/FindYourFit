import 'dart:io';
import 'package:findyourfit/MediumScreenInput.dart';
import 'package:findyourfit/large_size_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:findyourfit/dress_model.dart' as alpha;
import 'package:get/get.dart';
import 'dress_model.dart';
import 'package:findyourfit/camera_input.dart';
import 'package:findyourfit/small_size_input.dart';

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
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Seller Input',
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Expanded(
            child: Container(
              //padding: EdgeInsets.all(),
              child: Form(
                key: _key,
                autovalidate: _autoValidate,
                child: FormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget FormUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
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
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration:
              InputDecoration(hintText: 'Description Of Garment line2 '),
          inputFormatters: [
            LengthLimitingTextInputFormatter(20),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        DropdownButton(
          items: items,
          value: DressType,
          onChanged: (val) {
            hint:
            Text(
              DressType = val,
            );
            setState(() {
              DressType;
            });
          },

        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Price'),
          onSaved: (val) {
            widget.dress.price = val;
          },
        ),
        SizedBox(
          height: 20,
        ),
        TextFormField(
          decoration: InputDecoration(hintText: 'Display Image URL'),
          onSaved: (val) {
            widget.dress.imageURL = val;
          },
        ),
        SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SmallScreenInput(),
                  ),
                );
              },
              child: Text(
                'SMALL',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.black,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MediumScreenInput(),
                  ),
                );
              },
              child: Text(
                'MEDIUM',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.black,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LargeScreenInput(),
                  ),
                );
              },
              child: Text(
                'LARGE',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.black,
            ),
          ],
        ),
      ],
    );
  }
}

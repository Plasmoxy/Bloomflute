import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _storedImage;

  Future<void> _takePicture() async {
    final imageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    setState(() => _storedImage = imageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        width: 200,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.blue,
          ),
        ),
        child: _storedImage == null
            ? Text('No image taken', textAlign: TextAlign.center)
            : Image.file(
                _storedImage,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
        alignment: Alignment.center,
      ),
      SizedBox(width: 10),
      Expanded(
        child: FlatButton.icon(
          icon: Icon(Icons.camera),
          label: Text('Take picture'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _takePicture,
        ),
      ),
    ]);
  }
}

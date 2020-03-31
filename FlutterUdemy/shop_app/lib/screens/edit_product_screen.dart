import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const route = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  void _onImgUrlLostFocus() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  void _saveProduct() {}

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_onImgUrlLostFocus);
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(_onImgUrlLostFocus);
    _imageUrlFocus.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit product.'),
      ),
      // the formmmm
      body: Form(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: 100,
          ),
          child: Column(
            children: <Widget>[
              // title
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_priceFocus),
              ),
              SizedBox(height: 10),

              // price
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocus,
                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_descriptionFocus),
              ),
              SizedBox(height: 10),

              // description
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocus,
              ),
              SizedBox(height: 10),

              // image
              Row(children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  margin: EdgeInsets.only(top: 8, right: 10),
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.blue),
                  ),
                  child: _imageUrlController.text.isEmpty
                      ? Center(child: Text('preview'))
                      : FittedBox(
                          child: Image.network(
                            _imageUrlController.text,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _imageUrlController,
                    onFieldSubmitted: (x) => setState(null),
                    focusNode: _imageUrlFocus,
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _saveProduct,
      ),
    );
  }
}

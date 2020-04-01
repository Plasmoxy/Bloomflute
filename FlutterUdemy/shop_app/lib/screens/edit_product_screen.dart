import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/product.dart';
import 'package:shop_app/model/products.dart';

class EditProductScreen extends StatefulWidget {
  static const route = '/edit-product';
  final String productId;

  EditProductScreen(this.productId);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _form = GlobalKey<FormState>();

  var _formTitle = '';
  var _formPrice = 0.0;
  var _formDescription = '';
  var _formImageUrl = '';

  void _onImgUrlLostFocus() {
    if (!_imageUrlFocus.hasFocus) {
      setState(() {});
    }
  }

  void _saveForm() {
    if (!_form.currentState.validate()) return;
    _form.currentState.save();

    if (widget.productId != null) {
      // update a product
      final before = Provider.of<Products>(context, listen: false).findById(widget.productId);

      Provider.of<Products>(context, listen: false).updateProduct(
        widget.productId,
        Product(
          title: _formTitle,
          description: _formDescription,
          imageUrl: _formImageUrl,
          price: _formPrice,
          id: before.id,
          isFavorite: before.isFavorite,
        ),
      );
    } else {
      // save em product if new
      Provider.of<Products>(context, listen: false).addProduct(Product(
        title: _formTitle,
        description: _formDescription,
        imageUrl: _formImageUrl,
        price: _formPrice,
        id: null,
      ));
    }

    // leave this page on save
    Navigator.of(context).pop();
  }

  // note ! cannot use ModalRoute within initstate
  // in initstate, the state hasn't yet loaded its dependencies
  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(_onImgUrlLostFocus);
  }

  @override
  void didChangeDependencies() {
    if (widget.productId != null) {
      final product = Provider.of<Products>(context, listen: false).findById(widget.productId);
      // preset the fields
      _formTitle = product.title;
      _formDescription = product.description;
      _formImageUrl = product.imageUrl;
      _formPrice = product.price;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.removeListener(_onImgUrlLostFocus);
    _imageUrlFocus.dispose();
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
        key: _form,
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
                initialValue: _formTitle,
                onSaved: (value) => _formTitle = value,
                validator: (value) => value.isEmpty ? 'Title musn\'t be empty!' : null,
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
                initialValue: _formPrice.toString(),
                onSaved: (value) => _formPrice = double.parse(value),
                validator: (value) {
                  if (value.isEmpty) return 'Please enter a price!';
                  if (double.tryParse(value) == null || double.parse(value) < 0.0) return 'Please enter a valid price!';
                  return null;
                },
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
                initialValue: _formDescription,
                onSaved: (value) => _formDescription = value,
                validator: (value) => value.isEmpty ? 'Description musn\'t be empty!' : null,
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
                  child: _formImageUrl.isEmpty
                      ? Center(child: Text('preview'))
                      : FittedBox(
                          child: Image.network(
                            _formImageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
                Expanded(
                  child: TextFormField(
                    onFieldSubmitted: (x) => setState(null),
                    focusNode: _imageUrlFocus,
                    decoration: InputDecoration(
                      labelText: 'Image URL',
                      border: OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                    keyboardType: TextInputType.url,
                    textInputAction: TextInputAction.done,
                    onChanged: (tx) => _formImageUrl = tx,
                    onSaved: (value) => _formImageUrl = value,
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: _saveForm,
      ),
    );
  }
}

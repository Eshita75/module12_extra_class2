import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:module12_extra_class2/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreen();
}

class _UpdateProductScreen extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();
  bool _updateProductinProgress = false;

  @override
  void initState() {
    _nameTEController.text =  widget.product.productName;
    _unitPriceTEController.text = widget.product.unitPrice;
    _quantityTEController.text = widget.product.quantity;
    _totalPriceTEController.text = widget.product.totalPrice;
    _productCodeTEController.text = widget.product.productCode;
    _imageTEController.text = widget.product.image;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Add new product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formState,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    hintText: 'Name',
                    labelText: 'Name'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product name';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Unit Price',
                    labelText: 'Unit Price'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product unit price';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product quantity';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Total Price',
                    labelText: 'Total Price'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product total price';
                    }
                    return null;
                  },
                ),

                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.text,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      hintText: 'Product Code',
                      labelText: 'Product Code'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Write your product code';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 16,
                ),

                TextFormField(
                  controller: _imageTEController,
                  decoration: InputDecoration(
                      hintText: 'Image',
                      labelText: 'Image'
                  ),
                  validator: (String? value){
                    if(value == null || value.trim().isEmpty){
                      return 'Enter your image';
                    }
                    return null;
                  },

                ),

                SizedBox(
                  height: 16,
                ),

                Visibility(
                  visible: _updateProductinProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(onPressed: (){
                    if(_formState.currentState!.validate()){
                      _updateProduct();
                    }
                  },
                    style: ElevatedButton.styleFrom(
                    ),
                    child: const Text('update'),),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //future , async, await
  Future<void> _updateProduct() async{
    _updateProductinProgress = true;
    setState(() {});
    //Step -1: set url
    String updateProductURL = 'https://crud.teamrabbil.com/api/v1/UpdateProduct/${widget.product.id}';

    Map<String, dynamic> inputData = {
      "Img":_imageTEController.text.trim(),
      "ProductCode":_productCodeTEController.text,
      "ProductName":_nameTEController.text,
      "Qty":_quantityTEController.text,
      "TotalPrice":_totalPriceTEController.text,
      "UnitPrice":_unitPriceTEController.text
    };

    //URI - Uniform Resource Identifier
    //3. parse URL to uri(make uri from URL)
    Uri uri = Uri.parse(updateProductURL);
    //4. send request
    Response response = await post(uri, body: jsonEncode(inputData), headers: {
      'content-type': 'application/json'
    });
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    _updateProductinProgress = false;
    setState(() {});
    if(response.statusCode == 200){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product has been updated'))
      );
      Navigator.pop(context, true);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Update product failed try again'))
      );
    }
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    _productCodeTEController.dispose();
    super.dispose();
  }
}

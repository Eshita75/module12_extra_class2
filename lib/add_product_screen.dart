import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreen();
}

class _AddProductScreen extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  bool _addNewProductInProgress  = false;
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
                    if(value == null || value.trim().isEmpty){//trim use hobe cz jodi space deua thake tahole seta trim korte
                      return 'Write your product name';
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
                  visible: _addNewProductInProgress == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(onPressed: (){
                  if(_formState.currentState!.validate()){
                    _addProduct();
                  }
                },
                    style: ElevatedButton.styleFrom(
                    ),
                    child: Text('add'),),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  //future , async, await
  Future<void> _addProduct() async{
    _addNewProductInProgress = true;
    setState(() {

    });
    //Step -1: set url
    String addNewProductURL = 'https://crud.teamrabbil.com/api/v1/CreateProduct';
    //2. prepare data
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
    Uri uri = Uri.parse(addNewProductURL);
    //4. send request
    Response response = await post(uri, body: jsonEncode(inputData), headers: {
      'content-type': 'application/json'
    });
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    _addNewProductInProgress = false;
    setState(() {});
    if(response.statusCode == 200){
      _nameTEController.clear();
      _productCodeTEController.clear();
      _unitPriceTEController.clear();
      _totalPriceTEController.clear();
      _quantityTEController.clear();
      _imageTEController.clear();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Add new product failed try again'))
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
    super.dispose();
  }
}

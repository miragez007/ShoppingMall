import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shoppingmall/ultility/my_constant.dart';
import 'package:shoppingmall/ultility/my_dialog.dart';
import 'package:shoppingmall/widgets/show_image.dart';
import 'package:shoppingmall/widgets/show_title.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final formKey = GlobalKey<FormState>();
  List<File?> files = [];
  File? file;


  void initState() {
    super.initState();
    initialFile();
  }

  void initialFile() {
    for (var i = 0; i < 4; i++) {
      files.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [IconButton(onPressed: ()=> processAddProduct(), icon: Icon(Icons.cloud_upload))],
        title: Text('Add Product'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    buildProductName(constraints),
                    buildProductPrice(constraints),
                    buildProductDetail(constraints),
                    buildImage(constraints),
                    buildProductButton(constraints),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container buildProductButton(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth * 0.75,
      child: ElevatedButton(
        style: MyConstant().myButtonStyle(),
        onPressed: () {
          processAddProduct();
        },
        child: Text('Add Product'),
      ),
    );
  }

  void processAddProduct() {
    if (formKey.currentState!.validate()) {

      bool checkFile = true;
      for (var item in files) {
        if (item == null) {
          checkFile = false;          
        }
      }
      if (checkFile) {
        print('## choose 4 image success');
      } else {
        MyDialog().normalDialog(context, 'More Image', 'Plase Choose More Image');
      }
    }
  }

  Future<Null> processImagePicker(ImageSource source, int index) async {
    try {
      var result = await ImagePicker().getImage(
        source: source,
        maxHeight: 800,
        maxWidth: 800,
      );
      setState(() {
        file = File(result!.path);
        files[index] = file;
      });
    } catch (e) {}
  }

  Future<Null> chooseSourceImageDaialog(int index) async {
    print('Click Form index ==>> $index');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.image4),
          title: ShowTitle(
            title: 'Sourece Image ${index + 1}?',
            textStyle: MyConstant().h2Style(),
          ),
          subtitle: ShowTitle(
            title: 'Plase tab on Camera or Gallery',
            textStyle: MyConstant().h3Style(),
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.camera, index);
                },
                child: Text('Camera'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  processImagePicker(ImageSource.gallery, index);
                },
                child: Text('Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column buildImage(BoxConstraints constraints) {
    return Column(
      children: [
        Container(
          width: constraints.maxWidth * 0.75,
          height: constraints.maxWidth * 0.75,
          child:
              file == null ? Image.asset(MyConstant.image5) : Image.file(file!),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: constraints.maxWidth * 0.75,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceImageDaialog(0),
                  child: files[0] == null
                      ? Image.asset(MyConstant.image5)
                      : Image.file(
                          files[0]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceImageDaialog(1),
                  child: files[1] == null
                      ? Image.asset(MyConstant.image5)
                      : Image.file(
                          files[1]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceImageDaialog(2),
                  child: files[2] == null
                      ? Image.asset(MyConstant.image5)
                      : Image.file(
                          files[2]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Container(
                width: 48,
                height: 48,
                child: InkWell(
                  onTap: () => chooseSourceImageDaialog(3),
                  child: files[3] == null
                      ? Image.asset(MyConstant.image5)
                      : Image.file(
                          files[3]!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget buildProductName(BoxConstraints constraints) {
  return Container(
    width: constraints.maxWidth * 0.75,
    margin: EdgeInsets.only(top: 16),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Plase Fill Name in Blank';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelStyle: MyConstant().h3Style(),
        labelText: "Name Product",
        prefixIcon: Icon(
          Icons.production_quantity_limits,
          color: MyConstant.dark,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyConstant.dark),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyConstant.light),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

Widget buildProductPrice(BoxConstraints constraints) {
  return Container(
    width: constraints.maxWidth * 0.75,
    margin: EdgeInsets.only(top: 16),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Plase Fill Price in Blank';
        } else {
          return null;
        }
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelStyle: MyConstant().h3Style(),
        labelText: "Price Product",
        prefixIcon: Icon(
          Icons.money,
          color: MyConstant.dark,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyConstant.dark),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyConstant.light),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

Widget buildProductDetail(BoxConstraints constraints) {
  return Container(
    width: constraints.maxWidth * 0.75,
    margin: EdgeInsets.only(top: 16),
    child: TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Plase Fill Detail in Blank';
        } else {
          return null;
        }
      },
      maxLines: 4,
      decoration: InputDecoration(
        hintStyle: MyConstant().h3Style(),
        hintText: "Product Detail",
        prefixIcon: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
          child: Icon(
            Icons.details_outlined,
            color: MyConstant.dark,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyConstant.dark),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: MyConstant.light),
          borderRadius: BorderRadius.circular(20),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    ),
  );
}

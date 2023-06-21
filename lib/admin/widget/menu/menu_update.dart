import 'dart:io';

import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mantan_pos/system/menu.dart';

class MenuUpdate extends StatefulWidget {
  const MenuUpdate({super.key,required this.uid});
  final String uid;

  @override
  State<MenuUpdate> createState() => _MenuUpdateState();
}

class _MenuUpdateState extends State<MenuUpdate> {
  TextEditingController nameController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  SingleValueDropDownController categoryController = SingleValueDropDownController();

  File? file;
  ImagePicker image = ImagePicker();
  Uint8List webImage = Uint8List(8);
  bool oldImage = true;
  bool firstLoad = false;
  var oldUrl;

  getImage() async {
    XFile? img = await image.pickImage(source: ImageSource.gallery);
    var f = await img!.readAsBytes();
    if(img != null){
      setState(() {
        webImage = f;
        file = File(img.path);
        oldImage = false;
      });
    }
  }

  submit(BuildContext context){
    var name = nameController.text;
    var deskripsi = deskripsiController.text;
    var harga = (int.parse((hargaController.text).replaceAll(RegExp("[a-zA-Z:\s. ()]"),''))).toString();
    var kategori = categoryController.dropDownValue!.value;

    var data = {
      "name" : name,
      "deskripsi" : deskripsi,
      "harga" : harga,
      "kategori" : kategori,
    };
    file = File("f");
    
    Menu.updateMenu(context, data, webImage, file!,oldUrl,oldImage,widget.uid);
  }

  @override
  void initState() {
    if (firstLoad == false) {
      try {
        FirebaseDatabase.instance.ref().child('menu').child(widget.uid).onValue.listen((event) async {
          var data = event.snapshot.value as Map;

          setState(() {
            oldUrl = data['image'];
          });
          nameController.text = data['name'];
          deskripsiController.text = data['deskripsi'];
          hargaController.text = data['harga'];
          categoryController = SingleValueDropDownController(data: DropDownValueModel(value: "${data['kategori']}", name: "${data['kategori']}"));
          firstLoad = true;
        }); 
      } catch (e) {
        print(e); 
      }
    }
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      scrollable: true,
      backgroundColor: Colors.transparent,
      content: Builder(builder: (context){
        return Container(
          padding: EdgeInsets.all(15),
          width: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            children: [
              Text(
                "Tambah Menu",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: oldUrl == null
                  ? ( file == null ?
                  Tooltip(
                    message: "Upload Image",
                    child: IconButton(
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 90,
                          color: Color.fromARGB(255, 179, 179, 179),
                        ),
                        onPressed: () {
                          getImage();
                        },
                      ),
                  ):
                  Tooltip(
                    message: "Upload Image",
                    child: MaterialButton(
                      height: 100,
                      child: kIsWeb ? Image.memory(webImage!,fit: BoxFit.fill,)
                          : Image.file(file!,fit: BoxFit.fill,),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ))
                  : ( file == null ?
                  Tooltip(
                    message: "Upload Image",
                    child: MaterialButton(
                      height: 100,
                      child: Image.network(oldUrl!,fit: BoxFit.fill,),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ):
                  Tooltip(
                    message: "Upload Image",
                    child: MaterialButton(
                      height: 100,
                      child: kIsWeb ? Image.memory(webImage!,fit: BoxFit.fill,)
                          : Image.file(file!,fit: BoxFit.fill,),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  )
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  color: Colors.black
                ),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Nama Menu",
                  labelText: "Nama Menu",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 230, 230, 230),
                  prefixIconColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: deskripsiController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                minLines: 1,
                maxLines: 3,
                style: TextStyle(
                  color: Colors.black
                ),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: "Deskripsi Menu",
                  labelText: "Deskripsi Menu",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 230, 230, 230),
                  prefixIconColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextFormField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                style: TextStyle(
                  color: Colors.black
                ),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                  CurrencyTextInputFormatter(
                    locale: 'ID',
                    decimalDigits: 0,
                    symbol: 'Rp. ',
                  ),
                ],
                decoration: InputDecoration(
                  hintText: "Harga Menu",
                  labelText: "Harga Menu",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 230, 230, 230),
                  prefixIconColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              DropDownTextField(
                controller: categoryController,
                dropDownList: [
                  DropDownValueModel(name: 'Coffee', value: "coffee"),
                  DropDownValueModel(name: 'Non Coffee', value: "non coffee"),
                  DropDownValueModel(name: 'Noodle', value: "noodle"),
                  DropDownValueModel(name: 'Snack', value: "snack"),
                ],
                clearOption: true,
                enableSearch: true,
                textStyle: TextStyle(
                  color: Colors.black
                ),
                searchDecoration: const InputDecoration(
                    hintText: "enter your custom hint text here"),
                validator: (value) {
                  if (value == null) {
                    return "Required field";
                  } else {
                    return null;
                  }
                },
                textFieldDecoration: InputDecoration(
                  hintText: "Pilih Ketegori Menu",
                  labelText: "Pilih Ketegori Menu",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  filled: true,
                  fillColor: Color.fromARGB(255, 230, 230, 230),
                  prefixIconColor: Colors.black,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3,color: const Color.fromARGB(255, 230, 230, 230)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              InkWell(
                onTap: (){
                  if(deskripsiController.text == '' || hargaController.text == '' || nameController.text == "" || categoryController.dropDownValue!.value == ""){
                    EasyLoading.showError('Please Input All Form',dismissOnTap: true);
                    return;
                  }
                  submit(context);
                  EasyLoading.show(status: 'loading...');
                }, 
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF399D44),
                  ),
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  width: 350,
                  child: Text(
                    "Tambah Menu",
                    style: GoogleFonts.roboto(
                      color:Colors.white,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                )
              ),
            ],
          ),
        );
      }),
    );
  }
}
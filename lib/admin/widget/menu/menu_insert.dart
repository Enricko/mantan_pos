import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuInsert extends StatefulWidget {
  const MenuInsert({super.key});

  @override
  State<MenuInsert> createState() => _MenuInsertState();
}

class _MenuInsertState extends State<MenuInsert> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SingleValueDropDownController roleController = SingleValueDropDownController();

  submit(BuildContext context){
    var name = nameController.text;
    var email = emailController.text;
    var password = passwordController.text;
    var role = roleController.dropDownValue!.value;

    var data = {
      "name" : name,
      "email" : email,
      "password" : password,
      "role" : role,
    };
    
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
                "Tambah User",
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 18,
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
                  hintText: "Your Name",
                  labelText: "Your Name",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.abc),
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
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
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
                  hintText: "Your Email",
                  labelText: "Your Email",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.email),
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
                controller: passwordController,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
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
                  hintText: "Your Password",
                  labelText: "Your Password",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.password),
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
                controller: roleController,
                dropDownList: [
                  DropDownValueModel(name: 'Kasir', value: "kasir"),
                  DropDownValueModel(name: 'Admin', value: "admin"),
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
                  hintText: "Choose Role",
                  labelText: "Choose Role",
                  hintStyle: TextStyle(
                    color: Colors.black
                  ),
                  labelStyle: TextStyle(
                    color: Colors.black
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.people),
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
                  if(emailController.text == '' || passwordController.text == '' || nameController.text == "" || roleController.dropDownValue!.value == ""){
                    EasyLoading.showError('Please Input All Form',dismissOnTap: true);
                    return;
                  }
                  submit(context);
                  EasyLoading.show(status: 'loading...');
                }, 
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.center,
                  width: 350,
                  child: Text(
                    "Tambah User",
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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fooddeliveryapp/servise/database.dart';
import 'package:fooddeliveryapp/widget/widget_support.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  final List<String> items = ['  Ice-cream', '  Pizza', '  Salad', '  Burger'];
  String? value;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController detailcontroller = TextEditingController();
  TextEditingController imagescontroller = TextEditingController();
  String? selectedImage;

  uploadItem() async {
    if (imagescontroller.text != "" &&
        namecontroller.text != "" &&
        pricecontroller.text != "" &&
        detailcontroller.text != "") {
      Map<String, dynamic> addItem = {
        "Images": imagescontroller.text,
        "Name": namecontroller.text,
        "Price": pricecontroller.text,
        "Detail": detailcontroller.text
      };
      await FirebaseFirestore.instance
          .collection(value!.trim())
          .add(addItem)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: orange,
            content: Text(
              "Food Item has been added Successfully",
              style: textStyle18,
            )));
      }).catchError((e) {
        print("Error adding item: $e");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        surfaceTintColor: white,
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          "Add Item",
          style: AppWidget.headlineTextFeildSyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Network URL the Item Picture",
                style: AppWidget.semiBoldTextFeildSyle(),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                decoration: BoxDecoration(
                    color: white1, borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 1,
                  controller: imagescontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Price",
                      hintStyle: AppWidget.lighTextFeildSyle()),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Item Name",
                style: AppWidget.semiBoldTextFeildSyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                decoration: BoxDecoration(
                    color: white1, borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  controller: namecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Name",
                      hintStyle: AppWidget.lighTextFeildSyle()),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Item Price",
                style: AppWidget.semiBoldTextFeildSyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                decoration: BoxDecoration(
                    color: white1, borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 1,
                  controller: pricecontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Price",
                      hintStyle: AppWidget.lighTextFeildSyle()),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Item Detail",
                style: AppWidget.semiBoldTextFeildSyle(),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                decoration: BoxDecoration(
                    color: white1, borderRadius: BorderRadius.circular(10)),
                child: TextField(
                  maxLines: 6,
                  controller: detailcontroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Item Detail",
                      hintStyle: AppWidget.lighTextFeildSyle()),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Select Category",
                style: AppWidget.semiBoldTextFeildSyle(),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: white1, borderRadius: BorderRadius.circular(10)),
                width: size.width,
                child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                          value: item, child: Text(item)))
                      .toList(),
                  onChanged: ((value) => setState(() {
                        this.value = value;
                      })),
                  dropdownColor: white,
                  hint: Text(
                    "  Select Category",
                  ),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: black,
                  ),
                  iconSize: 36,
                  value: value,
                )),
              ),
              SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: uploadItem,
                child: Center(
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: black,
                          borderRadius: BorderRadius.circular(10)),
                      width: 150,
                      child: Text(
                        textAlign: TextAlign.center,
                        "Add",
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

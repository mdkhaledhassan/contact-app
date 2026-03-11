import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Box? myBox;
  Box? myBox1;

  @override
  void initState() {
    myBox = Hive.box('myBox');
    myBox1 = Hive.box('myBox1');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Contact'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  label: Text('Enter Name'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: numberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('Enter Phone Number'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    if (nameController.text.isNotEmpty &&
                        numberController.text.isNotEmpty) {
                      myBox!.add(nameController.text);
                      myBox1!.add(numberController.text);

                      setState(() {});
                    }
                  }
                  Get.back();
                  print('added');
                },
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text('Save', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

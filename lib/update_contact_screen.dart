import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class UpdateContactScreen extends StatefulWidget {
  const UpdateContactScreen({super.key, required this.index});
  final int index;

  @override
  State<UpdateContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<UpdateContactScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Box? myBox;
  Box? myBox1;

  @override
  void initState() {
    super.initState();
    myBox = Hive.box('myBox');
    myBox1 = Hive.box('myBox1');
    nameController.text = myBox!.getAt(widget.index).toString();
    numberController.text = myBox1!.getAt(widget.index).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Contact'), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    label: Text('Enter Name'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    return null;
                  },
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
                        myBox!.putAt(widget.index, nameController.text);
                        myBox1!.putAt(widget.index, numberController.text);

                        setState(() {});
                        Get.back();
                      }
                    }
                    print('updated');
                  },
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:contact_app/add_contact_screen.dart';
import 'package:contact_app/update_contact_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBar(
        title: Text('Contact List'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                Get.to(() => AddContactScreen());
              },
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: Hive.box('myBox').listenable(),
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: myBox!.keys.toList().length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => UpdateContactScreen(index: index));
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.25),
                                offset: Offset(0, 5),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 12,
                              top: 5,
                              bottom: 5,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(myBox!.getAt(index).toString()),
                                Text(myBox1!.getAt(index).toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

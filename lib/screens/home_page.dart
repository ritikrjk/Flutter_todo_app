import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dodo/widget/item_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();

  var size, height;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: height / 1.3,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('items')
                        .orderBy('timestamp')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final post = snapshot.data!.docs[index];
                              return ItemTile(
                                  message: post['message'],
                                  onTap: () async {
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection('items')
                                          .doc(post.id)
                                          .delete();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Deleted Succesfuuly'),
                                        duration: Duration(milliseconds: 2000),
                                      ));
                                    } catch (e) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(e.toString()),
                                        backgroundColor: Colors.red,
                                        duration: Duration(milliseconds: 2000),
                                      ));
                                    }
                                  });
                            });
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error  ${snapshot.error.toString()} '),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    })),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: "Enter Note"),
                  )),
                  InkWell(
                    onTap: () {
                      if (controller.text.isNotEmpty) {
                        FirebaseFirestore.instance.collection('items').add({
                          'message': controller.text,
                          'timestamp': Timestamp.now()
                        });
                      }
                      setState(() {
                        controller.clear();
                      });
                      FocusScope.of(context).unfocus();
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        color: Colors.green,
                      ),
                      width: 60,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

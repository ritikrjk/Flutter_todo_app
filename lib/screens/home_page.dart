import 'package:flutter/material.dart';
import 'package:flutter_dodo/widget/item_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  List<String> todoList = [
    "Make Tutorial size xheck ho rha ha ki sha rehega ki nh",
    "Second task"
  ];

  var size, height;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                height: height / 1.3,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todoList.length,
                    itemBuilder: (context, index) {
                      return ItemTile(
                        message: todoList[index],
                        onTap: () => deleteMsg(index),
                      );
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
                      setState(() {
                        String msg = controller.text;
                        todoList.add(msg);
                        controller.clear();
                        FocusScope.of(context).unfocus();
                      });
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

  void deleteMsg(int index) {
    setState(() {
      todoList.removeAt(index);
    });
  }
}

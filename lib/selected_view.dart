import 'package:flutter/material.dart';
import 'package:timer_app/color_manager.dart';
import 'package:timer_app/main.dart';

class SelectedTime extends StatefulWidget {
  const SelectedTime({super.key});
  @override
  State<SelectedTime> createState() => _SelectedTimeState();
}

class _SelectedTimeState extends State<SelectedTime> {
  static int? valueChouse =5;
  List<int> itemsList = [5, 10, 15, 20, 25, 30];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.color5,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Select The Time of Game",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              decoration: BoxDecoration(
                  color: ColorManager.color1,
                  borderRadius: BorderRadius.circular(50)),
              child: DropdownButton(
                icon: const Icon(Icons.arrow_drop_down_circle),
                underline: const SizedBox(),
                dropdownColor: ColorManager.color4,
                hint: const Text(
                  "Game Time",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                items: itemsList.map((vlaueItem) {
                  return DropdownMenuItem(
                    value: vlaueItem,
                    child: Text(vlaueItem.toString()),
                  );
                }).toList(),
                onChanged: (newItem) {
                  setState(() {
                    valueChouse = newItem;
                  });
                },
                value: valueChouse,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
               // Navigator.of(context).push(MaterialPageRoute(builder:(context) => ChessClock(),));
                Navigator.pushNamed(context, "/second",arguments: valueChouse);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: ColorManager.color4,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Start The Game",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

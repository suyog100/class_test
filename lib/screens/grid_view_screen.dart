import 'package:flutter/material.dart';

class GridViewScreen extends StatefulWidget {
  final String name;
  GridViewScreen({required this.name});

  @override
  _GridViewScreenState createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<GridViewScreen> {
  late List<bool> buttonVisible;
  late List<bool> colorChanged;

  @override
  void initState() {
    super.initState();
    buttonVisible = List<bool>.filled(widget.name.length, true);
    colorChanged = List<bool>.filled(widget.name.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: _buildButtons(),
      ),
    );
  }

  List<Widget> _buildButtons() {
    List<Widget> buttons = [];
    List<Widget> hiddenButtons = [];  // To store invisible buttons and show them at the end if needed

    for (int index = 0; index < widget.name.length; index++) {
      Widget button = Visibility(
        visible: buttonVisible[index],
        child: ElevatedButton(
          child: Text(widget.name[index]),
          onPressed: () {
            setState(() {
              if (colorChanged[index]) {
                buttonVisible[index] = false;
              }
              colorChanged[index] = !colorChanged[index];
            });
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                if (colorChanged[index]) return Colors.tealAccent;
                return Colors.lime;
              },
            ),
          ),
        ),
        replacement: Container(),  // Use an empty container as a placeholder
      );

      if (buttonVisible[index]) {
        buttons.add(button);
      } else {
        hiddenButtons.add(button);  // Collect hidden buttons
      }
    }

    return buttons + hiddenButtons;  // Add hidden buttons at the end
  }
}

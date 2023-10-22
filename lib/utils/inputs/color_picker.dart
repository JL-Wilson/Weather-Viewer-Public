import 'package:flutter/material.dart';
import 'package:weatherapp3/utils/settings.dart';

class ColorPicker extends StatefulWidget {
  final Settings settings;

  const ColorPicker({Key? key, required this.settings}) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPicker();
}

class _ColorPicker extends State<ColorPicker> {
  late final Settings settings;

  @override
  void initState() {
    settings = widget.settings;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 0);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.all(30),
                    ),
                    child: Container()),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 1);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.all(30),
                    ),
                    child: Container()),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 2);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.yellow,
                      padding: const EdgeInsets.all(30),
                    ),
                    child: Container()),
              ),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 3);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.all(30),
                    ),
                    child: Container()),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 4);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.all(30),
                    ),
                    child: Container()),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 5);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.indigo,
                        padding: const EdgeInsets.all(30)),
                    child: Container()),
              ),
            ]),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 6);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.all(30)),
                    child: Container()),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 7);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: const Color.fromRGBO(14, 134, 212, 1),
                      padding: const EdgeInsets.all(30),
                    ),
                    child: Container()),
              ),
            ]),
      ],
    );
  }
}

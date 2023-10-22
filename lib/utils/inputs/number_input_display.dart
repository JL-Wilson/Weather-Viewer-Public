import 'package:flutter/material.dart';

class NumberInputDisplay extends StatefulWidget {
  final String startingValue;

  const NumberInputDisplay({Key? key, required this.startingValue})
      : super(key: key);

  @override
  State<NumberInputDisplay> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInputDisplay> {
  String inputtedValue = "";

  @override
  void initState() {
    inputtedValue = widget.startingValue;

    super.initState();
  }

  addDigit(digit) {
    setState(() {
      if (inputtedValue.length > 7) {
      } else {
        inputtedValue = inputtedValue + digit;
      }
    });
  }

  backspace() {
    setState(() {
      inputtedValue = inputtedValue.substring(0, inputtedValue.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                width: 1,
              ),
            ),
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    inputtedValue,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            backspace();
                          },
                          icon: Icon(
                            Icons.backspace_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          )),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context, inputtedValue);
                        },
                        icon: Icon(
                          Icons.done,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("0");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "0",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("1");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "1",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("2");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "2",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("3");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "3",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("4");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "4",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
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
                    addDigit("5");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "5",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("6");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "6",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("7");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "7",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("8");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "8",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2),
                child: ElevatedButton(
                  onPressed: () {
                    addDigit("9");
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(20)),
                  child: Text(
                    "9",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
              ),
            ]),
      ],
    );
  }
}

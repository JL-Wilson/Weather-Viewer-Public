import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weatherapp3/utils/platform_type.dart';

class NumberInput extends StatefulWidget {
  final String startingValue;

  const NumberInput({Key? key, required this.startingValue}) : super(key: key);

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  TextEditingController textInput = TextEditingController();

  @override
  void initState() {
    textInput.text = widget.startingValue;

    super.initState();
  }

  addDigit(digit) {
    setState(() {
      textInput.text = textInput.text + digit;
    });
  }

  backspace() {
    setState(() {
      if (textInput.text.isNotEmpty) {
        textInput.text = textInput.text.substring(0, textInput.text.length - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.enter): () {
          setState(() {
            Navigator.pop(context, textInput.text);
          });
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                child: TextField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  controller: textInput,
                  autofocus:
                      SystemInformation().getAppType(context) == AppType.desktop
                          ? true
                          : false,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ),
          SystemInformation().getAppType(context) == AppType.desktop
              ? Padding(
                  padding: const EdgeInsets.all(4),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, textInput.text);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20)),
                    child: Icon(
                      Icons.done,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              : Container(),
          SystemInformation().getAppType(context) != AppType.desktop
              ? Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () {
                                addDigit("1");
                              },
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20),
                              ),
                              child: Text(
                                "1",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () {
                                addDigit("2");
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20)),
                              child: Text(
                                "2",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () {
                                addDigit("3");
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20)),
                              child: Text(
                                "3",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () {
                                addDigit("4");
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20)),
                              child: Text(
                                "4",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () {
                                addDigit("5");
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20)),
                              child: Text(
                                "5",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () {
                                addDigit("6");
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20)),
                              child: Text(
                                "6",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                        ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(
                            onPressed: () {
                              addDigit("7");
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20)),
                            child: Text(
                              "7",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(
                            onPressed: () {
                              addDigit("8");
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20)),
                            child: Text(
                              "8",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(
                            onPressed: () {
                              addDigit("9");
                            },
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(20)),
                            child: Text(
                              "9",
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                                onPressed: () {
                                  backspace();
                                },
                                style: ElevatedButton.styleFrom(
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(20),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.error),
                                child: Icon(
                                  Icons.backspace_rounded,
                                  color: Theme.of(context).colorScheme.onError,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () {
                                addDigit("0");
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20)),
                              child: Text(
                                "0",
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context, textInput.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(20),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary),
                              child: Icon(
                                Icons.done,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ]),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:process_run/shell.dart';

class ShutdownLoadingPage extends StatefulWidget {
  const ShutdownLoadingPage({Key? key}) : super(key: key);

  @override
  State<ShutdownLoadingPage> createState() => _ShutdownLoadingPageState();
}

class _ShutdownLoadingPageState extends State<ShutdownLoadingPage> {
  @override
  void initState() {
    super.initState();
    main();
  }

  void main() async {
    var shell = Shell();
    await shell.run("sudo shutdown -h now");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text("Shutting down..."),
          ],
        )),
      ],
    ));
  }
}

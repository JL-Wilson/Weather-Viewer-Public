import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:weatherapp3/screens/boot/login_page.dart';
import 'package:weatherapp3/utils/data.dart';
import 'package:weatherapp3/utils/settings.dart';

class AccountSettingsPage extends StatefulWidget {
  final Settings settings;
  final CurrentDataSlice latestData;

  const AccountSettingsPage(
      {Key? key, required this.settings, required this.latestData})
      : super(key: key);

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  bool _isSendingVerification = false;
  bool _isSigningOut = false;

  User? user = FirebaseAuth.instance.currentUser;

  late Settings _settings;
  late final CurrentDataSlice latestData;

  @override
  void initState() {
    _settings = widget.settings;
    latestData = widget.latestData;

    super.initState();
  }

  Widget _verificaitonButtonWidget = const Text("Verify Email");

  Widget verificationMessage() {
    if (user!.emailVerified) {
      return Text('Email verified',
          style: Theme.of(context)
              .textTheme
              .labelLarge!
              .copyWith(color: Colors.green));
    } else {
      return ElevatedButton(
        onPressed: () async {
          setState(() {
            _verificaitonButtonWidget = const CircularProgressIndicator();
            _isSendingVerification = true;
          });
          await user?.sendEmailVerification();
          setState(() {
            _verificaitonButtonWidget = Text("Email Sent",
                style: Theme.of(context).textTheme.labelLarge);
            _isSendingVerification = false;
          });
        },
        child: _verificaitonButtonWidget,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Account Settings",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        elevation: 0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            child: ListTile(
              title: Text(
                "Name",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Text(
                user!.displayName!,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          Card(
            child: ListTile(
              title: Text(
                "ID",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Text(
                user!.uid,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ),
          Card(
            color: Theme.of(context).colorScheme.error,
            elevation: 2,
            child: InkWell(
              onTap: () async {
                setState(() {
                  _isSigningOut = true;
                });
                await FirebaseAuth.instance.signOut();
                setState(() {
                  _isSigningOut = false;
                });
                if (mounted) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => LoginPage(latestData: latestData),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: _isSigningOut
                  ? const CircularProgressIndicator()
                  : ListTile(
                      title: Text(
                        "Sign Out",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onError),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

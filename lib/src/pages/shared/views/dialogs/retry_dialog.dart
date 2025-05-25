import 'package:flutter/material.dart';

class RetryDialog extends StatefulWidget {
  const RetryDialog({super.key});

  Future<void> show(BuildContext context) async => showDialog(
    context: context,
    useRootNavigator: false,
    builder: (_) => this,
  );

  @override
  State<StatefulWidget> createState() => _RetryDialog();
}

class _RetryDialog extends State<RetryDialog> {
  @override
  Widget build(BuildContext context) => Dialog.fullscreen(
    backgroundColor: Colors.transparent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.cancel),
        Text(
          'it looks like you are not connected to the internet, please check your connection\n and try again',
          style: TextStyle(color: Colors.white),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: Text('retry'),
        ),
      ],
    ),
  );
}

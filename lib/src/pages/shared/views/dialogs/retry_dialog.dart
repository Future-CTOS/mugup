import 'package:flutter/material.dart';

class RetryDialog extends StatefulWidget {
  const RetryDialog({
    super.key,
    required this.onRetryTapped,
    this.errorMessage =
        'it looks like you are not connected to the internet, please check your connection\n and try again',
  });

  final Future<void> Function() onRetryTapped;
  final String errorMessage;

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
  void dispose() {
    widget.onRetryTapped();
    super.dispose();
  }

  Future<void> onTap() async {
    Navigator.pop(context);
    return widget.onRetryTapped();
  }

  @override
  Widget build(BuildContext context) => Dialog.fullscreen(
    backgroundColor: Colors.transparent,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.cancel),
        Text(widget.errorMessage, style: TextStyle(color: Colors.white)),
        ElevatedButton(onPressed: onTap, child: Text('retry')),
      ],
    ),
  );
}

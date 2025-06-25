import 'package:flutter/material.dart';
import 'package:mugup/src/infrastructure/utils/extensions.dart';

import '../infrastructure/utils/utils.dart';

class MugupCounter extends StatefulWidget {
  const MugupCounter({
    super.key,
    required this.maxNumber,
    required this.minNumber,
    this.initialNumber = 1,
  });

  final int initialNumber;
  final int maxNumber;
  final int minNumber;

  @override
  State<MugupCounter> createState() => _MugupCounterState();
}

class _MugupCounterState extends State<MugupCounter> {
  late int _currentNumber;

  final Radius _radius = Radius.circular(Utils.semiMediumSpace);

  @override
  void initState() {
    _currentNumber = widget.initialNumber;
    super.initState();
  }

  void _onIncrease() {
    if (_currentNumber < widget.maxNumber) {
      setState(() => _currentNumber++);
    }
  }

  void _onDecrease() {
    if (_currentNumber > widget.minNumber) {
      setState(() => _currentNumber--);
    }
  }

  @override
  Widget build(final BuildContext context) {
    final theme = context.theme;
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(width: 1.3, color: theme.primaryColor),
        borderRadius: BorderRadius.circular(Utils.mediumSpace),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: Utils.mediumSpace,
        children: [
          _buildButton(
            context,
            onTap: _onDecrease,
            icon: Icons.minimize,
            borderRadius: BorderRadius.only(
              bottomLeft: _radius,
              topLeft: _radius,
            ),
          ),
          Text('$_currentNumber', style: theme.textTheme.displaySmall),
          _buildButton(
            context,
            onTap: _onIncrease,
            icon: Icons.add,
            borderRadius: BorderRadius.only(
              bottomRight: _radius,
              topRight: _radius,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required VoidCallback onTap,
    required IconData icon,
    required BorderRadiusGeometry borderRadius,
  }) {
    final theme = context.theme;
    return InkWell(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: borderRadius,
        ),
        child: Icon(icon, color: theme.secondaryHeaderColor),
      ),
    );
  }
}

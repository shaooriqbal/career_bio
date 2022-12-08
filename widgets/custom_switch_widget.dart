import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    Key? key,
    required this.value,
    required this.callback,
  }) : super(key: key);

  final bool value;
  final void Function(bool) callback;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  late bool _value;

  @override
  void initState() {
    _value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _CustomSwitch(
      value: _value,
      onChanged: (_) {
        _value = _;
        widget.callback(_value);
        setState(() {});
      },
      activeColor: Colors.white,
      inactiveColor: Colors.white,
    );
  }
}

class _CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;
  final Color inactiveColor;

  const _CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    required this.activeColor,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  @override
  State createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<_CustomSwitch>
    with SingleTickerProviderStateMixin {
  late Animation _circleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _circleAnimation = AlignmentTween(
      begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
      end: widget.value ? Alignment.centerLeft : Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            if (_animationController.isCompleted) {
              _animationController.reverse();
            } else {
              _animationController.forward();
            }
            widget.value == false
                ? widget.onChanged(true)
                : widget.onChanged(false);
          },
          child: Container(
            width: 60.0,
            height: 32.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: _circleAnimation.value == Alignment.centerLeft
                  ? Colors.grey
                  : widget.activeColor,
              gradient: _circleAnimation.value == Alignment.centerLeft
                  ? null
                  : orangeLinear(-1.0, 0.0, 1, 0.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _circleAnimation.value == Alignment.centerRight
                      ? const Spacer()
                      : const Center(),
                  Align(
                    alignment: _circleAnimation.value,
                    child: Container(
                      width: 26.0,
                      height: 26.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _circleAnimation.value == Alignment.centerLeft
                      ? const Spacer()
                      : const Center(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  LinearGradient orangeLinear(double x1, double y1, double x2, double y2) {
    return LinearGradient(
      begin: Alignment(x1, y1),
      end: Alignment(x2, y2),
      colors: const [Color(0xff7592D3), Color(0xffE0DFA0)],
    );
  }
}

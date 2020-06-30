import 'package:flutter/material.dart';

class Cover extends StatefulWidget {
  const Cover({
    Key key,
    @required this.onTap,
    this.onFocus,
    this.child,
  }) : super(key: key);
  final Widget child;
  final Function onTap;
  final Function onFocus;

  @override
  _CoverState createState() => _CoverState();
}

class _CoverState extends State<Cover> with SingleTickerProviderStateMixin {
  FocusNode _node;
  AnimationController _controller;
  Animation<double> _animation;
  int _focusAlpha = 100;

  Widget image;

  @override
  void initState() {
    _node = FocusNode();
    _node.addListener(_onFocusChange);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 100),
        vsync: this,
        lowerBound: 0.9,
        upperBound: 1);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _node.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (_node.hasFocus) {
      _controller.forward();
      if (widget.onFocus != null) {
        widget.onFocus();
      }
    } else {
      _controller.reverse();
    }
  }

  void _onTap() {
    _node.requestFocus();
    if (widget.onTap != null) {
      widget.onTap();
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: _onTap,
      focusNode: _node,
      focusColor: Colors.transparent,
      focusElevation: 0,
      child: buildCover(context),
    );
  }

  Widget buildCover(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: _onTap,
        child: Column(
          children: <Widget>[
            Container(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.0),
                height: MediaQuery.of(context).size.height / 1.75,
                child: Container(
                  child: widget.child,
                  width: MediaQuery.of(context).size.width / 4,
                ),
              ),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(_focusAlpha),
                  blurRadius: 15,
                  offset: Offset(10, 15),
                )
              ]),
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }
}

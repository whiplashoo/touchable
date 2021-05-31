import 'dart:async';

import 'package:flutter/material.dart';
import 'package:touchable/src/types/types.dart';

///[CanvasTouchDetector] widget detects the gestures on your [CustomPaint] widget.
///
/// Wrap your [CustomPaint] widget with [CanvasTouchDetector]
/// The [builder] function passes the [BuildContext] and expects a [CustomPaint] object as its return value.
class CanvasTouchDetector extends StatefulWidget {
  final CustomTouchPaintBuilder builder;
  final bool shouldRegisterPanEvents;

  const CanvasTouchDetector({Key? key, required this.builder, required this.shouldRegisterPanEvents}) : super(key: key);

  @override
  _CanvasTouchDetectorState createState() => _CanvasTouchDetectorState();
}

class _CanvasTouchDetectorState extends State<CanvasTouchDetector> {
  final StreamController<Gesture> touchController = StreamController.broadcast();
  StreamSubscription? streamSubscription;

  Future<void> addStreamListener(Function(Gesture) callBack) async {
    await streamSubscription?.cancel();
    streamSubscription = touchController.stream.listen(callBack);
  }

  @override
  Widget build(BuildContext context) {
    return TouchDetectionController(touchController, addStreamListener,
        child: widget.shouldRegisterPanEvents
            ? GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Builder(
                  builder: (context) {
                    return widget.builder(context);
                  },
                ),
                onTapDown: (tapDetail) {
                  touchController.add(Gesture(GestureType.onTapDown, tapDetail));
                },
                onTapUp: (tapDetail) {
                  touchController.add(Gesture(GestureType.onTapUp, tapDetail));
                },
                onLongPressStart: (tapDetail) {
                  touchController.add(Gesture(GestureType.onLongPressStart, tapDetail));
                },
                onLongPressEnd: (tapDetail) {
                  touchController.add(Gesture(GestureType.onLongPressEnd, tapDetail));
                },
                onLongPressMoveUpdate: (tapDetail) {
                  touchController.add(Gesture(GestureType.onLongPressMoveUpdate, tapDetail));
                },
                onPanStart: (tapDetail) {
                  touchController.add(Gesture(GestureType.onPanStart, tapDetail));
                },
                onPanUpdate: (tapDetail) {
                  touchController.add(Gesture(GestureType.onPanUpdate, tapDetail));
                },
                onPanDown: (tapDetail) {
                  touchController.add(Gesture(GestureType.onPanDown, tapDetail));
                },
              )
            : GestureDetector(
                behavior: HitTestBehavior.translucent,
                child: Builder(
                  builder: (context) {
                    return widget.builder(context);
                  },
                ),
                onTapDown: (tapDetail) {
                  touchController.add(Gesture(GestureType.onTapDown, tapDetail));
                },
                onTapUp: (tapDetail) {
                  touchController.add(Gesture(GestureType.onTapUp, tapDetail));
                },
                onLongPressStart: (tapDetail) {
                  touchController.add(Gesture(GestureType.onLongPressStart, tapDetail));
                },
                onLongPressEnd: (tapDetail) {
                  touchController.add(Gesture(GestureType.onLongPressEnd, tapDetail));
                },
                onLongPressMoveUpdate: (tapDetail) {
                  touchController.add(Gesture(GestureType.onLongPressMoveUpdate, tapDetail));
                }));
  }

  @override
  void dispose() {
    touchController.close();
    super.dispose();
  }
}

class TouchDetectionController extends InheritedWidget {
  final StreamController<Gesture> _controller;
  final Function addListener;

  bool get hasListener => _controller.hasListener;

  StreamController<Gesture> get controller => _controller;

  const TouchDetectionController(this._controller, this.addListener, {required Widget child}) : super(child: child);

  static TouchDetectionController? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<TouchDetectionController>();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }
}

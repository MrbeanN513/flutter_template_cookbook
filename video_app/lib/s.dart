import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class Video extends StatefulWidget {
  final String title;
  Video({Key key, this.title}) : super(key: key);

  @override
  VideoState createState() => VideoState();
}

class VideoState extends State<Video> {
  VideoPlayerController vcontroller;
  bool controlVisible;
  Timer timer;

  @override
  void initState() {
    controlVisible = true;
    vcontroller = VideoPlayerController.asset('assets/video/promo.mp4');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
    autoHide();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    vcontroller?.dispose();
    timer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void handlerGesture() {
    setState(() {
      controlVisible = !controlVisible;
    });
    autoHide();
  }

  void autoHide() {
    if (controlVisible) {
      timer = Timer(
          Duration(seconds: 5), () => setState(() => controlVisible = false));
    } else {
      timer?.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    final aspectRatio = 0.75;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          PlayerLifeCycle(
            vcontroller,
            (BuildContext context, VideoPlayerController controller) =>
                AspectRatio(
              aspectRatio: aspectRatio,
              child: VideoPlayer(vcontroller),
            ),
          ),
          GestureDetector(
            child: PlayerControl(
              vcontroller,
              visible: controlVisible,
              title: widget.title,
            ),
            onTap: handlerGesture,
          ),
        ],
      ),
    );
  }
}

typedef Widget VideoWidgetBuilder(
    BuildContext context, VideoPlayerController controller);

class PlayerLifeCycle extends StatefulWidget {
  final VideoPlayerController controller;
  final VideoWidgetBuilder childBuilder;

  PlayerLifeCycle(this.controller, this.childBuilder, {Key key})
      : super(key: key);

  @override
  PlayerLifeCycleState createState() => PlayerLifeCycleState();
}

class PlayerLifeCycleState extends State<PlayerLifeCycle> {
  VideoPlayerController get controller => widget.controller;

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
      }
    });
    controller.initialize();
    controller.setLooping(false);
    controller.play();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return widget.childBuilder(context, controller);
  }
}

// part of netflix;
class PlayerControl extends StatefulWidget {
  final VideoPlayerController controller;
  final String title;
  final bool visible;

  PlayerControl(this.controller, {this.visible, this.title, Key key})
      : super(key: key);

  @override
  PlayerControlState createState() => PlayerControlState();
}

class PlayerControlState extends State<PlayerControl> {
  VideoPlayerController get controller => widget.controller;
  String get title => widget.title ?? '';
  bool get visible => widget.visible ?? false;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), init);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void init() {
    if (mounted)
      controller.addListener(() {
        setState(() {});
      });
  }

  void replay(double min, double current) {
    double anchor = current - 10000;
    controller
        .seekTo(Duration(milliseconds: (anchor < min ? min : anchor).round()));
  }

  void forward(double max, double current) {
    double anchor = current + 10000;
    controller
        .seekTo(Duration(milliseconds: (anchor > max ? max : anchor).round()));
  }

  void playcontinue() {
    if (controller.value.isPlaying) {
      controller.pause();
    } else {
      controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration duration = controller != null &&
            controller.value != null &&
            controller.value.duration != null
        ? controller.value.duration
        : null;
    Duration position = controller != null && controller.value != null
        ? controller.value.position
        : null;
    int timeDuration = duration != null && position != null
        ? duration.inMilliseconds - position.inMilliseconds
        : 0;
    Duration timeline = duration != null && position != null
        ? Duration(milliseconds: (timeDuration < 0 ? 0 : timeDuration))
        : null;
    String durationText =
        timeline != null ? timeline.toString().split('.').first : '';
    final Size screenSize = MediaQuery.of(context).size;
    double currentValue = position != null
        ? controller.value.position.inMilliseconds?.toDouble() ?? 0.0
        : 0.0;
    final double minValue = 0.0;
    double maxValue = duration != null
        ? controller.value.duration.inMilliseconds?.toDouble()
        : 0.0;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: screenSize.height,
      width: screenSize.width,
      color: Color.fromRGBO(0, 0, 0, 0.3),
      padding:
          EdgeInsets.only(bottom: 20.0,),
      child: Opacity(
        opacity: visible ? 1 : 0,
        child: visible
            ? Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: screenSize.width,
                    height: 50.0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                         IconButton(
                              padding: EdgeInsets.all(0.0),
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {}),
                        
                        Container(
                          width: screenSize.width - 100.0,
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: screenSize.width,
                    height: 350.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        IconButton(
                          color: Colors.white,
                          iconSize: 40.0,
                          icon: Icon(Icons.replay_10),
                          onPressed: () => replay(minValue, currentValue),
                        ),
                        IconButton(
                          color: Colors.white,
                          iconSize: 80.0,
                          icon: Icon(controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow),
                          onPressed: playcontinue,
                        ),
                        IconButton(
                          color: Colors.white,
                          iconSize: 40.0,
                          icon: Icon(Icons.forward_10),
                          onPressed: () => forward(maxValue, currentValue),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0,),
                   Row(
                      mainAxisSize: MainAxisSize.max,
                      
                      children: <Widget>[
                        Container(
                          width: screenSize.width - 90.0,
                          child: Slider(
                            activeColor: Color.fromRGBO(219, 0, 0, 1.0),
                            inactiveColor: Color.fromRGBO(86, 77, 77, 1.0),
                            value:
                                currentValue > maxValue ? maxValue : currentValue,
                            onChanged: (double value) => controller
                                .seekTo(Duration(milliseconds: value.round())),
                            min: minValue,
                            max: maxValue,
                          ),
                        ),
                        Text(
                          durationText,
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        )
                      ],
                    ),
                  
                ],
              )
            : Container(),
      ),
    );
  }
}

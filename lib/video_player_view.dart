import 'package:flutter/material.dart';
import 'package:flutter_widget_of_the_weak/assets.dart';
import 'package:video_player/video_player.dart';

class MyVideoPlayerView extends StatefulWidget {
  const MyVideoPlayerView({super.key});

  @override
  State<MyVideoPlayerView> createState() => _MyVideoPlayerViewState();
}

class _MyVideoPlayerViewState extends State<MyVideoPlayerView> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(Assets.video1);

    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                  _ControlsOverlay(controller: _controller),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 45.0),
                    child: VideoProgressIndicator(_controller,
                        allowScrubbing: true),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? const SizedBox.shrink()
              : const ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),

        // Add volume and time controls at the bottom
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 40,
            color: Colors.black26,
            child: Row(
              children: [
                // Rewind 10 seconds
                IconButton(
                  icon: const Icon(Icons.replay_10, color: Colors.white),
                  onPressed: () {
                    final position = controller.value.position;
                    final newPosition = position - const Duration(seconds: 10);
                    controller.seekTo(newPosition);
                  },
                ),

                // Volume control
                IconButton(
                  icon: Icon(
                    controller.value.volume > 0
                        ? Icons.volume_up
                        : Icons.volume_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.setVolume(controller.value.volume > 0 ? 0 : 1);
                  },
                ),

                // Forward 10 seconds
                IconButton(
                  icon: const Icon(Icons.forward_10, color: Colors.white),
                  onPressed: () {
                    final position = controller.value.position;
                    final newPosition = position + const Duration(seconds: 10);
                    controller.seekTo(newPosition);
                  },
                ),

                // Loop toggle
                IconButton(
                  icon: Icon(
                    controller.value.isLooping
                        ? Icons.repeat_one
                        : Icons.repeat,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    controller.setLooping(!controller.value.isLooping);
                  },
                ),

                // Speed control
                PopupMenuButton<double>(
                  icon: const Icon(Icons.speed, color: Colors.white),
                  initialValue: controller.value.playbackSpeed,
                  tooltip: 'Playback speed',
                  onSelected: (double speed) {
                    controller.setPlaybackSpeed(speed);
                  },
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuItem<double>>[
                      for (final double speed in _examplePlaybackRates)
                        PopupMenuItem<double>(
                          value: speed,
                          child: Text('${speed}x'),
                        )
                    ];
                  },
                ),

                const Spacer(),

                // Fullscreen toggle
                IconButton(
                  icon: const Icon(Icons.fullscreen, color: Colors.white),
                  onPressed: () {
                    // Implement fullscreen toggle
                    // You'll need to handle this in your app's layout
                    // This is just a placeholder
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Fullscreen not implemented')),
                    );
                  },
                ),
              ],
            ),
          ),
        ),

        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in _exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in _examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}

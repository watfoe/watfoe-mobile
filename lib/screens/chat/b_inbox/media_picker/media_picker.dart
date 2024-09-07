import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:watfoe/components/button/button.dart';

class MediaPickerScreen extends StatefulWidget {
  const MediaPickerScreen({super.key});

  @override
  State<MediaPickerScreen> createState() => _MediaPickerScreenState();
}

class _MediaPickerScreenState extends State<MediaPickerScreen> {
  List<XFile>? _mediaFileList;

  void _setImageFileListFromFile(XFile? value) {
    _mediaFileList = value == null ? null : <XFile>[value];
  }

  dynamic _pickImageError;
  bool isVideo = false;

  VideoPlayerController? _controller;
  VideoPlayerController? _toBeDisposed;

  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(
    ImageSource source, {
    required BuildContext context,
    bool isMultiImage = false,
    bool isMedia = false,
  }) async {
    if (_controller != null) {
      await _controller!.setVolume(0.0);
    }
    if (context.mounted) {
      if (isVideo) {
        final XFile? file = await _picker.pickVideo(
            source: source, maxDuration: const Duration(seconds: 10));
        // await _playVideo(file);
      } else if (isMultiImage) {
        try {
          final List<XFile> pickedFileList = isMedia
              ? await _picker.pickMultipleMedia()
              : await _picker.pickMultiImage();
          setState(() {
            _mediaFileList = pickedFileList;
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      } else if (isMedia) {
        try {
          final List<XFile> pickedFileList = <XFile>[];
          final XFile? media = await _picker.pickMedia();
          if (media != null) {
            pickedFileList.add(media);
            setState(() {
              _mediaFileList = pickedFileList;
            });
          }
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      } else {
        try {
          final XFile? pickedFile = await _picker.pickImage(source: source);
          setState(() {
            _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      }
    }
  }

  @override
  void deactivate() {
    if (_controller != null) {
      _controller!.setVolume(0.0);
      _controller!.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    _disposeVideoController();
    super.dispose();
  }

  Future<void> _disposeVideoController() async {
    if (_toBeDisposed != null) {
      await _toBeDisposed!.dispose();
    }
    _toBeDisposed = _controller;
    _controller = null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ButtonIcon(
          onPressed: () {
            isVideo = false;
            _onImageButtonPressed(ImageSource.gallery, context: context);
          },
          tooltip: 'Pick Image from gallery',
          icon: Icons.photo,
        ),
        ButtonIcon(
          onPressed: () {
            isVideo = false;
            _onImageButtonPressed(
              ImageSource.gallery,
              context: context,
              isMultiImage: true,
            );
          },
          tooltip: 'Pick Multiple Image from gallery',
          icon: Icons.photo_library,
        ),
        if (_picker.supportsImageSource(ImageSource.camera))
          ButtonIcon(
            onPressed: () {
              isVideo = false;
              _onImageButtonPressed(ImageSource.camera, context: context);
            },
            tooltip: 'Take a Photo',
            icon: Icons.camera_alt,
          ),
        ButtonIcon(
          onPressed: () {
            isVideo = true;
            _onImageButtonPressed(ImageSource.gallery, context: context);
          },
          tooltip: 'Pick Video from gallery',
          icon: Icons.video_library,
        ),
        if (_picker.supportsImageSource(ImageSource.camera))
          ButtonIcon(
            onPressed: () {
              isVideo = true;
              _onImageButtonPressed(ImageSource.camera, context: context);
            },
            tooltip: 'Take a Video',
            icon: Icons.videocam,
          ),
      ],
    );
  }
}

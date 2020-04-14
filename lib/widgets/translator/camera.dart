import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:travel_sl/singletons/translator_singleton.dart';
import 'package:travel_sl/widgets/scanner_utils.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    Key key,
  }) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  dynamic _scanResults;
  CameraController _camera;
  Detector _currentDetector = Detector.text;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.back;
  Future<void> _initializeControllerFuture;

  final BarcodeDetector _barcodeDetector =
      FirebaseVision.instance.barcodeDetector();
  final FaceDetector _faceDetector = FirebaseVision.instance.faceDetector();
  final ImageLabeler _imageLabeler = FirebaseVision.instance.imageLabeler();
  final ImageLabeler _cloudImageLabeler =
      FirebaseVision.instance.cloudImageLabeler();
  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();
  final TextRecognizer _cloudRecognizer =
      FirebaseVision.instance.cloudTextRecognizer();

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  void _initializeCamera() async {
    final CameraDescription description =
        await ScannerUtils.getCamera(_direction);

    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.iOS
          ? ResolutionPreset.low
          : ResolutionPreset.medium,
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      ScannerUtils.detect(
        image: image,
        detectInImage: _getDetectionMethod(),
        imageRotation: description.sensorOrientation,
      ).then(
        (dynamic results) {
          if (_currentDetector == null) return;
          setState(() {
            _scanResults = results;
          });
        },
      ).whenComplete(() => _isDetecting = false);
    });
  }

  Future<dynamic> Function(FirebaseVisionImage image) _getDetectionMethod() {
    switch (_currentDetector) {
      case Detector.text:
        return _recognizer.processImage;
      case Detector.cloudText:
        return _cloudRecognizer.processImage;
      case Detector.barcode:
        return _barcodeDetector.detectInImage;
      case Detector.label:
        return _imageLabeler.processImage;
      case Detector.cloudLabel:
        return _cloudImageLabeler.processImage;
      case Detector.face:
        return _faceDetector.processImage;
    }

    return null;
  }

  Widget _buildResults() {
    const Text noResultsText = Text('No results!');

    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }

    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );

    assert(_currentDetector == Detector.text ||
        _currentDetector == Detector.cloudText);
    if (_scanResults is! VisionText) return noResultsText;

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(
              child: Text(
                'Initializing Camera...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                ),
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_camera),
                _buildResults(),
              ],
            ),
    );
  }

  void _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }

    await _camera.stopImageStream();
    await _camera.dispose();

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ML Vision Example'),
        actions: <Widget>[
          PopupMenuButton<Detector>(
            onSelected: (Detector result) {
              _currentDetector = result;
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Detector>>[
              const PopupMenuItem<Detector>(
                child: Text('Detect Barcode'),
                value: Detector.barcode,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Face'),
                value: Detector.face,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Label'),
                value: Detector.label,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Cloud Label'),
                value: Detector.cloudLabel,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Text'),
                value: Detector.text,
              ),
              const PopupMenuItem<Detector>(
                child: Text('Detect Cloud Text'),
                value: Detector.cloudText,
              ),
            ],
          ),
        ],
      ),
      body: _buildImage(),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            try {
              // Ensure that the camera is initialized.
              await _camera.initialize();

              // Construct the path where the image should be saved using the
              // pattern package.
              final path = join(
                // Store the picture in the temp directory.
                // Find the temp directory using the `path_provider` plugin.
                (await getTemporaryDirectory()).path,
                '${DateTime.now()}.png',
              );

              await Future.delayed(new Duration(seconds: 1));

              // Attempt to take a picture and log where it's been saved.
              await _camera.takePicture(path);

              // If the picture was taken, display it on a new screen.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(imagePath: path),
                ),
              );
            } catch (e) {
              // If an error occurs, log the error to the console.
              print(e);
            }
          },
          child: Icon(Icons.camera)),
    );
  }

  @override
  void dispose() {
    _camera.dispose().then((_) {
      _barcodeDetector.close();
      _faceDetector.close();
      _imageLabeler.close();
      _cloudImageLabeler.close();
      _recognizer.close();
      _cloudRecognizer.close();
    });

    _currentDetector = null;
    super.dispose();
  }
}

enum Detector { barcode, face, label, cloudLabel, text, cloudText }

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}

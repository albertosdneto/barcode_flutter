import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

void main() => runApp(MaterialApp(home: QRViewExample()));

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class QRViewExample extends StatefulWidget {
  const QRViewExample({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  var qrText = '';
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leitor MAC Address"),
        actions: [
          RaisedButton(
            onPressed: () {
              if (controller != null) {
                controller.toggleFlash();
                if (_isFlashOn(flashState)) {
                  setState(() {
                    flashState = flashOff;
                  });
                } else {
                  setState(() {
                    flashState = flashOn;
                  });
                }
              }
            },
            child: Text(flashState, style: TextStyle(fontSize: 20)),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              // flex: 4,
              child: Stack(
            fit: StackFit.loose,
            alignment: Alignment.bottomCenter,
            children: [
              QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderLength: 30,
                  borderWidth: 10,
                  cutOutSize: 300,
                ),
              ),
              Container(
                  // width: 100,
                  height: 100,
                  // color: Colors.red,
                  child: Column(
                    children: [
                      Text(
                        "This is the result of scan: $qrText",
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "Aponte sua câmera para o MAC Address",
                        style: TextStyle(
                          // fontSize: 10.0,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        width: 300.0,
                        height: 50,
                        child: FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side:
                                  BorderSide(width: 5.0, color: Colors.white)),
                          color: Color(0xFF136A8A),
                          disabledColor: Colors.grey,
                          splashColor: Color(0xFFC4DAE2),
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            // Navigator.pushNamed(context, '/Form_Page');
                          },
                          child: Text("Inserir MAC Adress",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15)),
                        ),
                      ),
                    ],
                  ))
            ],
          )),
          // Expanded(
          //   flex: 1,
          //   child: FittedBox(
          //     fit: BoxFit.contain,
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //       children: <Widget>[
          //         Text('This is the result of scan: $qrText'),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             Container(
          //               margin: EdgeInsets.all(8),
          //               child: RaisedButton(
          //                 onPressed: () {
          //                   if (controller != null) {
          //                     controller.toggleFlash();
          //                     if (_isFlashOn(flashState)) {
          //                       setState(() {
          //                         flashState = flashOff;
          //                       });
          //                     } else {
          //                       setState(() {
          //                         flashState = flashOn;
          //                       });
          //                     }
          //                   }
          //                 },
          //                 child:
          //                     Text(flashState, style: TextStyle(fontSize: 20)),
          //               ),
          //             ),
          //             Container(
          //               margin: EdgeInsets.all(8),
          //               child: RaisedButton(
          //                 onPressed: () {
          //                   if (controller != null) {
          //                     controller.flipCamera();
          //                     if (_isBackCamera(cameraState)) {
          //                       setState(() {
          //                         cameraState = frontCamera;
          //                       });
          //                     } else {
          //                       setState(() {
          //                         cameraState = backCamera;
          //                       });
          //                     }
          //                   }
          //                 },
          //                 child:
          //                     Text(cameraState, style: TextStyle(fontSize: 20)),
          //               ),
          //             )
          //           ],
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: <Widget>[
          //             Container(
          //               margin: EdgeInsets.all(8),
          //               child: RaisedButton(
          //                 onPressed: () {
          //                   controller?.pauseCamera();
          //                 },
          //                 child: Text('pause', style: TextStyle(fontSize: 20)),
          //               ),
          //             ),
          //             Container(
          //               margin: EdgeInsets.all(8),
          //               child: RaisedButton(
          //                 onPressed: () {
          //                   controller?.resumeCamera();
          //                 },
          //                 child: Text('resume', style: TextStyle(fontSize: 20)),
          //               ),
          //             )
          //           ],
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  bool _isFlashOn(String current) {
    return flashOn == current;
  }

  bool _isBackCamera(String current) {
    return backCamera == current;
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

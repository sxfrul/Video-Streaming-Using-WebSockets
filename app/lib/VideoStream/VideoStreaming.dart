import 'dart:convert';
import 'dart:typed_data';

import 'package:app/VideoStream/websocket.dart';
import 'package:app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:app/styles/styles.dart';


class VideoStream extends StatefulWidget {
  const VideoStream({Key? key}) : super(key: key);

  @override
  State<VideoStream> createState() => _VideoStreamState();
}

class _VideoStreamState extends State<VideoStream> {
  final WebSocket _socket = WebSocket(Constants.videoWebsocketURL);
  final WebSocket2 _testsocket = WebSocket2(Constants.testSocketURL);
  bool _isConnected = false;
  bool _isTestConnected = false;
  void connect(BuildContext context) async {
    _socket.connect();
    setState(() {
      _isConnected = true;
    });
  }

  void connect_test(BuildContext context) async {
    _testsocket.connect();
    setState(() {
      _isTestConnected = true;
    });
  }

  void disconnect_test(BuildContext context) async {
    _testsocket.disconnect();
    setState(() {
      _isTestConnected = false;
    });
  }

  void disconnect() {
    _socket.disconnect();
    setState(() {
      _isConnected = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("EYE(i) Cam"),
      // ),
      body:
      GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(35),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: [
          Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white
            ),
            child: Center(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () => connect(context),
                        style: Styles.buttonStyle,
                        child: const Text("Connect"),
                      ),
                      ElevatedButton(
                        onPressed: () => connect_test(context),
                        style: Styles.buttonStyle,
                        child: const Text("Test"),
                      ),
                      ElevatedButton(
                        onPressed: disconnect,
                        style: Styles.buttonStyle,
                        child: const Text("Disconnect"),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _isConnected
                      ? StreamBuilder(
                          stream: _socket.stream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const CircularProgressIndicator();
                            }

                            if (snapshot.connectionState == ConnectionState.done) {
                              return const Center(
                                child: Text("Connection Closed !"),
                              );
                            }
                            //? Working for single frames
                            return Image.memory(
                              Uint8List.fromList(
                                base64Decode(
                                  (snapshot.data.toString()),
                                ),
                              ),
                              gaplessPlayback: true,
                              excludeFromSemantics: true,
                            );
                          },
                        )
                      : const Text("Initiate Connection")
                ],
              ),
            ),
          ),
        ]
      )
    );
  }
}

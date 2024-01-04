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
  bool _isConnected = false;
  void connect(BuildContext context) async {
    _socket.connect();
    setState(() {
      _isConnected = true;
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
      appBar: AppBar(
        title: Image.asset('assets/sftls_logo.jpg',
        height: 240,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body:
      GridView.count(
        crossAxisCount: 1,
        padding: const EdgeInsets.all(35),
        mainAxisSpacing: 15,
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
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white
            ),
            child: GridView.count(
              crossAxisCount: 1,
              
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              childAspectRatio: (10.8 / 3.2),
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.red
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (2.1/ 1),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(0.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          
                          image: DecorationImage(
                            image: AssetImage("assets/on_lightbulb.png"),
                            
                          )
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color.fromARGB(255, 255, 146, 138)
                        ),
                        child:
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
                                return Text("data");
                              },
                            )
                        : const Text("Initiate Connection")
                      ),
                    ]
                    ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.green
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (2.1/ 1),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage("assets/on_lightbulb.png")
                          )
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color.fromARGB(255, 171, 255, 174)
                        ),
                        child: const Center(
                          child: Text(
                            "BATHROOM",
                            textAlign: TextAlign.center,
                            )
                        )
                      ),
                    ]
                    ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.blue
                  ),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: (2.1/ 1),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage("assets/on_lightbulb.png")
                          )
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color.fromARGB(255, 152, 209, 255)
                        ),
                        child: const Center(
                          child: Text(
                            "BEDROOM",
                            textAlign: TextAlign.center,
                            )
                        )
                      ),
                    ]
                    ),
                ),
              ],
            ),
          ),
        ]
      )
    );
  }
}

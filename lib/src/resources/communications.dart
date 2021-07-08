//This is a demo code to show sending of data and it's reception using UDP
// ****This code is not meant to be run using flutter
// ****To run the code open a terminal and call:
//        dart communications.dart

import 'dart:async';
import 'dart:convert';

import 'dart:io';

//Declaring non-nullable variable udp
late RawDatagramSocket udp;


//IN the event that data is received....

void onData(RawSocketEvent event) {
  print("Socket event.");
  if (event == RawSocketEvent.read) {
    Datagram? rcv = udp.receive();
    print("Received data: " + ascii.decode(rcv!.data));
  }
}

void main() async {

  packetHandler test = packetHandler();
  await test.initializeIp(57194);
  await Future.delayed(Duration(seconds: 1));
  while (true) {
    await test.sendData();
  }
}

class packetHandler {
  int portNumber = 57194;
  String? destIpString;
  late RawDatagramSocket
      socketConnection; //the socket connection that will be carrying out the udp message sending
  void onData(RawSocketEvent event) {
    // and event handler for when a packet is received
    print("socket event");
    if (event == RawSocketEvent.read) {
      Datagram? rcv = socketConnection.receive();
      print("Received data" + ascii.decode(rcv!.data));
    }
  }

  final int port = 57194;
  udp = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);


  packetHandler() {}

  Future<void> initializeIp(int number) async {
    this.socketConnection =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, number);
    print('got here $this.socketConnection');
    this.portNumber = number;

    socketConnection.listen(this.onData);
    print("The socket is connected to: ${socketConnection.address}:" +
        socketConnection.port.toString());
    List<NetworkInterface> ni = await NetworkInterface.list();
    print("The internet address is: ${ni[0].addresses[0].address}");

    print(
        "Enter the IP address of the socket to connect to (The same port {$portNumber} will be used): ");
    destIpString = stdin.readLineSync();
  }

  Future<void> sendData() async {
    print("Enter the string to be sent to [$destIpString:$portNumber]: ");

  print("The socket is connected to: ${udp.address}:" + udp.port.toString());
  List<NetworkInterface> ni = await NetworkInterface.list();
  print("The internet address is: ${ni[0].addresses[0].address}");

  print(
      "Enter the IP address of the socket to connect to (The same port {$port} will be used): ");
  String? destIpString = stdin.readLineSync();

  while (true) {
    print("Enter the string to be sent to [$destIpString:$port]: ");

    String? stringToSend = stdin.readLineSync();
    List<int> buffer = ascii.encode(stringToSend!);
    InternetAddress destAddress = InternetAddress(destIpString!);
    socketConnection.send(buffer, destAddress, portNumber);
    print("The string has been sent.");
    //We need a delay to allow the main thread with input to hand over control of the terminal
    //  to the listen thread so that it can output to console
    await Future.delayed(Duration(seconds: 1));
  }
}

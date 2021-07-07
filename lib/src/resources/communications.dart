//This is a demo code to show sending of data and it's reception using UDP
// ****This code is not meant to be run using flutter
// ****To run the code open a terminal and call:
//        dart communications.dart

import 'dart:async';
import 'dart:convert';

import 'dart:io';

late RawDatagramSocket udp;

void onData (RawSocketEvent event) {
  print("Socket event.");
  if (event == RawSocketEvent.read) {
    Datagram? rcv = udp.receive();
    print("Received data: " + ascii.decode(rcv!.data));
  }
}

void main () async {
  final int port = 57194;
  udp = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);

  udp.listen(onData);

  print ("The socket is connected to: ${udp.address}:" + udp.port.toString());
  List<NetworkInterface> ni = await NetworkInterface.list();
  print ("The internet address is: ${ni[0].addresses[0].address}");

  print("Enter the IP address of the socket to connect to (The same port {$port} will be used): ");
  String? destIpString = stdin.readLineSync();

  while(true) {
    print("Enter the string to be sent to [$destIpString:$port]: ");
    String? stringToSend = stdin.readLineSync();
    List<int> buffer = ascii.encode(stringToSend!);
    InternetAddress destAddress = InternetAddress(destIpString!);
    udp.send(buffer, destAddress, port);
    print("The string has been sent.");
    //We need a delay to allow the main thread with input to hand over control of the terminal
    //  to the listen thread so that it can output to console
    await Future.delayed(Duration(seconds: 1));
  }
}
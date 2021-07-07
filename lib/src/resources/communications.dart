import 'dart:async';

import 'dart:io';

late RawDatagramSocket udp;

void main () async {
  final int port = 3201;
  udp = await RawDatagramSocket.bind(InternetAddress.anyIPv4, port);

  udp.listen(onData);

  List<int> buffer = [203,232];
  InternetAddress address = InternetAddress("192.168.0.0");
  udp.send(buffer, address, port);
}

void onData (RawSocketEvent event) {
  Datagram? rcv = udp.receive();
  print ("Received data:");
  print (rcv!.data);
}
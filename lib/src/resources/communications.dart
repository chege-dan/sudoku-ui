//This is a demo code to show sending of data and it's reception using UDP
// ****This code is not meant to be run using flutter
// ****To run the code open a terminal and call:
//        dart communications.dart

import 'dart:async';
import 'dart:convert';

import 'dart:io';

void main() async {
  packetHandler test = packetHandler();
  String totest = "1123456432345543";
  packet_splitter test1 = packet_splitter(totest);
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
  String? onData(RawSocketEvent event) {
    // and event handler for when a packet is received
    print("socket event");
    if (event == RawSocketEvent.read) {
      Datagram? rcv = socketConnection.receive();
      print("Received data" + ascii.decode(rcv!.data));
      return ascii.decode(rcv!.data);
    }
  }

  packetHandler();

  Future<void> initializeIp(int number) async {
    this.socketConnection =
        await RawDatagramSocket.bind(InternetAddress.anyIPv4, number);
    print('got here $this.socketConnection');
    this.portNumber = number;
    print("The socket is connected to: ${socketConnection.address}:" +
        this.socketConnection.port.toString());
    List<NetworkInterface> ni = await NetworkInterface.list();
    print("The internet address is: ${ni[0].addresses[0].address}");

    print(
        "Enter the IP address of the socket to connect to (The same port ${this.portNumber} will be used): ");
    this.destIpString = stdin.readLineSync();
  }

  Future<void> sendData() async {
    print(
        "Enter the string to be sent to [${this.destIpString}:${this.portNumber}]: ");

    String? stringToSend = stdin.readLineSync();
    List<int> buffer = ascii.encode(stringToSend!);
    InternetAddress destAddress = InternetAddress(this.destIpString!);
    socketConnection.send(buffer, destAddress, this.portNumber);
    print("The string has been sent.");
    //We need a delay to allow the main thread with input to hand over control of the terminal
    //  to the listen thread so that it can output to console
    await Future.delayed(Duration(seconds: 1));
  }
}

class packet_splitter {
  String? type;
  String? sudoku;
  String? solver;
  packet_splitter(String packet) {
    assert(packet.length > 81);
    type = packet.substring(0, 1);
    if (type == "0") {
      //this is a packet containing the current sudoku only
      this.sudoku = packet.substring(1, 82);
    } else if (type == "2") {
      // this is a packet containing the sudoku that has been solved and the person who solved it
      this.sudoku = packet.substring(1, 82);
      this.solver = packet.substring(82, packet.length);
    } else {
      //this is not a packet that has been received and thus should not be sent; We shouldn't get here;
      assert(false);
    }
  }
}

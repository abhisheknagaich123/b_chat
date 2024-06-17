// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_blue/flutter_blue.dart';

class BluetoothController extends GetxController {
  var flutterBlue = FlutterBlue.instance;
  var scanResults = <ScanResult>[].obs;
  var isScanning = false.obs;
  BluetoothDevice? connectedDevice;
  List<BluetoothService> services = [];

  void startScan() {
    scanResults.clear();
    flutterBlue.startScan(timeout: Duration(seconds: 4));
    isScanning.value = true;

    flutterBlue.scanResults.listen((results) {
      scanResults.value = results;
    });

    flutterBlue.isScanning.listen((scanning) {
      isScanning.value = scanning;
    });
  }

  void stopScan() {
    flutterBlue.stopScan();
    isScanning.value = false;
  }

  Future<void> connect(BluetoothDevice device) async {
    await device.connect();
    connectedDevice = device;
    services = await device.discoverServices();
  }

  Future<void> disconnect() async {
    await connectedDevice?.disconnect();
    connectedDevice = null;
    services = [];
  }

  Future<void> sendMessage(String message) async {
    // if (connectedDevice == null) return;

    // var service = services.firstWhere((s) => s.uuid == <your-service-uuid>);
    // var characteristic = service.characteristics.firstWhere((c) => c.uuid == <your-characteristic-uuid>);

    // await characteristic.write(utf8.encode(message));
    print("messs ahe");
  }
}

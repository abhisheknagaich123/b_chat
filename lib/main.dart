import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bluetooth_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Bluetooth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final BluetoothController bluetoothController =
      Get.put(BluetoothController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth App'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => bluetoothController.startScan(),
            child: Obx(() => bluetoothController.isScanning.value
                ? Text('Scanning...')
                : Text('Start Scan')),
          ),
          Obx(() {
            if (bluetoothController.isScanning.value) {
              return CircularProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: bluetoothController.scanResults.length,
                  itemBuilder: (context, index) {
                    var result = bluetoothController.scanResults[index];
                    return ListTile(
                      title: Text(result.device.name),
                      subtitle: Text(result.device.id.toString()),
                      onTap: () => bluetoothController.connect(result.device),
                    );
                  },
                ),
              );
            }
          }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Message'),
              onSubmitted: (message) =>
                  bluetoothController.sendMessage(message),
            ),
          ),
        ],
      ),
    );
  }
}

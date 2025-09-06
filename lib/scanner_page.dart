import "dart:async";

import "package:flutter/material.dart";
import "package:mobile_scanner/mobile_scanner.dart";
import "package:qr_code/popup.dart";
import "package:qr_code/scanned.dart";

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  var _isScannable = true;
  final _controller = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: _controller,
      onDetect: _scaned,
    );
  }

  Future<void> _scaned(BarcodeCapture barcodeCapture) async {
    if (!_isScannable) {
      return;
    }
    _isScannable = false;
    unawaited(loading(context));
    final x = barcodeCapture.barcodes
        .map((e) => e.rawValue)
        .toList()
        .firstWhere((e) => e != null)!;
    await Scanned.insert(x);
    if (!mounted) {
      return;
    }
    back(context);
    await popup(
      context,
      title: x,
      actions: [
        PopupAction("Copy"),
        PopupAction("Close"),
      ],
    );
    _isScannable = true;
  }
}

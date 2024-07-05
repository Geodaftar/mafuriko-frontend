import 'package:flutter/material.dart';
import 'package:mafuriko/features/maruriko_app.dart';
import 'service_locator.dart' as sl;
void main() async{
    await sl.init();
  runApp(const MafurikoApp());
}


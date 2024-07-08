
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:challenge_uex/app.dart';
import 'package:challenge_uex/service_locator.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  
  setupDependencies();
  setUrlStrategy(PathUrlStrategy());

  runApp(const App());
}

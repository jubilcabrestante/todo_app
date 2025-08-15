import 'package:todo_app/firebase_options/firebase_options_prod.dart';
import 'package:todo_app/main.dart';

void main() async {
  firebaseMain(DefaultFirebaseOptions.currentPlatform);
}

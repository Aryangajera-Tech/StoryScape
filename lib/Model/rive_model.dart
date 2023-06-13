import 'package:rive/rive.dart';

class RiveModel {
  String src, artboard, stateMachineName;
  SMIBool ?status;

  RiveModel({
    required this.src,
    required this.artboard,
    required this.stateMachineName,
    this.status,
  });

  set setStatus(SMIBool state) {
    status = state;
  }
}

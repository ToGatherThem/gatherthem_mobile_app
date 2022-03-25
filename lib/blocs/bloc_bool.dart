import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocBool extends Bloc {
  final _streamController = BehaviorSubject<bool>();

  Stream<bool> get stream => _streamController.stream;

  Sink<bool> get sink => _streamController.sink;
  final bool? initValue;

  BlocBool({this.initValue}) {
    if (initValue != null) {
      sink.add(initValue!);
    }
    else{
      sink.add(false);
    }
  }
setBool(bool value) async{
    sink.add(value);
}

  @override
  dispose() => _streamController.close();
}

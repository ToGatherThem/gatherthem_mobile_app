import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocString extends Bloc {
  final _streamController = BehaviorSubject<String>();
  Stream<String> get stream => _streamController.stream;
  Sink<String> get sink => _streamController.sink;
  final String? initValue;
  late String value;

  BlocString({this.initValue}) {
    if (initValue != null) {
      value = initValue!;
      sink.add(initValue!);
    } else {
      sink.add("");
      value = "";
    }
  }

  setString(String value) async {
    sink.add(value);
  }

  @override
  dispose() => _streamController.close();
}
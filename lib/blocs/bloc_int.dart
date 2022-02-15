import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:rxdart/rxdart.dart';

class BlocInt extends Bloc {
  final _streamController = BehaviorSubject<int>();
  Stream<int> get stream => _streamController.stream;
  Sink<int> get sink => _streamController.sink;
  final int? initValue;
  late int value;

  BlocInt({this.initValue}) {
    if (initValue != null) {
      value = initValue!;
      sink.add(initValue!);
    } else {
      sink.add(0);
      value = 0;
    }
  }

  setInt(int value) async {
    sink.add(value);
  }

  increment(){
    value ++;
    sink.add(value);
  }

  @override
  dispose() => _streamController.close();

}
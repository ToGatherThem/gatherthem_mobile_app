import 'package:gatherthem_mobile_app/blocs/bloc.dart';
import 'package:gatherthem_mobile_app/services/service_collection.dart';
import 'package:rxdart/rxdart.dart';

class BlocCollection extends Bloc {
  final _streamController = BehaviorSubject<String>();

  Stream<String> get stream => _streamController.stream;

  Sink<String> get sink => _streamController.sink;
  final String? initValue;

  BlocCollection({this.initValue}) {
    if (initValue != null) {
      sink.add(initValue!);
    } else {
      sink.add("noText");
    }
  }

  fetchCollection() async {
    var resultRequest = await ServiceCollection().fetchCollection();
    print(resultRequest);
    setTitle(resultRequest);
  }

  setTitle(String value) async {
    sink.add(value);
  }

  @override
  dispose() {
    _streamController.close();
  }
}

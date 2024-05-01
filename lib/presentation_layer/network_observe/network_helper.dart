import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:yumprint/presentation_layer/network_observe/bloc/network_bloc.dart';
import 'package:yumprint/presentation_layer/network_observe/event/network_event.dart';

class NetworkHelper {
  static void observeNetwork(NetworkBloc networkBloc) {
    Connectivity().onConnectivityChanged.listen(
      (ConnectivityResult result) {
        if (result == ConnectivityResult.none) {
          networkBloc.add(NetWorkFailEvent());
        } else {
          networkBloc.add(NetWorkSuccessEvent());
        }
      },
    );
  }
}

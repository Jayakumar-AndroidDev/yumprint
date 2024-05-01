import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/network_observe/event/network_event.dart';
import 'package:yumprint/presentation_layer/network_observe/network_helper.dart';
import 'package:yumprint/presentation_layer/network_observe/state/network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  NetworkBloc() : super(NetworkInitialState()) {
    on<NetworkObserveEvent>(
      (event, emit) {
        NetworkHelper.observeNetwork(this);
      },
    );
    on<NetWorkSuccessEvent>(
      (event, emit) {
        emit(NetworkSuccessState());
      },
    );
    on<NetWorkFailEvent>(
      (event, emit) {
        emit(NetworkFailureState());
      },
    );
  }
}

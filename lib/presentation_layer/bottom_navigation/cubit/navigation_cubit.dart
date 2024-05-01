import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/bottom_navigation/state/selected_index_state.dart';


class NavigationCubit extends Cubit<SelectedIndexState> {
  NavigationCubit() : super(SelectedIndexState(0));

  onSelected(int index){
    emit(SelectedIndexState(index));
  }
}
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumprint/presentation_layer/edit_profile_screen/event/image_picker_event.dart';
import 'package:yumprint/presentation_layer/edit_profile_screen/state/image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerInitialState()) {
    on<OnImagePickerClickedEvent>((event, emit) {
  
        // emit(ImagePickerErrorState(errorMessage: 'No Image Picked.'));

   
        emit(ImagePickerPathState(path: event.pickedImagePath));

    });
  }
}
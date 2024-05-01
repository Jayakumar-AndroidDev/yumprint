import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ImagePickerEvent extends Equatable {
  
}

class OnImagePickerClickedEvent extends ImagePickerEvent {
  final File pickedImagePath;
  OnImagePickerClickedEvent({required this.pickedImagePath});
  @override
  List<Object> get props => [pickedImagePath];
}
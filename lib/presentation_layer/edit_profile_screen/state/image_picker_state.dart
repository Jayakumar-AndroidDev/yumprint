import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ImagePickerState  extends Equatable {

}

class ImagePickerInitialState extends ImagePickerState {
  @override
  List<Object?> get props => [];
}

class ImagePickerErrorState extends ImagePickerState {

  final String errorMessage;
  
  ImagePickerErrorState({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ImagePickerPathState extends ImagePickerState {

  final File path;
  
  ImagePickerPathState({required this.path});

  @override
  List<Object?> get props => [path];
}
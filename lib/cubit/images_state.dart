part of 'images_cubit.dart';

abstract class ImagesState extends Equatable {
  const ImagesState();
}

class ImagesInitial extends ImagesState {
  @override
  List<Object> get props => [];
}
class ImagesLoading extends ImagesState {
  @override
  List<Object> get props => [];
}
class ImagesFetched extends ImagesState {
 final  List<Photos>images;


  const ImagesFetched({required this.images});

  @override
  List<Object> get props => [];
}

class ImagesSearchFetched extends ImagesState {
  final  List<Photos>images;


  const ImagesSearchFetched({required this.images});

  @override
  List<Object> get props => [];
}


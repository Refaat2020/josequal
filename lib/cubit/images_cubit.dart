import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:josequal/constant/api_key.dart';
import 'package:josequal/constant/url.dart';
import 'package:josequal/model/image_model.dart';
import 'package:http/http.dart'as http;

part 'images_state.dart';

class ImagesCubit extends Cubit<ImagesState> {
  ImagesCubit() : super(ImagesInitial());

  List<Photos>images = [];
  List<String>favoriteImages = [];
  Future<List<Photos>>getImages()async{
    emit(ImagesLoading());
    http.Response response;
    response = await http.get(
      Uri.parse(kUrl),
      headers: {
        "Authorization" : kApiKey,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body) as Map<String,dynamic>;
      images.addAll((map["photos"] as List)
          .map((photos) => Photos.fromJson(photos as Map<String,dynamic>))
          .toList());
      emit(ImagesFetched(images: images));
    }  

    return images;
  }

  List<String>addToFavorite(String url){
    favoriteImages.add(url);
    print(favoriteImages.length);
    return favoriteImages;
  }

  Future<List<Photos>>searchForImage(String key)async{
    emit(ImagesLoading());
    http.Response response;
    response = await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$key&per_page=10"),
      headers: {
        "Authorization" : kApiKey,
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> map = json.decode(response.body) as Map<String,dynamic>;
      images.addAll((map["photos"] as List)
          .map((photos) => Photos.fromJson(photos as Map<String,dynamic>))
          .toList());
      emit(ImagesSearchFetched(images: images));
    }

    return images;
  }

  Future<void>downloadImage(BuildContext context,String imageUrl)async{
    try {
      var imageId = await ImageDownloader.downloadImage(imageUrl);
      if (imageId == null) {
        return;
      }
      var fileName = await ImageDownloader.findName(imageId);
      var path = await ImageDownloader.findPath(imageId);
      var size = await ImageDownloader.findByteSize(imageId);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved at $path",style: TextStyle(fontWeight: FontWeight.w700,color: Colors.white,fontSize: 14.sp)),backgroundColor: Colors.black,));
    } on PlatformException catch (error) {
      print(error);
    }
  }
}

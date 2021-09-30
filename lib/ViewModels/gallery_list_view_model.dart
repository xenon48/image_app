import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'dart:io';

class GalleryListViewModel extends ChangeNotifier {
  List<AssetEntity> imageAssets = [];
  int _currentIndex;


  // fetchAssets() async {
  //   final albums = await PhotoManager.getAssetPathList(onlyAll: true);
  //   final recentAlbum = albums.first;
  //
  //   final recentAssets = await recentAlbum.getAssetListRange(
  //       start: 0, // start at index 0
  //       end: 1000000); // end at a very big index (to get all the assets)
  //
  //   this.imageAssets = recentAssets;
  //   this.currentIndex = 0;
  // }

  set currentIndex(int value) {
    this._currentIndex = value;
    notifyListeners();
  }

  int get currentIndex => _currentIndex;

  Future<File> getCurrentFile() async => imageAssets[currentIndex].file;
}

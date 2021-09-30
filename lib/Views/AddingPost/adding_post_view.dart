import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:picturn/ViewModels/adding_post_view_model.dart';
import 'package:picturn/ViewModels/gallery_list_view_model.dart';
import 'package:picturn/Views/AddingPost/full_size_image_asset_view.dart';
import 'package:picturn/Views/AddingPost/image_asset_gallery_view.dart';
import 'package:picturn/Views/CustomWidgets/stroke_text.dart';
import 'package:provider/provider.dart';

class AddingPostView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddingPostView();
  }
}

class _AddingPostView extends State<AddingPostView> {
  GalleryListViewModel galleryListViewModel;
  final AddingPostViewModel addingPostViewModel = AddingPostViewModel();

  @override
  void initState() {
    super.initState();
    this.galleryListViewModel = GalleryListViewModel();
    this._fetchImageGalleryAssets();
  }

  void onUploadPost() async {
    print('add post');
    var file = await this.galleryListViewModel.getCurrentFile();
    this.addingPostViewModel.addFilePost(file).then((value) {
      var snackBar = SnackBar(content: Text('Картинка загружена!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
      create: (context) => this.galleryListViewModel,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(0, 0, 0, height / 2 - 50),
            child: FullSizeImageAssetView(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, height / 2 - 50, 0, 0),
            padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StrokeText('Галерея',
                    strokeColor: Colors.black,
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w400,
                    strokeWidth: 0.5),
                Material(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(Icons.camera_alt),
                        iconSize: 30,
                        onPressed: () {
                          print('camera');
                          this.getCameraImage();
                        },
                      ),
                      IconButton(
                        splashRadius: 20,
                        icon: Icon(Icons.arrow_upward),
                        iconSize: 30,
                        onPressed: () => onUploadPost(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, height / 2, 0, 0),
            child: ImageAssetGalleryView(),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, height / 2 - 50, 0, 0),
            child: Divider(
              thickness: 2,
              height: 0,
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, height / 2, 0, 0),
            child: Divider(
              thickness: 2,
              height: 0,
            ),
          ),
        ],
      ),
    );
  }

  _fetchImageGalleryAssets() async {
    final albums = await PhotoManager.getAssetPathList(onlyAll: true);
    final recentAlbum = albums.first;

    final recentAssets = await recentAlbum.getAssetListRange(
      start: 0, // start at index 0
      end: 1000000, // end at a very big index (to get all the assets)
    );
    this.galleryListViewModel.currentIndex = 0;

    setState(() {
      this.galleryListViewModel.imageAssets = recentAssets
          .where((element) => element.type == AssetType.image)
          .toList();
      print('fetch count ' +
          this.galleryListViewModel.imageAssets.length.toString());
    });
  }

  getCameraImage() async {
    PickedFile imageFile = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 100);

    if (imageFile == null) return;

    String albumName = 'PleasurePicture';
    File tmpFile = File(imageFile.path);
    print('полный путь картинки:   ' + tmpFile.path.toString());
    print('перед сохранением count ' +
        this.galleryListViewModel.imageAssets.length.toString());
    final saveResult =
        await GallerySaver.saveImage(tmpFile.path, albumName: albumName);
    if (saveResult == true) {
      await Future.delayed(
          Duration(seconds: 5), () => this._fetchImageGalleryAssets());
    }
  }
}

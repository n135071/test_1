import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import 'package:test_1/application/picture%20&%20location/home_event.dart';
import 'package:test_1/application/picture%20&%20location/home_state.dart';
import 'package:test_1/data/piclocat_repository.dart';
import 'package:test_1/models/pic_and_location_api.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(super.initialState) {
    on<GetPicture>(getImage);


  }

  void getImage(GetPicture event, Emitter<HomeState> emit) async {
    XFile? picked = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      preferredCameraDevice: CameraDevice.front,
    );

    var image = File(picked!.path);

    emit(ShowImageInScreen(
      imageFile: image,
    ));
    emit(HomeLoading());
    LocationData? locationData = await getCurrentLocation();
    if (locationData == null) {
      emit(const HomeGetLocationFailed(
          errorMessage: "لم يكتمل جلب الموقع الرجاء المحاولة مجددا"));
      return;
    }

    PictureAndLocation model = PictureAndLocation(
      longitude: locationData.longitude.toString(),
      latitude: locationData.latitude.toString(),
      image: image,
      type: event.type,
    );

    var response = await PictureRepository().submit(model);

    if (response.hasError) {
      emit(HomeFailed(errorMessage: response.message));
    } else {
      emit(HomeCompleted(result: response.data ?? ''));
    }
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }
}

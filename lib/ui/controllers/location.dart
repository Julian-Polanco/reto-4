import 'package:f_gps_tracker/domain/models/location.dart';
import 'package:f_gps_tracker/domain/use_cases/location_manager.dart';
import 'package:get/get.dart';

class LocationController extends GetxController {
  final Rx<List<TrackedLocation>> _locations = Rx([]);

  List<TrackedLocation> get locations => _locations.value;

  Future<void> initialize() async {
    await LocationManager.initialize();
  }

  Future<void> saveLocation({
    required TrackedLocation location,
  }) async {
    return await LocationManager.save(location: location);
  }

  Future<List<TrackedLocation>> getAll({
    String? orderBy,
  }) async {
    _locations.value = await LocationManager.getAll();  
    return await LocationManager.getAll();
  }

  Future<void> updateLocation({required TrackedLocation location}) async {
    await LocationManager.update(location: location);
    _locations.value = await getAll();
  }

  Future<void> deleteLocation({required TrackedLocation location}) async {
    await LocationManager.delete(location: location);
    _locations.update((val) {
      val!.removeWhere((element) => element.uuid == location.uuid);
    });
  }

  Future<void> deleteAll() async {
    _locations.value = [];
    await LocationManager.deleteAll();
  }
}

import 'package:get/get.dart';

class BookmarkController extends GetxController {
  BookmarkController();
  final _obj = ''.obs;
  set obj(value) => _obj.value = value;
  get obj => _obj.value;
}

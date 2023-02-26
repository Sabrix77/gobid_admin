import 'package:flutter/material.dart';
import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/my_user.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/network/remote/db_utils_auth.dart';
import 'package:gobid_admin/network/remote/db_utils_products.dart';

class EndAuctionViewModel extends BaseViewModel {
  List<Product>? products;
  String? errorMssage;
  List<String> sellersName = [];

  void getProductsByEndDate(DateTime selectedDate) async {
    String endDate =
        DateUtils.dateOnly(selectedDate).millisecondsSinceEpoch.toString();
    try {
      products = await DBUtilsProducts.getProductsListByDate(endDate);
      await getSellerName();
    } catch (e) {
      errorMssage = 'error';
    }
    notifyListeners();
  }

  Future<void> getSellerName() async {
    for (int i = 0; i < products!.length; i++) {
      MyUser user = await DBUtilsAuth.getUserData(products![i].sellerId);
      sellersName.add('${user.firstName} ${user.lastName}');
    }
  }
}

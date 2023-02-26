import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/network/remote/db_utils_products.dart';
import 'package:gobid_admin/shared/strings/app_strings.dart';

import '../../../model/product.dart';

class ExistListViewModel extends BaseViewModel {
  List<Product>? products;

  String? errorMessage;

  void getAllConfirmedProducts() async {
    try {
      products = await DBUtilsProducts.getSelectedProductsList(confirmed: true);
    } catch (e) {
      errorMessage = AppStrings.somethingWontWrong;
    }
    notifyListeners();
  }

  void deleteProduct(String productID) async {
    try {
      navigator!.showLoading();
      await DBUtilsProducts.deleteProductFromFirestore(productID);
      navigator!.hideDialog();
      navigator!.showMessage('Product Successfully Deleted', 'Ok');

      ///to rebuild screen after item is deleted
      getAllConfirmedProducts();
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage('something went wrong', 'Ok');
    }
  }
}

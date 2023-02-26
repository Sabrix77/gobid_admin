import 'package:gobid_admin/base.dart';
import 'package:gobid_admin/model/product.dart';
import 'package:gobid_admin/network/remote/db_utils_products.dart';
import 'package:gobid_admin/shared/strings/app_strings.dart';

class WaitingListVieModel extends BaseViewModel {
  List<Product>? products;

  String? errorMessage;

  void getWaitedProducts() async {
    //we will convert to Strem بعد الغدا
    //مكسل
    try {
      products =
          await DBUtilsProducts.getSelectedProductsList(confirmed: false);
    } catch (e) {
      errorMessage = AppStrings.somethingWontWrong;
    }
    notifyListeners();
  }

  void updateProduct(Product product) async {
    try {
      navigator!.showLoading();
      product.available = true;
      await DBUtilsProducts.setProductToFirestore(product);
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.successfullyUploaded, AppStrings.ok);
      getWaitedProducts();
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.somethingWontWrong, AppStrings.ok);
    }
  }

  void deleteProduct(String productID) async {
    try {
      navigator!.showLoading();
      await DBUtilsProducts.deleteProductFromFirestore(productID);
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.successfullyDeleted, AppStrings.ok);

      ///to rebuild screen after item is deleted
      getWaitedProducts();
    } catch (e) {
      navigator!.hideDialog();
      navigator!.showMessage(AppStrings.somethingWontWrong, AppStrings.ok);
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gobid_admin/model/product.dart';

class DBUtilsProducts {
  static CollectionReference<Product> getProductCollectionRef() {
    return FirebaseFirestore.instance
        .collection('products')
        .withConverter<Product>(
          fromFirestore: (snapshot, options) =>
              Product.fromJson(snapshot.data()!),
          toFirestore: (product, options) => product.toJson(),
        );
  }

  static setProductToFirestore(Product product) async {
    var ref = getProductCollectionRef();
    return await ref.doc(product.id).set(product);
  }

  static deleteProductFromFirestore(String productID) async {
    var ref = getProductCollectionRef();
    return await ref.doc(productID).delete();
  }

  static Future<List<Product>> getSelectedProductsList(
      {required bool confirmed}) async {
    // this method showing confirmed products for user
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot =
          await ref.where('available', isEqualTo: confirmed).get();

      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Product>> getProductsListByTitleSearch(
      String title) async {
    try {
      var ref = getProductCollectionRef();
      QuerySnapshot<Product> productsSnapshot = await ref
          .orderBy('title')
          .startAt([title]).endAt(['$title\uf8ff']).get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;
    } catch (e) {
      print('=========$e');
      rethrow;
    }
  }

  static Future<List<Product>> getProductsListByDate(String date) async {
    try {
      var ref = getProductCollectionRef();
      print('=========DB=$date');
      QuerySnapshot<Product> productsSnapshot = await ref
          .where('available', isEqualTo: true)
          .where('endDate', isEqualTo: date)
          .get();
      List<Product> products =
          productsSnapshot.docs.map((e) => e.data()).toList();
      return products;
    } catch (e) {
      print('=========$e');
      rethrow;
    }
  }
}

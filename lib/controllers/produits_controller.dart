import 'package:vetcam/boxes.dart';
import 'package:vetcam/models/produit_model.dart';

Future<void> addProduit(ProduitModel produit) async {
  final box = Boxes.getProduits();
  box.add(produit);
}

int getLastProduitId() {
  final box = Boxes.getIds();
  var produits = box.get('produits');
  if (produits == null) {
    box.put('produits', {"id": 1});
    return 1;
  } else {
    return (produits['id'] + 1) as int;
  }
}

Future<void> updateLastProduitId(int? id) async {
  final box = Boxes.getIds();
  box.put('produits', {"id": id});
}
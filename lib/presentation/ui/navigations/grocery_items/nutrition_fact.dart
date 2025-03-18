
import 'package:openfoodfacts/openfoodfacts.dart';

class FoodFacts{
Future<Product?> fetchProduct(String barcode) async {
    OpenFoodAPIConfiguration.userAgent = UserAgent(
    name: 'fridge-to-feast',
  );
  final ProductQueryConfiguration configuration = ProductQueryConfiguration(
    barcode,
    languages: [OpenFoodFactsLanguage.ENGLISH],
    fields: [ProductField.ALL], version: ProductQueryVersion.v3,
    country: OpenFoodFactsCountry.INDIA,
    
  );
  final ProductResultV3 result = await OpenFoodAPIClient.getProductV3(configuration);
  if (result.status == "success") {
         final Product? product = result.product;
        return product;
      } else {
       print("failed");
       return null;
  }
}

}
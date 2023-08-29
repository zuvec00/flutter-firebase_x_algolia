import 'package:algolia/algolia.dart';

class AlgoliaApplication {
  static Algolia algolia =
      const Algolia.init(applicationId: 'APPLICATION ID', apiKey: 'APIKEY');
}

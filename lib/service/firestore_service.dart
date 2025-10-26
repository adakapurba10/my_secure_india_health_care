class FirestoreService {
  Future<List<Map<String, dynamic>>> getProducts(String query) async {
    // Minimal stub for now
    await Future<void>.delayed(const Duration(milliseconds: 100));
    return [
      {'name': 'Paracetamol', 'price': 50},
      {'name': 'Hand Sanitizer', 'price': 120},
    ];
  }
}

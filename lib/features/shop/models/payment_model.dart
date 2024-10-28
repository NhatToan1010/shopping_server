class PaymentModel {
  final String name;
  final String image;

  PaymentModel({required this.name, required this.image});

  static PaymentModel empty() => PaymentModel(name: '', image: '');
}
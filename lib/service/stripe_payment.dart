import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app/constants/stripe_keys.dart';

class PaymentService {
  // Private constructor for singleton pattern
  PaymentService._();

  // Singleton instance of PaymentService
  static final PaymentService paymentInstance = PaymentService._();


  /// Function to initiate the payment
  Future<void> makePayment(int amount, String currency) async {
    try {
      // Create a payment intent and get its result
      String? paymentIntent = await createPaymentIntent(amount, currency);

      // Check if the payment intent was created successfully
      if (paymentIntent != null) {
        print("Payment intent created successfully: $paymentIntent");
        await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret:paymentIntent,
          merchantDisplayName: 'Miki Shibabaw' 
        ));
        await processPayment();
      } else {
        print("Failed to create payment intent.");
      }
    } catch (e) {
      print("Error during makePayment: ${e.toString()}");
    }
  }

  /// Function to create a payment intent
  Future<String?> createPaymentIntent(int amount, String currency) async {
    try {
      // Initialize Dio instance
      final Dio dio = Dio();

      // Prepare data for payment intent
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount), // Convert the amount to Stripe's format
        "currency": currency,
      };

      // Send the POST request to Stripe API
      Response response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          headers: {
            "Authorization": "Bearer $secretKey",
            "Content-Type": "application/x-www-form-urlencoded",
          },
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      // Check the response and extract the client secret
      if (response.statusCode == 200) {
        print("Payment intent created: ${response.data}");
        return response.data["client_secret"]; // Return the client secret
      } else {
        print("Failed to create payment intent: ${response.statusCode}");
      }
    } catch (e) {
      print("Error during createPaymentIntent: ${e.toString()}");
    }
    return null; // Return null in case of an error
  }
  Future<void> processPayment()async{
  try {
    await Stripe.instance.presentPaymentSheet();
    await Stripe.instance.confirmPaymentSheetPayment();
  } catch (e) {
    print(e);
  }
  }
  /// Private helper function to calculate the amount in Stripe's format (smallest currency unit)
  String _calculateAmount(int amount) {
    final calculatedAmount = amount * 100; // Stripe requires amounts in cents
    return calculatedAmount.toString();
  }
}

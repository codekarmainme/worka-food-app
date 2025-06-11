
import 'package:flutter/material.dart';

class PaymentFallback extends StatelessWidget {
  const PaymentFallback({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve arguments passed from the Navigator
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Extract the necessary information from the arguments
    final String? message = args?['message'];
    final String? transactionReference = args?['transactionReference'];
    final String? paidAmount = args?['paidAmount'];

    // Determine the status based on the message
    String status;
    Color statusColor;

    switch (message) {
      case 'paymentSuccessful':
        status = 'Payment Successful';
        statusColor = Colors.green;
        break;
      case 'paymentFailed':
        status = 'Payment Failed';
        statusColor = Colors.red;
        break;
      case 'paymentCancelled':
        status = 'Payment Cancelled';
        statusColor = Colors.orange;
        break;
      default:
        status = 'Unknown Status';
        statusColor = Colors.grey;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Status'),
        backgroundColor: statusColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                message == 'paymentSuccessful'
                    ? Icons.check_circle
                    : message == 'paymentFailed'
                        ? Icons.error
                        : Icons.cancel,
                color: statusColor,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                status,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: statusColor,
                ),
              ),
              const SizedBox(height: 20),
              if (transactionReference != null)
                Text(
                  'Transaction Reference: $transactionReference',
                  style: const TextStyle(fontSize: 16),
                ),
              if (paidAmount != null)
                Text(
                  'Amount Paid: $paidAmount',
                  style: const TextStyle(fontSize: 16),
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate back to the home screen or any other desired screen
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text('Return to Home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

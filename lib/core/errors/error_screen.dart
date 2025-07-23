import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ErrorScreen extends StatelessWidget {
  final FlutterErrorDetails? errorDetails;
  final VoidCallback? onHomePressed;
  final VoidCallback? onHelpPressed;

  const ErrorScreen({
    super.key,
    this.errorDetails,
    this.onHomePressed,
    this.onHelpPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Oops!',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                kDebugMode
                    ? errorDetails?.exception.toString() ??
                        'Well, this is unexpected...'
                    : 'Well, this is unexpected...\n'
                        'An error has occurred and we\'re working to fix the problem! '
                        'We\'ll be up and running shortly.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 40),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: onHomePressed,
                    child: const Text('Back to Homepage'),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: onHelpPressed,
                    child: const Text('Visit our help center'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

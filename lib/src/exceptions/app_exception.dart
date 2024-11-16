import 'package:reset_life/src/l10n/string_hardcoded.dart';

/// Base class for all all client-side errors that can be generated by the app
sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

/// Auth
class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException() : super('email-already-in-use', 'Email already in use'.hardcoded);
}

class WeakPasswordException extends AppException {
  WeakPasswordException() : super('weak-password', 'Password is too weak'.hardcoded);
}

class WrongPasswordException extends AppException {
  WrongPasswordException() : super('wrong-password', 'Wrong password'.hardcoded);
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'User not found'.hardcoded);
}

class UserNotSignedInException extends AppException {
  UserNotSignedInException()
      : super('user-not-signed-in', 'The operation can\'t be completed (not signed in)'.hardcoded);
}

/// Cart
class CartSyncFailedException extends AppException {
  CartSyncFailedException()
      : super(
            'cart-sync-failed', 'An error has occurred while updating the shopping cart'.hardcoded);
}

/// Checkout
class PaymentFailureEmptyCartException extends AppException {
  PaymentFailureEmptyCartException()
      : super('payment-failure-empty-cart', 'Can\'t place an order if the cart is empty'.hardcoded);
}

// Products
class NullProductImageUrlException extends AppException {
  NullProductImageUrlException()
      : super('user-not-signed-in', 'Can\'t upload a product with a null image'.hardcoded);
}

/// Orders
class ParseOrderFailureException extends AppException {
  ParseOrderFailureException(this.status)
      : super('parse-order-failure', 'Could not parse order status: $status'.hardcoded);
  final String status;
}

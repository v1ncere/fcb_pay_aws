part of 'payment_buttons_bloc.dart';

sealed class PaymentButtonsEvent extends Equatable {
  const PaymentButtonsEvent();

  @override
  List<Object> get props => [];
}

final class PaymentButtonsFetched extends PaymentButtonsEvent {}

final class PaymentButtonsFailed extends PaymentButtonsEvent {
  const PaymentButtonsFailed(this.message);
  final String message;

  @override
  List<Object> get props => [message];
}

final class PaymentButtonsRefreshed extends PaymentButtonsEvent {}
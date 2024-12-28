part of 'receipt_bloc.dart';

sealed class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  @override
  List<Object?> get props => [];
}

final class ReceiptDisplayStreamed extends ReceiptEvent {}

final class ReceiptDisplayUpdated extends ReceiptEvent {
  const ReceiptDisplayUpdated(this.receipt);
  final Receipt? receipt;

  @override
  List<Object?> get props => [receipt];
}
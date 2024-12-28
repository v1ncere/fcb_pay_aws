part of 'transfer_buttons_bloc.dart';

sealed class TransferButtonsEvent extends Equatable {
  const TransferButtonsEvent();

  @override
  List<Object> get props => [];
}

final class TransferButtonsFetched extends TransferButtonsEvent {}

final class TransferButtonsRefreshed extends TransferButtonsEvent {}
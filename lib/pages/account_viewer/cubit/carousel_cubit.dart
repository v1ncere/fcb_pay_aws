import 'package:equatable/equatable.dart';
import 'package:fcb_pay_aws/models/Account.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'carousel_state.dart';

final accountEmpty = Account(accountNumber: '');

class CarouselCubit extends Cubit<CarouselState> {
  CarouselCubit() : super(CarouselState(account: accountEmpty));

  void setSlideIndex({required int index}) => emit(state.copyWith(index: index));

  void setAccount({required Account account}) => emit(state.copyWith(account: account)); 
}

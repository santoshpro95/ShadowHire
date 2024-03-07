import 'package:flutter/material.dart';
import 'package:shadowhire/features/payment/payment_bloc.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  // region Bloc
  late PaymentBloc paymentBloc;
  // endregion

  // region Init
  @override
  void initState() {
    paymentBloc = PaymentBloc(context);
    paymentBloc.init();
    super.initState();
  }
  // endregion

  // region Dispose
  @override
  void dispose() {
    paymentBloc.dispose();
    super.dispose();
  }
  // endregion

  // region body
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body(),
    );
  }

  // endregion

  // region body
  Widget body() {
    return Container();
  }
// endregion
}

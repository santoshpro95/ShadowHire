import 'package:flutter/material.dart';
import 'package:shadowhire/features/details/details_bloc.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  // region Bloc
  late DetailsBloc detailsBloc;

  // endregion

  // region Init
  @override
  void initState() {
    detailsBloc = DetailsBloc(context);
    detailsBloc.init();
    super.initState();
  }

  // endregion

  // region Dispose
  @override
  void dispose() {
    detailsBloc.dispose();
    super.dispose();
  }

  // endregion

  // region Build
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
// endregion
}

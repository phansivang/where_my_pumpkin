import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/widgets/custom_scaffold.dart';
import '../../../../core/shared/widgets/custom_text.dart';
import '../../../../routes/route_name.dart';

/// A page class for splash page
class SplashPage extends StatelessWidget {
  /// Creates an instance of [SplashPage]
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _SplashPageContent();
  }
}

class _SplashPageContent extends StatefulWidget {
  const _SplashPageContent();

  @override
  State<_SplashPageContent> createState() => __SplashPageContentState();
}

class __SplashPageContentState extends State<_SplashPageContent> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      final goRouterContext = GoRouter.of(context);
      goRouterContext.pushReplacementNamed(RouteName.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: CircularProgressIndicator()),
          SizedBox(height: 16),
          Center(child: CustomText('Loading...')),
        ],
      ),
    );
  }
}

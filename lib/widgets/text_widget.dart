import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_sample/providers/session_provider.dart';
import 'package:flutter_sample/utils/constants.dart';
import 'package:flutter_sample/utils/extensions.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class Greeting extends StatelessWidget {
  const Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: Spacings.regularPadding,
        top: Spacings.largePadding,
        right: Spacings.regularPadding,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTimeGreeting(),
          Text(
            context.localizations.goodDayForCoffee,
            style: context.theme.textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeGreeting() {
    return Consumer(
      builder: (context, ref, child) {
        final hour = TimeOfDay.now().hour;
        final user = ref.watch(sessionProvider).user;
        final String greeting;
        final String starting;

        if (hour >= 0 && hour < 12) {
          starting = context.localizations.goodMorning;
        } else if (hour >= 12 && hour < 18) {
          starting = context.localizations.goodAfternoon;
        } else {
          starting = context.localizations.goodEvening;
        }

        if (user.isGuest) {
          greeting = "$starting, Angel.";
        } else {
          greeting = "$starting, ${user.givenName}.";
        }

        return Text(
          greeting,
          style: context.theme.textTheme.headlineLarge,
        );
      },
    );
  }
}

class FormattedPrice extends HookWidget {
  const FormattedPrice({
    super.key,
    required this.originalPrice,
    this.style,
  });

  final double originalPrice;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final price = useMemoized(() {
      final locale = context.locale.toString();
      final format = NumberFormat.simpleCurrency(locale: locale);

      return format.format(originalPrice);
    }, [originalPrice]);

    return Text(
      price,
      style: style,
    );
  }
}

class FormattedPriceTag extends StatelessWidget {
  const FormattedPriceTag({
    super.key,
    required this.originalPrice,
  });

  final double originalPrice;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(Shapes.buttonRadius),
      child: Container(
        color: context.theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(Spacings.smallPadding),
          child: FormattedPrice(
            originalPrice: originalPrice,
            style: context.theme.textTheme.displaySmall?.copyWith(
              color: context.theme.colorScheme.onPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

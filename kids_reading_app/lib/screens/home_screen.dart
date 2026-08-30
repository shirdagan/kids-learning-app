import 'package:flutter/material.dart';

import '../i18n/app_strings.dart';
import '../i18n/language_controller.dart';
import '../theme/app_theme.dart';
import '../widgets/bounce_in.dart';
import '../widgets/module_tile.dart';
import '../widgets/responsive_center.dart';
import 'coming_soon_screen.dart';
import 'colors/colors_menu_screen.dart';

/// מסך הפתיחה: כפתורים גדולים לכל מודול לימוד. רק מודול הצבעים פעיל
/// כרגע, שאר המודולים מסומנים "בקרוב" ומובילים למסך שמור מקום.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final language = LanguageScope.of(context);
    final l = language.value;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ResponsiveCenter(
            child: Column(
              children: [
                Row(
                  children: [
                    const Spacer(),
                    _LanguageToggleButton(controller: language),
                  ],
                ),
                BounceIn(
                  child: Text(
                    AppStrings.homeTitle(l),
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    childAspectRatio: 1.15,
                    children: [
                      ModuleTile(
                        label: AppStrings.moduleColors(l),
                        icon: Icons.palette_rounded,
                        color: AppTheme.primary,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const ColorsMenuScreen(),
                          ),
                        ),
                      ),
                      ModuleTile(
                        label: AppStrings.moduleAnimals(l),
                        icon: Icons.pets_rounded,
                        color: const Color(0xFF8D6E63),
                        comingSoon: true,
                        onTap: () => _openComingSoon(
                          context,
                          title: AppStrings.moduleAnimals(l),
                          icon: Icons.pets_rounded,
                          color: const Color(0xFF8D6E63),
                        ),
                      ),
                      ModuleTile(
                        label: AppStrings.moduleNumbers(l),
                        icon: Icons.looks_one_rounded,
                        color: AppTheme.secondary,
                        comingSoon: true,
                        onTap: () => _openComingSoon(
                          context,
                          title: AppStrings.moduleNumbers(l),
                          icon: Icons.looks_one_rounded,
                          color: AppTheme.secondary,
                        ),
                      ),
                      ModuleTile(
                        label: AppStrings.moduleLetters(l),
                        icon: Icons.abc_rounded,
                        color: const Color(0xFF9C6ADE),
                        comingSoon: true,
                        onTap: () => _openComingSoon(
                          context,
                          title: AppStrings.moduleLetters(l),
                          icon: Icons.abc_rounded,
                          color: const Color(0xFF9C6ADE),
                        ),
                      ),
                      ModuleTile(
                        label: AppStrings.moduleWords(l),
                        icon: Icons.menu_book_rounded,
                        color: const Color(0xFFF17DB0),
                        comingSoon: true,
                        onTap: () => _openComingSoon(
                          context,
                          title: AppStrings.moduleWords(l),
                          icon: Icons.menu_book_rounded,
                          color: const Color(0xFFF17DB0),
                        ),
                      ),
                      ModuleTile(
                        label: AppStrings.moduleMath(l),
                        icon: Icons.calculate_rounded,
                        color: AppTheme.success,
                        comingSoon: true,
                        onTap: () => _openComingSoon(
                          context,
                          title: AppStrings.moduleMath(l),
                          icon: Icons.calculate_rounded,
                          color: AppTheme.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openComingSoon(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) =>
            ComingSoonScreen(title: title, icon: icon, color: color),
      ),
    );
  }
}

/// כפתור קטן, למבוגר/אח גדול, שמחליף בין עברית לאנגלית.
class _LanguageToggleButton extends StatelessWidget {
  const _LanguageToggleButton({required this.controller});

  final LanguageController controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: controller.toggle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.language_rounded,
                size: 20,
                color: AppTheme.primary,
              ),
              const SizedBox(width: 6),
              Text(
                AppStrings.languageToggleLabel(controller.value),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

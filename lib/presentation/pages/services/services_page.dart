import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';
import '../../../data/models/service.dart';
import '../../../data/repositories/static_data.dart';
import '../../widgets/common/display_title.dart';
import '../../widgets/common/eyebrow.dart';
import '../../widgets/common/page_scaffold.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;
    final vPad = mobile ? AppSpacing.sectionMobile : AppSpacing.section;

    return PageScaffold(
      breadcrumbs: const [
        BreadcrumbItem('Home', route: '/'),
        BreadcrumbItem('Serviços'),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Eyebrow('Serviços'),
              const SizedBox(height: 16),
              DisplayTitle(before: 'O que posso ', highlight: 'criar', after: ' com você.'),
              const SizedBox(height: 8),
              Text(
                'Pacotes flexíveis, adaptados ao escopo, prazo e orçamento do seu projeto.',
                style: AppTextStyles.body(),
              ),
              const SizedBox(height: 64),
              ...StaticData.services.map((s) => _ServiceItem(service: s)),
            ],
          ),
        ),
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final Service service;
  const _ServiceItem({required this.service});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.hairline),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 64,
                  child: Text(
                    service.order.toString().padLeft(2, '0'),
                    style: AppTextStyles.serviceNumber(),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(service.title, style: AppTextStyles.cardTitle(size: 22)),
                          if (service.featured) ...[
                            const SizedBox(width: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.gold),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text('MAIS PROCURADO', style: AppTextStyles.tag()),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(service.description, style: AppTextStyles.body()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
}

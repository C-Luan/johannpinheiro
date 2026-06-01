import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';
import '../../../data/repositories/static_data.dart';
import '../../widgets/common/display_title.dart';
import '../../widgets/common/eyebrow.dart';
import '../../widgets/common/page_scaffold.dart';
import '../../widgets/common/quote_block.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile ? AppSpacing.containerPaddingMobile : AppSpacing.containerPadding;
    final vPad = mobile ? AppSpacing.sectionMobile : AppSpacing.section;

    return PageScaffold(
      breadcrumbs: const [
        BreadcrumbItem('Home', route: '/'),
        BreadcrumbItem('Sobre'),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSpacing.containerMaxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Eyebrow('Sobre mim'),
              const SizedBox(height: 16),
              DisplayTitle(
                before: 'Transformando histórias em vídeo desde ',
                highlight: '2021',
                after: '.',
              ),
              const SizedBox(height: 64),
              mobile ? _MobileLayout() : _DesktopLayout(),
              const SizedBox(height: 64),
              const QuoteBlock(
                'Acredito que todo projeto possui uma história que merece ser contada da maneira certa.',
              ),
              const SizedBox(height: 64),
              const _ToolsSection(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _PhotoBlock()),
          const SizedBox(width: 64),
          const Expanded(flex: 2, child: _BioText()),
        ],
      );
}

class _MobileLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PhotoBlock(),
          const SizedBox(height: 40),
          const _BioText(),
        ],
      );
}

class _PhotoBlock extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            height: 480,
            color: AppColors.surfaceCard,
            child: const Center(
              child: Icon(Icons.person_outline, color: AppColors.hairline, size: 80),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: AppColors.background.withAlpha(220),
              child: const QuoteBlock('A luz conta a história.'),
            ),
          ),
        ],
      );
}

class _BioText extends StatelessWidget {
  const _BioText();

  static const _paragraphs = [
    'Minha relação com o audiovisual começou muito antes de se tornar uma profissão.',
    'Quando criança, ganhei meu primeiro celular com câmera, um Nokia 2630. Foi ali que comecei a experimentar. Criava vídeos simples, animações em stop motion e pequenas produções por diversão, sem imaginar que aquilo um dia se tornaria minha carreira.',
    'Em 2021, enquanto servia na igreja, tive a oportunidade de começar a produzir vídeos de forma mais consistente. Foi nesse período que entendi que isso era meu propósito — eu deveria transformar essa habilidade em profissão e seguir um caminho dedicado ao audiovisual.',
    'Desde então, venho construindo minha trajetória como videomaker, atuando em projetos que unem técnica, estratégia e narrativa para comunicar mensagens de forma clara e impactante.',
    'Hoje meu trabalho é voltado principalmente para empresas, instituições e profissionais que desejam fortalecer sua presença através de vídeos de alta qualidade — seja por meio de conteúdo para redes sociais, campanhas comerciais, vídeos institucionais ou cobertura de eventos.',
  ];

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _paragraphs
            .map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text(p, style: AppTextStyles.body(size: 17)),
                ))
            .toList(),
      );
}

class _ToolsSection extends StatelessWidget {
  const _ToolsSection();

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(height: 1, color: AppColors.hairline),
        const SizedBox(height: 32),
        const Eyebrow('Ferramentas'),
        const SizedBox(height: 24),
        Wrap(
          spacing: 48,
          runSpacing: 24,
          children: StaticData.tools
              .map((t) => _ToolChip(label: t.label, value: t.value))
              .toList(),
        ),
      ],
    );
}

class _ToolChip extends StatelessWidget {
  final String label;
  final String value;
  const _ToolChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.eyebrow(size: 11)),
          const SizedBox(height: 6),
          Text(value, style: AppTextStyles.body(size: 15, color: AppColors.textPrimary)),
        ],
      );
}

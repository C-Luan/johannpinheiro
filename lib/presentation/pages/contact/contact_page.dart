import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/breakpoints.dart';
import '../../widgets/common/display_title.dart';
import '../../widgets/common/eyebrow.dart';
import '../../widgets/common/gold_button.dart';
import '../../widgets/common/page_scaffold.dart';

enum _ProjectType {
  captacao('Captação de Conteúdo'),
  corporativo('Evento Corporativo'),
  esportivo('Evento Esportivo'),
  institucional('Vídeo Institucional'),
  comercial('Vídeo Comercial'),
  outro('Outro');

  final String label;
  const _ProjectType(this.label);
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = Breakpoints.isMobile(context);
    final hPad = mobile
        ? AppSpacing.containerPaddingMobile
        : AppSpacing.containerPadding;
    final vPad = mobile ? AppSpacing.sectionMobile : AppSpacing.section;

    return PageScaffold(
      breadcrumbs: const [
        BreadcrumbItem('Home', route: '/'),
        BreadcrumbItem('Contato'),
      ],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: hPad, vertical: vPad),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppSpacing.containerMaxWidth,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Eyebrow('Contato'),
              const SizedBox(height: 16),
              DisplayTitle(
                before: 'Vamos conversar sobre o seu ',
                highlight: 'projeto',
                after: '.',
              ),
              const SizedBox(height: 64),
              mobile
                  ? const _MobileContactLayout()
                  : const _DesktopContactLayout(),
            ],
          ),
        ),
      ),
    );
  }
}

class _DesktopContactLayout extends StatelessWidget {
  const _DesktopContactLayout();

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Expanded(child: _ContactInfo()),
      SizedBox(width: 80),
      Expanded(flex: 2, child: _ContactForm()),
    ],
  );
}

class _MobileContactLayout extends StatelessWidget {
  const _MobileContactLayout();

  @override
  Widget build(BuildContext context) => const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [_ContactInfo(), SizedBox(height: 48), _ContactForm()],
  );
}

// ─── Info column ─────────────────────────────────────────────────────────────

class _ContactInfo extends StatelessWidget {
  const _ContactInfo();

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Pronto para levar seu projeto ao próximo nível? Entre em contato pelo canal de sua preferência.',
        style: AppTextStyles.body(size: 17),
      ),
      const SizedBox(height: 40),
      _ContactLink(
        label: 'contato@johann.film',
        url: 'mailto:contato@johann.film',
      ),
      const SizedBox(height: 16),
      _ContactLink(label: 'WhatsApp', url: 'https://wa.me/559188169032'),
      const SizedBox(height: 16),
      _ContactLink(
        label: '@johann.filmmaker',
        url: 'https://instagram.com/johann.filmmaker',
      ),
    ],
  );
}

class _ContactLink extends StatefulWidget {
  final String label;
  final String url;
  const _ContactLink({required this.label, required this.url});

  @override
  State<_ContactLink> createState() => _ContactLinkState();
}

class _ContactLinkState extends State<_ContactLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) => MouseRegion(
    cursor: SystemMouseCursors.click,
    onEnter: (_) => setState(() => _hovered = true),
    onExit: (_) => setState(() => _hovered = false),
    child: GestureDetector(
      onTap: () => launchUrl(Uri.parse(widget.url)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_forward,
            color: _hovered ? AppColors.goldHover : AppColors.gold,
            size: 14,
          ),
          const SizedBox(width: 8),
          Text(
            widget.label,
            style: AppTextStyles.body(
              size: 15,
              color: _hovered ? AppColors.goldHover : AppColors.gold,
            ),
          ),
        ],
      ),
    ),
  );
}

// ─── Form ────────────────────────────────────────────────────────────────────

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _formKey = GlobalKey<FormState>();

  final _name = TextEditingController();
  final _company = TextEditingController();
  final _role = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();
  final _deadline = TextEditingController();
  final _howFound = TextEditingController();
  _ProjectType? _projectType;

  @override
  void dispose() {
    for (final c in [
      _name,
      _company,
      _role,
      _phone,
      _email,
      _message,
      _deadline,
      _howFound,
    ]) {
      c.dispose();
    }
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final parts = [
      '*Novo contato via site*',
      '',
      '*Nome:* ${_name.text}',
      if (_company.text.isNotEmpty) '*Empresa:* ${_company.text}',
      if (_role.text.isNotEmpty) '*Cargo:* ${_role.text}',
      '*Telefone:* ${_phone.text}',
      if (_email.text.isNotEmpty) '*E-mail:* ${_email.text}',
      '*Tipo de projeto:* ${_projectType?.label ?? '-'}',
      '*Mensagem:* ${_message.text}',
      if (_deadline.text.isNotEmpty) '*Prazo desejado:* ${_deadline.text}',
      if (_howFound.text.isNotEmpty) '*Como conheceu:* ${_howFound.text}',
    ];

    final encoded = Uri.encodeComponent(parts.join('\n'));
    launchUrl(
      Uri.parse('https://wa.me/559188169032?text=$encoded'),
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _row([
          _field('Nome', _name, required: true),
          _field('Empresa', _company),
        ]),
        _row([
          _field('Cargo', _role),
          _field(
            'Telefone / WhatsApp',
            _phone,
            required: true,
            keyboardType: TextInputType.phone,
          ),
        ]),
        _row([
          _field('E-mail', _email, keyboardType: TextInputType.emailAddress),
          _projectTypeDropdown(),
        ]),
        _field('Mensagem', _message, required: true, maxLines: 5),
        _row([
          _field('Prazo desejado', _deadline),
          _field('Como conheceu meu trabalho?', _howFound),
        ]),
        const SizedBox(height: 32),
        SizedBox(
          width: double.infinity,
          child: GoldButton(label: 'Solicitar orçamento', onPressed: _submit),
        ),
      ],
    ),
  );

  Widget _row(List<Widget> children) => Padding(
    padding: const EdgeInsets.only(bottom: 0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          children
              .expand((w) => [Expanded(child: w), const SizedBox(width: 16)])
              .toList()
            ..removeLast(),
    ),
  );

  Widget _field(
    String label,
    TextEditingController controller, {
    bool required = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.eyebrow(size: 10)),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: AppTextStyles.body(size: 15, color: AppColors.textPrimary),
          cursorColor: AppColors.gold,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surfaceCard,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AppColors.hairline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AppColors.hairline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AppColors.gold),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
          validator: required
              ? (v) =>
                    (v == null || v.trim().isEmpty) ? 'Campo obrigatório' : null
              : null,
        ),
      ],
    ),
  );

  Widget _projectTypeDropdown() => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('TIPO DE PROJETO', style: AppTextStyles.eyebrow(size: 10)),
        const SizedBox(height: 6),
        DropdownButtonFormField<_ProjectType>(
          initialValue: _projectType,
          dropdownColor: AppColors.surfaceCard,
          style: AppTextStyles.body(size: 15, color: AppColors.textPrimary),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.surfaceCard,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AppColors.hairline),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AppColors.hairline),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(2),
              borderSide: const BorderSide(color: AppColors.gold),
            ),
          ),
          icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.gold),
          items: _ProjectType.values
              .map((t) => DropdownMenuItem(value: t, child: Text(t.label)))
              .toList(),
          onChanged: (v) => setState(() => _projectType = v),
          validator: (v) => v == null ? 'Selecione o tipo' : null,
        ),
      ],
    ),
  );
}

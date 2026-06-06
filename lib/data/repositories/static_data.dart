import '../models/work.dart';
import '../models/service.dart';
import '../models/differential.dart';
import '../models/tool_item.dart';

abstract class StaticData {
  static const List<Work> works = [
    Work(
      id: 'vereda',
      title: 'Conteúdo digital — Clínica Vereda',
      category: WorkCategory.captacao,
      year: 2025,
    ),
    Work(
      id: 'nexus',
      title: 'Convenção Anual Nexus',
      category: WorkCategory.corporativo,
      year: 2025,
    ),
    Work(
      id: 'volt02',
      title: 'Campanha Lançamento Volt 02',
      category: WorkCategory.comercial,
      year: 2024,
    ),
    Work(
      id: 'carla',
      title: 'Série de Posicionamento — Dra. Carla M.',
      category: WorkCategory.captacao,
      year: 2024,
    ),
  ];

  static const List<Service> services = [
    Service(
      order: 1,
      title: 'Captação de Conteúdo',
      description:
          'Produção de vídeos voltados para redes sociais, posicionamento de marca e fortalecimento da autoridade profissional. Ideal para empresas, clínicas, especialistas e empreendedores que desejam criar uma presença digital consistente através de conteúdo em vídeo.',
      featured: true,
    ),
    Service(
      order: 2,
      title: 'Cobertura de Eventos Corporativos',
      description:
          'Registro completo de congressos, convenções, treinamentos, lançamentos, feiras e eventos empresariais. Produção focada em valorizar a experiência do público, fortalecer a marca organizadora e gerar material para divulgação futura.',
    ),
    Service(
      order: 3,
      title: 'Cobertura de Eventos Esportivos',
      description:
          'Cobertura audiovisual de competições, campeonatos e eventos esportivos. Produção dinâmica que transmite a intensidade, emoção e energia do esporte, valorizando atletas, organizações e patrocinadores.',
    ),
    Service(
      order: 4,
      title: 'Vídeos Institucionais',
      description:
          'Produção de vídeos que apresentam a essência, os valores, a cultura e a história de empresas e instituições. Uma ferramenta poderosa para fortalecer reputação, credibilidade e conexão com clientes, parceiros e colaboradores.',
    ),
    Service(
      order: 5,
      title: 'Vídeos Comerciais e Campanhas',
      description:
          'Produção de peças publicitárias para lançamento de produtos, serviços e campanhas promocionais. Conteúdo desenvolvido para despertar interesse, gerar desejo e impulsionar resultados de marketing.',
    ),
  ];

  static const List<Differential> differentials = [
    Differential(
      title: 'Produção estratégica',
      description:
          'Cada vídeo é pensado para cumprir um objetivo de comunicação.',
    ),
    Differential(
      title: 'Qualidade profissional',
      description:
          'Captação e edição com atenção aos detalhes técnicos e narrativos.',
    ),
    Differential(
      title: 'Atendimento personalizado',
      description:
          'Projetos adaptados à realidade e às necessidades de cada cliente.',
    ),
    Differential(
      title: 'Experiência em diferentes segmentos',
      description:
          'Atuação em conteúdo digital, eventos corporativos, esportivos, institucionais e campanhas comerciais.',
    ),
  ];

  static const List<ToolItem> tools = [
    ToolItem(label: 'Captação cinema', value: 'Sony FX30'),
    ToolItem(label: 'Edição & color', value: 'DaVinci Resolve'),
  ];
}

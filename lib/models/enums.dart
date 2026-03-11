enum TipoUsuario {
  esposa('esposa'),
  marido('marido');

  final String value;
  const TipoUsuario(this.value);

  static TipoUsuario? fromString(String? value) {
    if (value == null) return null;
    return TipoUsuario.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TipoUsuario.marido,
    );
  }
}

enum StatusTarefa {
  todo('todo'),
  emAndamento('em_andamento'),
  concluido('concluido');

  final String value;
  const StatusTarefa(this.value);

  static StatusTarefa? fromString(String? value) {
    if (value == null) return null;
    return StatusTarefa.values.firstWhere(
      (e) => e.value == value,
      orElse: () => StatusTarefa.todo,
    );
  }
}

enum PrioridadeTarefa {
  baixa('baixa'),
  media('media'),
  alta('alta');

  final String value;
  const PrioridadeTarefa(this.value);

  static PrioridadeTarefa? fromString(String? value) {
    if (value == null) return null;
    return PrioridadeTarefa.values.firstWhere(
      (e) => e.value == value,
      orElse: () => PrioridadeTarefa.media,
    );
  }
}

enum CategoriaTarefa {
  limpeza('limpeza'),
  compras('compras'),
  manutencao('manutencao'),
  cozinha('cozinha'),
  quarto('quarto'),
  sala('sala'),
  banheiro('banheiro'),
  outro('outro');

  final String value;
  const CategoriaTarefa(this.value);

  static CategoriaTarefa? fromString(String? value) {
    if (value == null) return null;
    return CategoriaTarefa.values.firstWhere(
      (e) => e.value == value,
      orElse: () => CategoriaTarefa.outro,
    );
  }
}

enum TipoNotificacao {
  novaTarefa('nova_tarefa'),
  proximoPrazo('proximo_prazo'),
  tarefaAtrasada('tarefa_atrasada'),
  cobranca('cobranca');

  final String value;
  const TipoNotificacao(this.value);

  static TipoNotificacao? fromString(String? value) {
    if (value == null) return null;
    return TipoNotificacao.values.firstWhere(
      (e) => e.value == value,
      orElse: () => TipoNotificacao.novaTarefa,
    );
  }
}

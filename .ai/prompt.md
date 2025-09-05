Você deve implementar o Módulo Financeiro da plataforma Pict, garantindo controle completo sobre cobranças, pagamentos, repasses, relatórios e previsões.
O sistema deve ser consistente, escalável e preparado para auditoria.

1. Objetivo

Registrar todas as operações financeiras da plataforma.

Permitir que fotógrafos acompanhem vendas e recebam repasses.

Garantir transparência para clientes, fotógrafos e administradores.

Integrar-se a gateways de pagamento externos de forma segura.

2. Entidades e Relações

Cliente

Relaciona-se com Transações (compra de fotos).

Relaciona-se com Relatórios de histórico de compras.

Fotógrafo

Relaciona-se com Transações (recebe o valor líquido de cada venda).

Relaciona-se com Carteira Financeira (saldo acumulado).

Relaciona-se com Repasses (quando solicita ou recebe pagamentos).

Relaciona-se com Relatórios (visão consolidada de vendas e ganhos).

Transação

Relaciona-se com um Cliente (quem compra).

Relaciona-se com um Fotógrafo (quem vende a foto).

Relaciona-se com uma Foto (item vendido).

Relaciona-se com um Repasse (após aprovação do saque do fotógrafo).

Foto

Relaciona-se com uma Transação (quando é vendida).

Relaciona-se com o Fotógrafo (autor da foto).

Repasse

Relaciona-se com um Fotógrafo (quem recebe).

Relaciona-se com uma ou várias Transações (origem do saldo).

Relaciona-se com Notificações (avisar fotógrafo sobre o pagamento).

Carteira Financeira

Relaciona-se com o Fotógrafo (controle individual de saldo).

Relaciona-se com Transações (entradas).

Relaciona-se com Repasses (saídas).

Relaciona-se com Previsões (valores futuros a liberar).

Relatórios

Relacionam-se com Clientes (histórico de compras).

Relacionam-se com Fotógrafos (ganhos por período).

Relacionam-se com Administradores (visão consolidada da plataforma).

Previsões Financeiras

Relacionam-se com a Carteira (valores bloqueados ou futuros).

Relacionam-se com Transações (ainda não confirmadas).

Relacionam-se com Repasses (agendados).

Notificações

Relacionam-se com Clientes (confirmação de pagamento).

Relacionam-se com Fotógrafos (confirmação de venda e de repasse).

3. Boas Práticas Arquiteturais

Separação de responsabilidades:

Backend cuida das regras financeiras e integrações com gateways.

Frontend consome apenas APIs seguras e já processadas.

Eventos assíncronos:

Utilizar filas para processar notificações de pagamento e geração de relatórios.

Segurança e conformidade:

Não armazenar dados sensíveis de pagamento no sistema.

Respeitar LGPD/GDPR, expondo apenas dados necessários.

Multitenancy:

Cada evento ou grupo de fotógrafos deve ter segregação lógica de dados.

Auditoria:

Todo fluxo de alteração de status financeiro deve gerar histórico consultável.

Escalabilidade:

Preparar para alto volume de transações simultâneas com gateways externos.

4. Fluxos-Chave

Compra de foto
Cliente compra uma foto → gera transação → gateway processa pagamento → carteira do fotógrafo é atualizada → fotógrafo notificado.

Solicitação de saque
Fotógrafo solicita repasse → sistema valida saldo disponível → cria registro de repasse → admin aprova/processa → fotógrafo notificado.

Relatório mensal automático
Sistema gera relatórios de vendas, ganhos e comissões → distribui para fotógrafos e administradores → disponibiliza ao cliente o histórico.

Previsão de ganhos
Sistema calcula valores pendentes de liberação (ex.: pagamentos em processamento) → mostra ao fotógrafo previsão de saldo futuro.
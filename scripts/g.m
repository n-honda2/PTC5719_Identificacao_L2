% ptc5719-lista2/scripts/item_g.m
% Não usamos clear para manter os modelos do item D (limpos) no workspace
clc; close all;

% 1. Garantir que os dados e os modelos limpos existem
if ~exist('data_baixa', 'var'), run('c.m'); end
if ~exist('m_arx', 'var'), run('d.m'); end

% 2. Estimação com Dados de BAIXA Intensidade
na = 1; nb = 1; nk = 5;
m_arx_b   = arx(data_baixa, [na nb nk]);
m_armax_b = armax(data_baixa, [na nb 1 nk]);
m_oe_b    = oe(data_baixa, [nb 1 nk]);
m_bj_b    = bj(data_baixa, [nb 1 1 1 nk]);
m_fir_b   = arx(data_baixa, [0 40 nk]);

% 3. Estimação com Dados de ALTA Intensidade
m_arx_a   = arx(data_alta, [na nb nk]);
m_armax_a = armax(data_alta, [na nb 1 nk]);
m_oe_a    = oe(data_alta, [nb 1 nk]);
m_bj_a    = bj(data_alta, [nb 1 1 1 nk]);
m_fir_a   = arx(data_alta, [0 40 nk]);

% 4. Visualização: Comparando Modelo (Ruidoso) vs Processo (Limpo)
% Exemplo para a estrutura ARX (Baixa e Alta)
figure('Name', 'Item G - Robustez do Modelo ARX', 'Color', 'w');

% Simulações
y_mod_baixa = sim(m_arx_b, data_limpa.u);
y_mod_alta  = sim(m_arx_a, data_limpa.u);

plot(data_limpa.samplingInstants, data_limpa.y, 'k', 'LineWidth', 2); hold on;
plot(data_limpa.samplingInstants, y_mod_baixa, 'b--', 'LineWidth', 1.2);
plot(data_limpa.samplingInstants, y_mod_alta, 'r:', 'LineWidth', 1.2);

grid on; xlim([270 400]); ylim([-0.1 0.4]);
xlabel('Tempo (s)'); ylabel('Saída y');
title('Modelo ARX treinado com Ruído vs. Processo Real Limpo');
legend('Real (Limpo)', 'Modelo (Baixa Int.)', 'Modelo (Alta Int.)', 'Location', 'SouthEast');

% 5. Coleta de FIT para a Tabela do Relatório
[~, fit_b] = compare(data_baixa, m_arx_b, inf);
[~, fit_a] = compare(data_alta, m_arx_a, inf);
fprintf('FIT ARX (Baixa): %.2f%% | FIT ARX (Alta): %.2f%%\n', fit_b, fit_a);
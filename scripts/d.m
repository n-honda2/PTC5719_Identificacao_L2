% ptc5719-lista2/scripts/item_d_completo.m
clear; clc; close all;

% 1. Carrega os dados gerados no item C
if ~exist('data_limpa', 'var')
    % Se você renomeou o arquivo conforme sugerido anteriormente:
    run('c.m');
end

% 2. Estimação dos Modelos (Ordens do Item B)
na = 1; nb = 1; nk = 5;
m_arx   = arx(data_limpa, [na nb nk]);
m_armax = armax(data_limpa, [na nb 1 nk]);
m_oe    = oe(data_limpa, [nb 1 nk]);
m_bj    = bj(data_limpa, [nb 1 1 1 nk]);
m_fir   = arx(data_limpa, [0 40 nk]);

modelos = {m_fir, m_arx, m_armax, m_oe, m_bj};
nomes   = {'FIR', 'ARX', 'ARMAX', 'OE', 'BJ'};
cores   = {'#0072BD', '#D95319', '#EDB120', '#7E2F8E', '#77AC30'};

% --- FIGURA 1: ÍNDICES FIT (PREDIÇÃO INFINITA) ---
figure('Name', 'Item D - Analise FIT', 'Color', 'w');

for i = 1:5
    subplot(3, 2, i);
    
    % Calcula o FIT sem plotar (usando saída do comando)
    [y_sim_obj, fit_val] = compare(data_limpa, modelos{i}, inf); 
    
    % Plotagem Manual: Processo Real vs Modelo
    % Isso evita os warnings e o texto "untitled1"
    plot(data_limpa.samplingInstants, data_limpa.y, 'k', 'LineWidth', 1.2); hold on;
    plot(data_limpa.samplingInstants, y_sim_obj.y, 'Color', cores{i}, 'LineStyle', '--');
    
    % Ajuste de zoom focado no degrau
    xlim([270 350]); 
    ylim([-0.05 0.35]); 
    
    % Legenda customizada sem conflito
    legend('Real', sprintf('FIT %s: %.2f%%', nomes{i}, fit_val), 'Location', 'SouthEast', 'FontSize', 8);
    
    grid on;
    title(['Estrutura: ', nomes{i}]);
    xlabel('Tempo (s)'); ylabel('Amplitude');
end

sgtitle('Identificação: Zoom na Resposta ao Degrau (Dados Limpos)', 'Interpreter', 'none');

% --- FIGURA 2: RESPOSTA AO DEGRAU (AMPLITUDE 0,1) ---
figure('Name', 'Item D - Resposta ao Degrau (0.1)', 'Color', 'w');
plot(data_limpa.samplingInstants, data_limpa.y, 'k', 'LineWidth', 2.5); hold on;

for i = 1:5
    y_sim = sim(modelos{i}, data_limpa.u);
    plot(data_limpa.samplingInstants, y_sim, 'Color', cores{i}, 'LineStyle', '--', 'LineWidth', 1.2);
end

grid on;
axis([270 350 -0.05 0.35]); 
xlabel('Tempo (s)'); ylabel('Saída y');
title('Comparativo: Resposta ao Degrau (Amplitude 0,1)', 'Interpreter', 'tex');
legend(['Processo Limpo', nomes], 'Location', 'SouthEast');

fprintf('Exercício D concluído com sucesso.\n');
% ptc5719-lista2/scripts/item_f.m
% Removido o clear para permitir que as variáveis dos itens anteriores persistam
% clc; % O clc (limpar tela) pode ficar, ele não apaga variáveis.

% 1. Garantir que os modelos do Item D existam
if ~exist('m_fir', 'var')
    % Se o item_d_completo.m tiver 'clear', ele vai limpar o que estiver aqui.
    % Por isso, chamamos ele PRIMEIRO.
    run('item_d_completo.m'); 
end

% 2. DEFINIÇÃO DA PLANTA (Sempre depois de rodar outros scripts)
% Definimos aqui para garantir que o G_z1 exista, mesmo que o script acima tenha dado clear
K = 3; tau = 10; theta = 5; Ts = 1;
s = tf('s');
G_s = K / (tau*s + 1);
G_s.InputDelay = theta;
G_z1 = c2d(G_s, Ts, 'zoh'); 

% 3. Obter a resposta impulsiva teórica (40 amostras)
[y_imp_real, t_imp] = impulse(G_z1, 40); 

% 4. Extrair os coeficientes do modelo FIR
% m_fir.b contém [b0, b1, b2, ..., b40]
coef_fir = m_fir.b; 
t_fir = (0:length(coef_fir)-1) * Ts;

% 5. Plotagem
figure('Name', 'Item F - FIR vs Resposta Impulsiva', 'Color', 'w');
plot(t_imp, y_imp_real, 'k', 'LineWidth', 2); hold on;
stem(t_fir, coef_fir, 'r', 'filled', 'MarkerSize', 4);

grid on; xlim([0 45]);
xlabel('Tempo (s)'); ylabel('Amplitude g[k]');
title('Comparação: Coeficientes FIR vs. Resposta Impulsiva Real');
legend('Impulso Real (Teórico)', 'Coeficientes FIR Estimados');

% Cálculo do Erro para conferência
len = min(length(y_imp_real), length(coef_fir));
rmse = sqrt(mean((y_imp_real(1:len)' - coef_fir(1:len)).^2));
fprintf('RMSE entre FIR e Impulso Real: %.6f\n', rmse);
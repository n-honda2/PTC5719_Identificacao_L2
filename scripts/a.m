% ptc5719-lista2/scripts/item_a_b.m
clear; clc; close all;

%% Definição do Processo Contínuo
K = 3;
tau = 10;
theta = 5;

% Criando a FT no MATLAB
s = tf('s');
G_s = K / (tau*s + 1);
G_s.InputDelay = theta;

%% Cálculo dos Períodos de Amostragem
Ts_tau = tau / 10; % 1.0 s
Ts_ts  = (4 * tau) / 10; % 4.0 s

% Discretização via Segurador de Ordem Zero (ZOH)
G_z_1s = c2d(G_s, Ts_tau, 'zoh');
G_z_4s = c2d(G_s, Ts_ts, 'zoh');

%% Simulação da Resposta ao Degrau
t_sim_continuo = 0:0.1:70; 
[y_c, t_c] = step(G_s, t_sim_continuo);

% Para os discretos, o step já entende os períodos Ts se passarmos o tempo final
[y_d1, t_d1] = step(G_z_1s, 70);
[y_d4, t_d4] = step(G_z_4s, 70);

%% Plotagem para o Relatório
figure('Name', 'Item A - Escolha de Ts');
plot(t_c, y_c, 'y', 'LineWidth', 4); hold on;
stairs(t_d1, y_d1, 'b', 'LineWidth', 1.5);
stairs(t_d4, y_d4, 'Color','#D95319', 'LineWidth', 1.5); % Cor laranja/avermelhada
grid on;

xlabel('Tempo (s)');
ylabel('Amplitude');
title('Item A - Sinal amostrado de duas formas diferentes');
legend('Sinal original', 'Sinal 1s amostrado', 'Sinal 4s amostrado', 'Location', 'SouthEast');
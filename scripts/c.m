% ptc5719-lista2/scripts/item_c.m
clear; clc; close all;

% 1. Executa a simulação
% Certifique-se de que o Solver está em Fixed-step / ode4 no arquivo .slx
out = sim('c_sim.slx', 'StopTime', '600');

% 2. Extração dos dados (Structure with Time)
t = out.y.time;
y_limpa = out.y.signals(1).values;
y_baixa = out.y.signals(2).values;
y_alta  = out.y.signals(3).values;

u_sim    = out.u_sim;    % Sinal de entrada u
e1_baixa = out.e1_baixa; % Perturbação medida (baixa)
e1_alta  = out.e1_alta;  % Perturbação medida (alta)

% 3. Geração do sinal de entrada u (Necessário para a identificação posterior)
u = zeros(size(t));
u(t >= 275) = 0.1; 

% 4. Criação dos objetos iddata (Crucial para o Exercício D em diante)
% Nota: Se o erro 'unrecognized function iddata' persistir, 
% você precisará instalar o System Identification Toolbox.
Ts = 1; 
data_limpa = iddata(y_limpa, u, Ts);
data_baixa = iddata(y_baixa, u, Ts);
data_alta  = iddata(y_alta, u, Ts);

% 5. Plotagem Única para o Relatório
figure('Name', 'Saídas do Processo - Item C', 'Color', 'w');
plot(t, y_limpa, 'k', 'LineWidth', 2); hold on;
plot(t, y_baixa, 'Color', [0 0.4470 0.7410], 'LineWidth', 1); % Azul
plot(t, y_alta, 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1); % Laranja
grid on;

xlabel('Tempo (s)');
ylabel('Saída y(t)');
title('Saídas do Processo sob Perturbações (Item C)');
legend('y_{limpa}', 'y_{baixa}', 'y_{alta}', 'Location', 'SouthEast');

% Ajuste dos eixos para melhor visualização conforme a resolução do Gabriel
axis([0 600 -0.2 0.4]); 

fprintf('Dados processados. Gráfico de saídas gerado com sucesso.\n');
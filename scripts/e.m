if ~exist('m_arx', 'var')
    % Se você renomeou o arquivo conforme sugerido anteriormente:
    run('d.m');
end


% ptc5719-lista2/scripts/item_e.m
% 1. Definição do Ganho Real (do Exercício A)
K_real = 3;

% 2. Cálculo dos Ganhos Estacionários
% Para modelos de função de transferência (polinomiais)
K_arx   = dcgain(m_arx);
K_armax = dcgain(m_armax);
K_oe    = dcgain(m_oe);
K_bj    = dcgain(m_bj);

% Para o modelo FIR, o ganho estacionário é a soma de todos os seus coeficientes
% m_fir.b contém o vetor de coeficientes [b0, b1, ..., b40]
K_fir = sum(m_fir.b);

% 3. Organização dos resultados em uma Tabela
Estruturas = {'Real'; 'FIR'; 'ARX'; 'ARMAX'; 'OE'; 'BJ'};
Ganhos = [K_real; K_fir; K_arx; K_armax; K_oe; K_bj];

% Cálculo do Erro Percentual relativo ao real
Erros_Relativos = [0; abs(Ganhos(2:end) - K_real)/K_real * 100];

% Exibe a tabela formatada no Command Window
Tabela_Ganhos = table(Estruturas, Ganhos, Erros_Relativos, ...
    'VariableNames', {'Modelo', 'Ganho_Estacionario', 'Erro_Percentual'})


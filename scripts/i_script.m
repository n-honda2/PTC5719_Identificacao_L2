% ptc5719-lista2/scripts/item_i_final.m
% Identificação MISO (Multiple Input Single Output)

clc; % Não usamos clear para manter os parâmetros de Ts e atrasos

% 1. Verificação de Dados
% Garante que as variáveis e1 (perturbação) e u (entrada) existam
if ~exist('y_alta', 'var') || ~exist('e1_alta', 'var')
    fprintf('Variáveis não encontradas. Rodando simulação...\n');
    run('c.m'); 
end

% 2. Criação do Objeto MISO (Entradas: u e e1 | Saída: y)
% O segredo aqui é o alinhamento de tamanho (len)
len_a = min([length(y_alta), length(u_sim), length(e1_alta)]);

% Criando o iddata com 2 colunas de entrada: [Sinal_Controle, Perturbacao]
data_miso_a = iddata(y_alta(1:len_a), [u_sim(1:len_a), e1_alta(1:len_a)], Ts);

% Nomear os canais é CRUCIAL para o compare não se perder
data_miso_a.InputName = {'u', 'e1'};
data_miso_a.OutputName = {'y'};

% 3. Estimação Box-Jenkins MISO
% Estrutura das ordens: [nb1 nb2 nc nd nf1 nf2 nk1 nk2]
% Entrada 1 (u): Planta principal -> [nb=1, nf=1, nk=5]
% Entrada 2 (e1): Caminho do ruído -> [nb=1, nf=1, nk=0]
% Polinômios de erro (C e D): [1 1]
ordens_miso = [1 1 1 1 1 1 5 0]; 

fprintf('Estimando modelo BJ MISO (isso pode levar alguns segundos)...\n');
m_bj_miso_a = bj(data_miso_a, ordens_miso);

% 4. Validação e Plotagem (A parte onde dava erro)
% IMPORTANTE: Usamos data_miso_a (2 entradas) para validar o modelo MISO
figure('Name', 'Item I - Comparativo MISO', 'Color', 'w');

% O compare agora encontrará os canais 'u' e 'e1' corretamente
compare(data_miso_a, m_bj_miso_a, inf);

grid on;
title('Identificação MISO: u e e1 como entradas medidas', 'Interpreter', 'none');

% 5. Extração do FIT para o relatório
[~, fit_val] = compare(data_miso_a, m_bj_miso_a, inf);

fprintf('\n==================================================\n');
fprintf('             RESULTADO FINAL ITEM I              \n');
fprintf('FIT MISO (Alta Intensidade): %.2f%%\n', fit_val);
fprintf('==================================================\n');
% ptc5719-lista2/scripts/item_j.m
clc;

% 1. Garantir que os modelos e dados existam
if ~exist('m_bj_a', 'var'), run('g.m'); end

% 2. Análise de Resíduos
% O comando resid abre uma janela com dois gráficos:
% - Autocorrelação do resíduo (deve estar dentro da faixa de confiança - Ruído Branco)
% - Correlação cruzada entre entrada e resíduo (deve estar dentro da faixa - Independência)
figure('Name', 'Item J - Análise de Resíduos (Modelo BJ - Alta Intensidade)', 'Color', 'w');
resid(data_alta, m_bj_a);

% 3. Dica técnica: 
% Para o relatório, você pode extrair os valores se quiser ser mais preciso, 
% mas o gráfico do 'resid' já é a prova documental padrão.
grid on;
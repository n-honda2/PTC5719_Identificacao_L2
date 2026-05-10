% ptc5719-lista2/scripts/item_h.m
% 1. Garantir que os modelos do Item G existam no workspace
if ~exist('m_arx_b', 'var'), run('g.m'); end

K_real = 3;

% 2. Ganhos - Baixa Intensidade (Item G - Baixa)
G_baixa = [sum(m_fir_b.b); dcgain(m_arx_b); dcgain(m_armax_b); dcgain(m_oe_b); dcgain(m_bj_b)];

% 3. Ganhos - Alta Intensidade (Item G - Alta)
G_alta = [sum(m_fir_a.b); dcgain(m_arx_a); dcgain(m_armax_a); dcgain(m_oe_a); dcgain(m_bj_a)];

% 4. Organização dos dados
Estruturas = {'FIR'; 'ARX'; 'ARMAX'; 'OE'; 'BJ'};
Tabela_H = table(Estruturas, G_baixa, G_alta);
Tabela_H.Erro_Baixa_pct = abs(G_baixa - K_real)/K_real * 100;
Tabela_H.Erro_Alta_pct  = abs(G_alta - K_real)/K_real * 100;

disp('--- Tabela de Ganhos Estacionários (Dados Ruidosos) ---');
disp(Tabela_H);
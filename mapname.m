function nome_placa = mapname(nome_arq)

switch nome_arq
	%% placas vermelhas
	case 'R_1.jpg'
		nome_placa = 'PARADA OBRIGATORIA';
	case 'R_3.jpg'
		nome_placa = 'SENTIDO PROIBIDO';
	case 'R_4a.jpg'
		nome_placa = 'PROIBIDO VIRAR A ESQUERDA';
	case 'R_4b.jpg'
		nome_placa = 'PROIBIDO VIRAR A DIREITA';
	case 'R_5a.jpg'
		nome_placa = 'PROIBIDO RETORNAR A ESQUERDA';
	case 'R_6a.jpg'
		nome_placa = 'PROIBIDO ESTACIONAR';
	case 'R_6b.jpg'
		nome_placa = 'ESTACIONAMENTO REGULAMENTADO';
	case 'R_7.jpg'
		nome_placa = 'PROIBIDO ULTRAPASSAR';
	case 'R_19.jpg'
		nome_placa = 'VELOCIDADE MAXIMA PERMITIDA';
	case 'R_20.jpg'
		nome_placa = 'PROIBIDO ACIONAR BUZINA';
	case 'R_24a.jpg'
		nome_placa = 'SENTIDO DE CIRCULACAO';
	case 'R_25d.jpg'
		nome_placa = 'SIGA EM FRENTE OU A DIREITA';
	case 'R_26.jpg'
		nome_placa = 'SIGA EM FRENTE';
	case 'R_28.jpg'
		nome_placa = 'DUPLO SENTIDO DE CIRCULAÇÃO';
  otherwise
    nome_placa = 'PLACA NAO IDENTIFICADA';
endswitch
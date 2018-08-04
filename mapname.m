function nome_placa = mapname(nome_arq, proibido)
% mapeia os nomes das placas para cada arquivo de template

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
    if proibido
      nome_placa = 'PROIBIDO ESTACIONAR';
    else
		  nome_placa = 'ESTACIONAMENTO REGULAMENTADO';
    endif
	case 'R_7.jpg'
		nome_placa = 'PROIBIDO ULTRAPASSAR';
	case 'R_19.jpg'
		nome_placa = 'VELOCIDADE MAXIMA PERMITIDA';
	case 'R_20.jpg'
		nome_placa = 'PROIBIDO ACIONAR BUZINA';
	case 'R_24a.jpg'
		nome_placa = 'SENTIDO DE CIRCULACAO';
	case 'R_25c.jpg'
		nome_placa = 'SIGA EM FRENTE OU A ESQUERDA';
	case 'R_26.jpg'
    if proibido
      nome_placa = 'SENTIDO PROIBIDO';
    else
  		nome_placa = 'SIGA EM FRENTE';
    endif
	case 'R_28.jpg'
		nome_placa = 'DUPLO SENTIDO DE CIRCULAÇÃO';
  case 'R_34.jpg'
    nome_placa = 'CIRCULACAO EXCLUSIVA DE BICICLETAS';
  otherwise
    nome_placa = 'PLACA NAO IDENTIFICADA';
endswitch
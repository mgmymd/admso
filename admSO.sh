#!/bin/bash

menu()
{
   echo -e "\n|.....................................................|"
        echo "|.................Menu de Controle....................|" 
        echo "|1- Contar a quantidade de arquivos da pasta..........|" 
        echo "|2- Dar permissão de execução para um arquivo.........|" 
        echo "|3- Tirar todas as permissões de Outros do arquivo....|" 
        echo "|4- Copiar um arquivo de uma pasta para outra.........|"
	echo "|5- Trocar o nome de um arquivo.......................|"
	echo "|6- Criar um usuário..................................|"
	echo "|7- Listar os arquivos de uma pasta...................|"
	echo "|8- Mover um arquivo de uma pasta para outra..........|"
        echo "|9- Dar permissão de R.W. ............................|"
        echo "|10- Mudar senha de usuário...........................|"
	echo "|11- Deletar um usuário...............................|"
	echo "|12- Criar um grupo...................................|"
	echo "|13- Deletar um grupo.................................|"
	echo "|14- Adicionar usuário a um grupo ....................|"
	echo "|15- Listar grupos que o usuário faz parte............|"
	echo "|16- Remover usuário de um grupo......................|"
	echo "|17- Mudar o DONO do arquivo/diretório................|"
	echo "|18- Tornar usuário Administrador do grupo............|"
	echo "|19- Exibir o número IP...............................|"
	echo "|20- Exibir espaço de disco livre.....................|"
	echo "|21- Instalar/Atualizar SAMBA.........................|" 
	echo "|22- Compartilhamento de arquivo/diretório entre SOs..|"
	echo "|23- Listar compartilhamentos de um Host Remoto.......|"
	echo "|24- Apagar compartilhamentos criados.................|"
	echo "|25- Compartilhamentos por IP, usuário e senha........|"
	echo "|26- Listar compartilhamentos ativos..................|"
    echo "|0- Sair..............................................|"
    echo "|.....................................................|"
}

contarArquivos()
{
	        clear
	        ls -l
	        i=0
	        while [ $i -eq 0 ]
	        do
			echo -e "\nDigite qual pasta deseja contar (entre com o endereço completo):" 
               		read pasta
  		       	[ -d $pasta ]
               		if [ $? -eq 1 ]; then
               			echo "Diretório inexistente."
               		fi          	
               		[ -d $pasta ]	
               		if [ $? -eq 0 ]; then
            			echo -e "\nExistem ` ls -l $pasta | wc -l ` arquivos nesta pasta $pasta"
            			sleep 1
            			((i++))
            		fi
                done
}

darPermissaoExecutavel()
{
	clear
	ls -l
        i=0
        while [ $i -eq 0 ]
        do
        	echo -e "\nDigite qual arquivo você deseja tornar executável: "
       		read arquivo
       		[ -e $arquivo ]
		if [ $? -eq 1 ]; then
			echo "Arquivo inexistente."
		fi
		
		[ -e $arquivo ]
		if [ $? -eq 0 ]; then
       	     		[ -x $arquivo ]
			if [ $? -eq 0 ]; then
				echo "O $arquivo já era executável."
			fi
		
			[ -x $arquivo ]
			if [ $? -eq 1 ]; then 
				chmod +x $arquivo
				echo "O $arquivo agora é executável."
			ls -l |grep "$arquivo" |awk '{print $1 $9}'
				sleep 2
			((i++))
			fi
		fi
	done
}

tirarPermissaoOutros()
{
	clear
	ls -l
	i=0
	while [ $i -eq 0 ]
	do      
		echo -e "\nDigite qual arquivo deseja tirar todas as permissões (R.W.X) de Outros: "
       		read tirar
		
		[ -e $tirar ]
		if [ $? -eq 1 ]; then
			echo "Arquivo inexistente."
		fi		
		
		[ -e $tirar ]
		if [ $? -eq 0 ]; then
			[ -r $tirar ] 
			if [ $? -eq 1 ]; then
				echo "O arquivo já não tinha a permissão de leitura (R) por outros."
			fi
			[ -r $tirar ] 
			if [ $? -eq 0 ]; then
				chmod o-r $tirar
				echo "O arquivo $tirar perdeu a permissão de leitura (R) por outros."
			fi
			[ -w $tirar ]
			if [ $? -eq 1 ]; then
				echo "O arquivo já não tinha a permissão de escrita (W) por outros."
			fi
			[ -w $tirar ]
			if [ $? -eq 0 ]; then
				chmod o-w $tirar
				echo "O arquivo $tirar perdeu a permissão de escrita (w) por outros."
			fi
			[ -x $tirar ]
			if [ $? -eq 1 ]; then
				echo "O arquivo já não tinha a permissão de execução (x) por outros."
			fi
			[ -x $tirar ]
			if [ $? -eq 0 ]; then
				chmod o-x $tirar
				echo "O arquivo $tirar perdeu a permissão de execução (x) por outros."
				ls -l |grep "$tirar" |awk '{print $1 $9}'
				((i--))
			fi
		fi

	done
}

copiarArquivo()
{
clear
i=0
while [ $i -eq 0 ]
do
	echo -e "\nDigite a pasta de origem do arquivo que deseja copiar:"
	read pastaOrigem
	[ -d $pastaOrigem ]
	if [ $? -eq 1 ]; then
		echo "Pasta inexistente."
	fi
	
	[ -d $pastaOrigem ]
	if [ $? -eq 0 ]; then
		ls -l $pastaOrigem
		
		ii=0
		while [ $ii -eq 0 ]
		do
			echo -e  "\nDigite o arquivo que deseja copiar: "
			read arquivo
			[ -e $pastaOrigem/$arquivo ]
			if [ $? -eq 1 ]; then
				echo "Arquivo inexistente."
			fi
		
			[ -e $pastaOrigem/$arquivo ]
			if [ $? -eq 0 ]; then
				iii=0
				while [ $iii -eq 0 ]
				do
					echo "Digite a pasta em que deseja copiar: "
					read pastaFinal
						[ -d $pastaFinal ]
						if [ $? -eq 1 ]; then
							echo "Pasta de destino inexistente."
						fi
						[ -d $pastaFinal ]
						if [ $? -eq 0 ]; then
							cp $pastaOrigem/$arquivo $pastaFinal
							echo "O arquivo $arquivo foi copiado com sucesso de $pastaOrigem para $pastaFinal."
							ls -l $pastaFinal |grep "$arquivo"
							sleep 2
							((i++))
							((ii++))
							((iii++))
						fi
				done
			fi
		done
	fi
done
}

trocarNome()
{
	clear
	ls -l
	i=0
	while [ $i -eq 0 ]
	do
		echo -e "\nDigite qual arquivo deseja renomear:"
		read arquivo

		[ -e $arquivo ]
		if [ $? -eq 1 ]; then
			echo -e "\nArquivo inexistente."
		fi
		
		[ -e $arquivo ]
		if [ $? -eq 0 ]; then
			ii=0
			while [ $ii -eq 0 ]
			do
				echo -e "\nDigite o nome que deseja dar:"
				read nomeTrocado
					[ -e $nomeTrocado ]
					if [ $? -eq 0 ]; then
						echo "Nome já existente."
					fi
				
					[ -e $nomeTrocado ]
					if [ $? -eq 1 ]; then
						mv $arquivo $nomeTrocado
						echo "Nome trocado com sucesso."
						ls -l
						sleep 2
						((i++))
						((ii++))
					fi
			done
		fi
	done
}

criarUsuario()
{
	clear
	i=0
	while [ $i -eq 0 ]
	do
  	 	echo -e "\nDigite o nome da conta de usuário que deseja criar:"
  		read usuario
  		
  		if [  "$(cat /etc/passwd |grep -i $usuario| wc -l)" = "1" ]; then
			echo "Nome de usuário já cadastrado."
			sleep 2
		fi
		
		if [  "$(cat /etc/passwd |grep -i $usuario| wc -l)" = "0" ]; then
  			sudo adduser $usuario
  			echo "Usuário criado com sucesso."
  			echo "Todos os usuários atualmente existentes:"
			cat /etc/passwd |awk -F ":" '/home/ {print $1}'
	  		sleep 2
			((i++))
		fi
	done
}

listarArquivos()
{
	clear
	ls -l 
	i=0
	while [ $i -eq 0 ]
	do
		echo -e "\nDigite a pasta que deseja listar os arquivos (insira o caminho completo):" 
		read listarPasta
		
		[ -d $listarPasta ]
		if [ $? -eq 1 ]; then
			echo -e "\nPasta inexistente."
		fi
		
		[ -d $listarPasta ]
		if [ $? -eq 0 ]; then
			ls -la $listarPasta
			sleep 3
			((i++))
		fi
	done
}

moverArquivo()
{
	clear
	ls -l 
	i=0
	while [ $i -eq 0 ]
	do
		echo -e "\nDigite qual arquivo deseja mover:"
	        read mover
	        [ -e $mover ]
	        if [ $? -eq 1 ]; then
	        	echo "Arquivo inexistente."
	        fi
	        
		[ -e $mover ]
		if [ $? -eq 0 ]; then
			ii=0
			while [ $ii -eq 0 ]
			do
		      	  echo "Digite a pasta em que deseja mover tal arquivo (entre com o caminho inteiro):"
		      	  read localPasta
		        
		      	  	[ -d $localPasta ]
				if [ $? -eq 1 ]; then
		        		echo "Pasta inexistente."
		 	 	fi
		        
		       		 [ -d $localPasta ]
		        	if [ $? -eq 0 ]; then 
		        		sudo mv $mover $localPasta
		        		echo "O arquivo $mover foi movido com sucesso para $localPasta."
		        		((i++))
		        		((ii++))
		      		  fi
		      done
		fi
 	done
}

darPermissaoGrupo()
{
	clear
	ls -l 
	i=0
	while [ $i -eq 0 ]
	do
		echo -e "\nDigite o arquivo deseja dar permissão de R.W.:"
	        read dar
	        
	        [ -e $dar ]
	        if [ $? -eq 1 ]; then
	        	echo "Arquivo inexistente."
	        fi
	        
	        [ -e $dar ]
	        if [ $? -eq 0 ]; then
	        	[ -r $dar ]
	        	if [ $? -eq 0 ]; then
	        		echo "O arquivo já apresenta permissão de leitura (R)."
	        	fi
	        	[ -r $dar ]
	        	if [ $? -eq 1 ]; then
	        		chmod +r $dar
	        		echo "O arquivo ganhou permissão de leitura (R)."
	        	fi
			[ -w $dar ]
	        	if [ $? -eq 0 ]; then
	        		echo "O arquivo já apresenta permissão de escrita (W)."
	        	fi
	        	[ -w $dar ]
	        	if [ $? -eq 1 ]; then
	        		chmod +w $dar
	        		echo "O arquivo ganhou permissão de escrita (W)."
	        	ls -l |grep "$dar" |awk '{print $1 $9}'
		      	sleep 2
		      	((i++))
	        	fi
			
		fi
	done
}

mudarSenhaUsuario()
{
	clear
	echo "Todos os Usuários encontram-se abaixo:"
	cat /etc/passwd |awk -F ":" '/home/ {print $1}'

	i=0
	while [ $i -eq 0 ]
	do
	echo -e "\nDigite o nome do usuário que deseja alterar a senha:"
	read usuario
		if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "0" ]; then
			echo "Usuário inexistente."
		fi
		
		if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "1" ]; then		
  			ii=1
  			while [ $ii -eq 1 ]
  			do
  				echo "Digite uma senha:"
				read -s senha
				comprimento=$(expr length $senha)
  					if [ $comprimento -lt 5 ]; then
						echo "A senha digitada tem menos que 5 caracteres."
					else
						echo "A senha digitada tem 5 ou mais  caracteres, portanto é adequada."
						sudo passwd $usuario
						((ii--))
						((i++))
					fi
			done
		fi
	done
}

deletarUsuario()
{
	clear
	echo "Todos os Usuários encontram-se abaixo:"
	cat /etc/passwd |awk -F ":" '/home/ {print $1}'

	i=0
	while [ $i -eq 0 ]
	do
		echo -e "\nDigite o nome do usuário que deseja deletar:"
	        read usuario
	        
	        if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "0" ]; then
			echo "Usuário não existente ou já foi deletado anteriormente."
		fi

		if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "1" ]; then
			sudo userdel -f $usuario
			echo "Usuário deletado com sucesso."
			echo "Todos os usuários atualmente existentes:"
  			cat /etc/passwd |awk -F ":" '/home/ {print $1}'
			sleep 2
			((i++))	
		fi
	done
}

criarGrupo()
{
	clear
	i=0
	while [ $i -eq 0 ]
	do 
		echo "Digite o nome do grupo que deseja criar:"
		read grupo
		if [  "$(cat /etc/group| grep -i $grupo| wc -l)" = "1" ]; then
			echo "Já há um grupo com este nome."
		fi
		
		if [  "$(cat /etc/group| grep -i $grupo| wc -l)" = "0" ]; then
			sudo groupadd $grupo
			echo "Grupo criado com sucesso."
			echo "Abaixo podem ser vistas suas informações:"
			cat /etc/group| grep -i "$grupo"
			sleep 2
			((i++))
		fi
	done 
}

deletarGrupo()
{	clear
	echo "Todos os Grupos encontram-se abaixo:"
	cat /etc/group |awk -F ":" '{print $1}' |tail 
	i=0
	
	while [ $i -eq 0 ]
	do
		echo "Digite o nome do grupo que deseja deletar:"
		read deletarGrupo
		
		if [  "$(cat /etc/group| grep -i $deletarGrupo| wc -l)" = "0" ]; then
			echo "Grupo não existente ou já foi deletado anteriormente."
		fi

		if [  "$(cat /etc/group| grep -i $deletarGrupo| wc -l)" = "1" ]; then
			sudo groupdel $deletarGrupo
			echo "Grupo deletado com sucesso."
			cat /etc/group |awk -F ":" '{print $1}' |tail 
			sleep 2
			((i++))
		fi
	done
}

addUsuarioGrupo()
{
	clear
	i=0
	while [ $i -eq 0 ]
	do
		echo "Todos os Usuários encontram-se abaixo:"
		cat /etc/passwd |awk -F ":" '/home/ {print $1}'
		echo -e "\n Digite o nome do USUÁRIO que deseja adicionar ao grupo:"
		read nomeUsuario
		
		if [  "$(cat /etc/passwd| grep -i $nomeUsuario| wc -l)" = "0" ]; then
			echo "Usuário não existente."
			sleep 1
		fi
		if [  "$(cat /etc/passwd| grep -i $nomeUsuario| wc -l)" = "1" ]; then
			echo "Todos os Grupos encontram-se abaixo:"
			cat /etc/group |awk -F ":" '{print $1}' |tail
			
			ii=0
			while [ $ii -eq 0 ]
			do
				echo -e "\nDigite o nome do GRUPO que deseja alocar o usuário:"
				read grupo
			
					if [  "$(cat /etc/group| grep -i $grupo| wc -l)" = "0" ]; then
						echo "Grupo não existente."
					fi
					if [  "$(cat /etc/group| grep -i $grupo| wc -l)" = "1" ]; then
						sudo adduser $nomeUsuario $grupo
						echo `groups $nomeUsuario`
						sleep 2
						((ii++))
						((i++))
					fi
			done
		fi
	done
}

listarGruposUsuario()
{
	clear
	i=0
	while [ $i -eq 0 ]
	do
		echo -e "\nTodos os Usuários encontram-se abaixo:"
		cat /etc/passwd |awk -F ":" '/home/ {print $1}'
		echo -e "\n Digite o nome do USUÁRIO que deseja verificar os grupos que pertence:"
		read nomeUsuario
		
		if [  "$(cat /etc/passwd| grep -i $nomeUsuario| wc -l)" = "0" ]; then
			echo "Usuário não existente."
			sleep 1
		fi
		if [  "$(cat /etc/passwd| grep -i $nomeUsuario| wc -l)" = "1" ]; then
			echo `groups $nomeUsuario`
			sleep 2
			((i++))
		fi
	done
}

removerUsuarioGrupo()
{
	clear
	i=0
	while [ $i -eq 0 ]
	do
		echo "Todos os Usuários encontram-se abaixo:"
		cat /etc/passwd |awk -F ":" '/home/ {print $1}'
		echo -e "\n Digite o nome do USUÁRIO que deseja remover do grupo:"
		read nomeUsuario
		
		if [  "$(cat /etc/passwd| grep -i $nomeUsuario| wc -l)" = "0" ]; then
			echo "Usuário não existente."
			sleep 1
		fi
		if [  "$(cat /etc/passwd| grep -i $nomeUsuario| wc -l)" = "1" ]; then
			echo "Todos os Grupos que $nomeUsario faz parte encontram-se abaixo:"
			echo `groups $nomeUsuario`
			
			ii=0
			while [ $ii -eq 0 ]
			do
				echo -e "\nDigite o nome do GRUPO que deseja remover o usuário:"
				read grupo
			
					if [  "$(cat /etc/group| grep -i $grupo| wc -l)" = "0" ]; then
						echo "Grupo não existente."
					fi
					if [  "$(cat /etc/group| grep -i $grupo| wc -l)" = "1" ]; then
						sudo gpasswd -d $nomeUsuario $grupo
						echo `groups $nomeUsuario`
						sleep 2
						((ii++))
						((i++))
					fi
			done
		fi
	done
}

mudarDono()
{
	clear
	i=0
	while [ $i -eq 0 ]
	do
		ls -l 
		echo -e "\nDigite o arquivo que deseja alterar o proprietário:"
		read arquivo
		
		[ -e $arquivo ]
		if [ $? -eq 1 ]; then
			echo "Arquivo inexistente."
		fi
		[ -e $arquivo ] 
		if [ $? -eq 0 ]; then
			ii=0
			while [ $ii -eq 0 ]
			do
				echo "Todos os Usuários encontram-se abaixo:"
				cat /etc/passwd |awk -F ":" '/home/ {print $1}'
				echo -e "\nEntre com o usuário que deseja passar:"
				read usuario
				if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "0" ]; then
					echo "Usuário não existente."
					sleep 1
				fi
				if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "1" ]; then
					chown $usuario $arquivo
					ls -l |grep -i "$arquivo"
					sleep 2
				((ii++))
				((i++))
				fi
			done
		fi
	
	done
}

tornarAdministrador()
{
	clear
	i=0
	while [ $i -eq 0 ]
	do
		echo "Todos os Usuários encontram-se abaixo:"
		cat /etc/passwd |awk -F ":" '/home/ {print $1}'	
		echo -e "\nEntre com o usuário que deseja tornar administrador de grupo:"
		read usuario
		if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "0" ]; then
			echo "Usuário não existente."
			sleep 1
		fi
		if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "1" ]; then
			ii=0
			while [ $ii -eq 0 ]
			do
				cat /etc/group |awk -F ":" '{print $1}' |tail 
				echo "Entre com o grupo que deseja colocar o $usuario de administrador:"
				read grupo
					if [  "$(cat /etc/group| grep -i $grupo| wc -l)" = "0" ]; then
						echo "Grupo não existente."
					fi
					if [  "$(cat /etc/group| grep -i $grupo| wc -l)" = "1" ]; then
						sudo gpasswd -A $usuario $grupo
						echo `groups $usuario`
						sleep 2
						((ii++))
						((i++))
					fi
			done
		fi
	done
}

exibirIP()
{
	clear
	ip=$(ifconfig |grep "inet " |head -1|awk '{print $2}')
	echo "Exibir o ip da máquina:" $ip
	sleep 2
}

exibirDiscoLivre()
{
	clear
	echo "As informações sobre o espaço de disco livre na máquina atual:"
	df -h
	sleep 4
}

instalarSAMBA()
{
clear
	samba=$(which samba)
	if [ $samba != "/usr/sbin/samba" ]; then
		echo "SAMBA ainda não instalado."
		sudo apt install samba
		estado=$(systemctl status smbd |grep "Active:")
		echo -e "\nO estado do SAMBA atualmente no computador:" $estado
		sleep 6
	else
		echo "SAMBA já está instalado."
		estado=$(systemctl status smbd |grep "Active:")
		echo "O estado do SAMBA atualmente no computador:" $estado
		smbd -V
		sleep 5
	fi
}

compartilharArquivos()
{
clear
	instalarSAMBA

	echo -e "\nTodos os Usuários encontram-se abaixo:"
	cat /etc/passwd |awk -F ":" '/home/ {print $1}'
	echo -e "\nEscreva o nome do usuário que deseja compartilhar:"
	read usuario
	if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "0" ]; then
		echo "Usuário não existente."
		echo "Devemos criar o usuário."
		sleep 1
		sudo adduser $usuario
		echo "Usuário criado com sucesso."
	fi
		
	if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "1" ]; then
		echo "Usuário já existente. Será adicionado ao SAMBA."
		sudo smbpasswd -a $usuario
		sleep 1
	fi
		echo -e "\nEscreva o nome do compartilhamento:"
		read compartilhamento
		
		[ -d /home/$usuario/$compartilhamento ] 
		if [ $? -eq 1 ]; then 
			echo "Compartilhamento não existente. Será criado."
			sudo mkdir /home/$usuario/$compartilhamento
			sudo chown $usuario /home/$usuario/$compartilhamento
			sudo chmod 777 /home/$usuario/$compartilhamento
		fi		
		[ -d /home/$usuario/$compartilhamento ] 
		if [ $? -eq 0 ]; then
			echo "Compartilhamento existente."
			sudo chmod 777 /home/$usuario/$compartilhamento
		fi	
				echo "[ global ]" > global.principal
				echo " workgroup = Grupo de trabalho" >> global.principal
				echo "usershare allow guests = yes" >> global.principal
				echo "[ $compartilhamento ]" > $compartilhamento.comp
				echo "comment = Servidor de Arquivos de $compartilhamento." >> $compartilhamento.comp
				echo "path = /home/$usuario/$compartilhamento" >> $compartilhamento.comp
				echo "browseable = yes" >> $compartilhamento.comp
				echo "read only = no" >> $compartilhamento.comp
				echo "guest = ok" >> $compartilhamento.comp
			
				cat *.principal > smb.conf
				cat *.comp >> smb.conf	
				sudo chown $usuario /home/$usuario/$compartilhamento			
				sudo systemctl restart smbd
					
			sudo cp smb.conf /etc/samba
			sudo systemctl restart smbd
}

listarCompartilhamentosRemotos()
{
	clear
	echo "Entre com o IP do usuário:"
	read ip
	echo "Os compartilhamentos disponíveis no host são:"
	smbclient -L //$ip
}

apagarCompartilhamento()
{
clear
	echo "Entre com o IP do usuário:"
	read ip
	smbclient -L //10.147.0.178 
	sleep 2

	ii=0
	while [ $ii -eq 0 ]
	do
		echo -e "\nDigite o usuário:"
		read usuario
		if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "0" ]; then
		echo "Usuário não existente. Entre novamente."
		fi
		if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "1" ]; then
			echo "Usuário existente."
			((ii++))
		fi		
	done
	i=0
	while [ $i -eq 0 ]
	do
		echo "Digite a pasta que deseja apagar o compartilhamento:"
		read compartilhamento
	
		[ -d /home/$usuario/$compartilhamento ]
		if [ $? -eq 1 ]; then 
			echo "Pasta inexistente. Entre com a pasta correta."
		fi
		[ -d /home/$usuario/$compartilhamento ]
		if [ $? -eq 0 ]; then
			echo "Pasta existente."
			((i++))
		fi
	done	
	
	sudo rm /home/$usuario/*.comp
	sudo rm /home/$usuario/$compartilhamento
	echo "Compartilhamento apagado com sucesso."
	sleep 2
}

compartilhamentoIP()
{
clear
	instalarSAMBA

	echo -e "\nTodos os Usuários encontram-se abaixo:"
	cat /etc/passwd |awk -F ":" '/home/ {print $1}'
	echo -e "\nEscreva o nome do usuário que deseja compartilhar:"
	read usuario
	if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "0" ]; then
		echo "Usuário não existente."
		echo "Devemos criar o usuário."
		sleep 1
		sudo adduser $usuario
		echo "Usuário criado com sucesso."
	fi
		
	if [  "$(cat /etc/passwd| grep -i $usuario| wc -l)" = "1" ]; then
		echo "Usuário já existente. Será adicionado ao SAMBA."
		sudo smbpasswd -a $usuario
		sleep 1
	fi
		echo -e "\nEscreva o nome do compartilhamento:"
		read compartilhamento
		
		[ -d /home/$usuario/$compartilhamento ] 
		if [ $? -eq 1 ]; then 
			echo "Compartilhamento não existente. Será criado."
			sudo mkdir /home/$usuario/$compartilhamento
			sudo chown $usuario /home/$usuario/$compartilhamento
			sudo chmod 777 /home/$usuario/$compartilhamento
		fi		
		[ -d /home/$usuario/$compartilhamento ] 
		if [ $? -eq 0 ]; then
			echo "Compartilhamento existente."
			sudo chmod 777 /home/$usuario/$compartilhamento
		fi	
				echo "[ global ]" > global.principal
				echo " workgroup = Grupo de trabalho" >> global.principal
				echo "usershare allow guests = yes" >> global.principal
				echo -e "\n  " >> global.principal
				echo "[ $compartilhamento ]" > $compartilhamento.comp
				echo "comment = Servidor de Arquivos de $compartilhamento." >> $compartilhamento.comp
				echo "path = /home/$usuario/$compartilhamento" >> $compartilhamento.comp
				echo "browseable = yes" >> $compartilhamento.comp
				echo "read only = no" >> $compartilhamento.comp
				echo "guest = ok" >> $compartilhamento.comp
			
				cat *.principal > smb.conf
				cat *.comp >> smb.conf	
				sudo chown $usuario /home/$usuario/$compartilhamento			
				sudo systemctl restart smbd
					
			sudo cp smb.conf /etc/samba
			sudo systemctl restart smbd
	ii=0
	while [ $ii -eq 0 ]
	do
		echo -e "\nInsira o IP (seguindo o modelo: xxxx.xxxx.xxxx.xxxx):"
		read ip
		comp=$(expr length $ip)
		if [ $comp -gt 19 -o $comp -lt  7 ]; then
		echo "Verifique o IP."
	else
		echo "Iniciar a conexão."
		smbclient -U=$usuario //$ip/$compartilhamento
		sleep 5
		((ii++))
	fi
	done
}

listarCompartilhamentosAtivos()
{
clear
	echo "Entre com o IP do usuário:"
	read ip
	echo "Os compartilhamentos disponíveis são:"
	sudo smbclient -L //$ip
}


#Corpo principal:
contador=0
while [ $contador -eq 0 ]
do
	menu
	echo -e "\nEscolha uma das opções do menu:"
	read opcao
	
	if ((opcao==1))
	then
		contarArquivos
	fi
	
	if ((opcao==2))
	then
		darPermissaoExecutavel
	fi
	
	if ((opcao==3))
	then
		tirarPermissaoOutros
	fi
	
	if ((opcao==4))
	then
		copiarArquivo
	fi
	
	if ((opcao==5))
	then
		trocarNome
	fi
	
	if ((opcao==6))
	then
		criarUsuario
	fi
	
	if ((opcao==7))
	then
		listarArquivos
	fi
	
	if ((opcao==8))
	then
		moverArquivo
	fi
	
	if ((opcao==9))
	then
		darPermissaoGrupo
	fi
	
	if ((opcao==10))
	then
		mudarSenhaUsuario
	fi
	
	if ((opcao==11))
	then
		deletarUsuario
	fi
	
	if ((opcao==12))
	then
		criarGrupo
	fi
	
	if ((opcao==13))
	then
		deletarGrupo
	fi
	
	if ((opcao==14))
	then
		addUsuarioGrupo
	fi
	
	if ((opcao==15))
	then
		listarGruposUsuario
	fi
	
	if ((opcao==16))
	then
		removerUsuarioGrupo
	fi
	
	if ((opcao==17))
	then
		mudarDono
	fi
	
	if ((opcao==18))
	then
		tornarAdministrador
	fi
	
	if ((opcao==19))
	then
		exibirIP
	fi
	
	if ((opcao==20))
	then
		exibirDiscoLivre
	fi
	
	if ((opcao==21))
	then
		instalarSAMBA
	fi
	
	if ((opcao==22))
	then
		compartilharArquivos
	fi
	
	if((opcao==23))
	then
		listarCompartilhamentosRemotos
	fi
	
	if((opcao==24))
	then
		apagarCompartilhamento
	fi
	
	if ((opcao==25))
	then
		compartilhamentoIP
	fi
	
	if ((opcao==26))
	then
		listarCompartilhamentosAtivos
	fi
	
	if ((opcao==0))
        then
                echo "Saindo do menu de controle."
                sleep 2
                ((contador++))
        fi
done
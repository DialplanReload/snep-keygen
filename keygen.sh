#!/bin/bash
#
# keygen.sh - Programa feito para criar senhas aleatorias para ramais do Snep
#
# Autor: Anderson Freitas <tmsi.freitas@gmail.com>
# Site: http://www.dialplanreload.com/
# Repositorio: https://github.com/DialplanReload/snep-keygen
#
# Desenvolvido sob licensa GPL. 
# Fique a vontade para contribuir com a evolucao deste programa.
#
#-----------------------------------------------------------------------------------------------
#
# OPCOES DE EXECUCAO - NAO ALTERE!!
#
#
# Execucao simples - ./keygen.sh e execucao com -h

# Importar ferramentas
source variables.sh

# Importar configuracoes
source info.conf

  if [ "$1" == "-h" ] ; then
    echo ""
    echo "Basta executar o scrip para poder acessar as opcoes."
    echo "As configuracoes estao dentro do arquivo info.conf. Altere se necesario!"
    echo "Dentro do info.conf vc pode inclusive alterar a quantidade de caracteres da senha. Padrao = 10"
    echo ""
  fi

  if [ "$1" == "" ] ; then

                echo ""
                echo "Informe quais ramais vc quer alterar"
                echo "Somente alguns (ex: 8010,8020) - Digite: intervalo"
                echo "Ou se quiser informar um range, tbm pode. Para alterar um range, digite: range"
                echo ""

                read peer
                                if [ "$peer" == "range" ] ; then

                                          echo ""
                                          echo "Informe o prefixo dos ramais, com dois digitos"
                                          echo "Exemplo, o range vai de 8000 até 8010"
                                          echo "Prefixo é equivalente a 80"
                                          echo ""

                                          read prefix

                                          echo ""
                                          echo "OK, agora me diga o primeiro ramal do range"
                                          echo "Exemplo, o range vai de 8000 até 8010"
                                          echo "Primeiro ramal é equivalente a 00"
                                          echo ""

                                          read st_peer

                                          echo ""
                                          echo "Perfeito! Insira agora, o ultimo ramal do range"
                                          echo "Exemplo, o range vai de 8000 até 8010"
                                          echo "Ultimo ramal é equivalente a 10"
                                          echo ""

                                          read last_peer

# Montar range

                                          peers_range=$(eval "echo $prefix{"$st_peer".."$last_peer"}")

                                          echo $peers_range | $path_xargs -n1 > peers.tmp

# Montar senhas

                                          genpass=$(
                                                              for generate in `cat peers.tmp`; 
                                                              do echo "UPDATE peers SET secret='$($path_head /dev/urandom | 
                                                              $path_tr -cd A-Za-z0-9 | 
                                                              $path_head -c $tamanho)' WHERE name='$generate';|";
                                                              done
                                          )

                                          echo $genpass | tr '|' '\n' > peers_passwd.sql
                                          echo ""
                                          echo "Qual a versao do Seu Snep?"
                                          echo "Digite 3 para as versoes 3.X"
                                          echo "Digite 1 para as versoes 1.X"
                                          echo ""

                                          read version

                                              if [ "$version" == "3"] ; then 
                                                     $path_mysql -u$db_user -p$db_pass snep < peers_passwd.sql -v
                                              fi

                                              if [ "$version" == "1"] ; then
                                                     $path_mysql -u$db_user -p$db_pass snep25 < peers_passwd.sql -v
                                              fi

                                          echo -en "Feito!!"
                                          echo "Agora, so entrar no Menu Cadastro de ramais e editar um ramal qualquer"
                                          echo "e salva-lo, para que o Snep valide as configuracoes"
                                          echo ""
                                          $path_rm peers.tmp
        fi 

                               if [ "$peer" == "intervalo" ] ; then

                                          echo ""
                                          echo "Informe os ramais separados por virgula"
                                          echo "Exemplo: 8020,8030,8040"
                                          echo ""

                                          read prefix

                                          echo $prefix > int_peers.tmp

                                          $path_cat int_peers.tmp | $path_tr ',' '\n' > int_peers_ok.tmp

                                          genpass_int=$(
                                                              for generate_int in `cat int_peers_ok.tmp`; 
                                                              do echo "UPDATE peers SET secret='$($path_head /dev/urandom | 
                                                              $path_tr -cd A-Za-z0-9 | 
                                                              $path_head -c $tamanho)' WHERE name='$generate_int';|";
                                                              done
                                          )

                                          echo $genpass_int | tr '|' '\n' > peers_passwd.sql
                                          echo ""
                                          echo "Qual a versao do Seu Snep?"
                                          echo "Digite 3 para as versoes 3.X"
                                          echo "Digite 1 para as versoes 1.X"
                                          echo ""

                                          read version
                                              
                                              if [ "$version" == "3"] ; then
                                                     $path_mysql -u$db_user -p$db_pass snep < peers_passwd.sql -v
                                              fi

                                              if [ "$version" == "1"] ; then
                                                     $path_mysql -u$db_user -p$db_pass snep25 < peers_passwd.sql -v
                                              fi

                                          echo -en "Feito!!"
                                          echo "Agora, so entrar no Menu Cadastro de ramais e editar um ramal qualquer"
                                          echo "e salva-lo, para que o Snep valide as configuracoes"
                                          echo ""

                                          $path_rm int_peers.tmp int_peers_ok.tmp
                               fi

  fi

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

date=$(date +%d%h%Y_%H%M%S_%N)
path_mk=$(which mkdir)
path_rm=$(which rm)
path_ls=$(which ls)
path_tar=$(which tar)
path_mdump=$(which mysqldump)
path_mysql=$(which mysql)
path_egrep=$(which egrep)
path_awk=$(which awk)
path_head=$(which head)
path_tr=$(which tr)
path_sed=$(which sed)
path_mv=$(which mv)
path_xargs=$(which xargs)
path_pwd=$(which pwd)
path_cat=$(which cat)

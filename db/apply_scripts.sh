#!/bin/bash
server=OMSIT\\SQLEXPRESS
user=sa
pwd=Pi31415926
sqlcmd_file=sqlcmd
databese=kerong

if [ -f /opt/mssql-tools/bin/sqlcmd ]; then
    server=localhost
    sqlcmd_file=/opt/mssql-tools/bin/sqlcmd
fi

echo "Interpreter: [$sqlcmd_file]"
echo "Server: [$server]"

scripts_base="$(find ./ -maxdepth 1 -type f -iname 'kerong_db_create.sql' | sort -t 't' -g -k 3)"
scripts_struct="$(find ./struct -type f -iname '*.sql' | sort -t 't' -g -k 3)"
scripts_updates="$(find ./updates -type f -iname '0*.sql' | sort -t 't' -g -k 3)"
scripts_fixtures="$(find ./fixtures -type f -iname '*.sql' | sort -t 't' -g -k 3)"

scripts_list="$scripts_base $scripts_struct $scripts_updates $scripts_fixtures"

for sql_script in $scripts_list; do
    echo ""
    echo "Execute: [$sql_script]"
    $sqlcmd_file -S $server -U $user -P $pwd -d $databese -f 65001 -i $sql_script

done

read -s -n 1 -p "Press any key to continue . . ."

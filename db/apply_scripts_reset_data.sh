#!/bin/bash
server=127.0.0.1
user=sa
pwd=Pi31415926
sqlcmd_file=sqlcmd
databese=san_administration

if [ -f /opt/mssql-tools/bin/sqlcmd ]; then
    server=localhost
    sqlcmd_file=/opt/mssql-tools/bin/sqlcmd
fi

echo "Interpreter: [$sqlcmd_file]"
echo "Server: [$server]"

scripts_base="$(find ./ -maxdepth 1 -type f -iname 'kerong_db_drop_data.sql' | sort -t 't' -g -k 3)"
scripts_data="$(find ./data -type f -iname '*.sql' | sort -t 't' -g -k 3)"
scripts_fixtures="$(find ./fixtures -type f -iname '*.sql' | sort -t 't' -g -k 3)"

scripts_list="$scripts_base $scripts_struct $scripts_updates $scripts_data $scripts_fixtures"

for sql_script in $scripts_list; do
    echo ""
    echo "Execute: [$sql_script]"
    $sqlcmd_file -S $server -U $user -P $pwd -d $databese -f 65001 -i $sql_script

done

read -s -n 1 -p "Press any key to continue . . ."

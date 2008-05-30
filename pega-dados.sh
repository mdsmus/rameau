file=anppom/ambitos.txt
#file=/tmp/ambitos.txt

function notas {
    echo notas graves
    low=$(grep $1 $file | sort -k 7 | head -1 | awk '{print $7}')
    hi=$(grep $1 $file | sort -k 10 | tail -1 | awk '{print $10}')
    echo $low: $(grep $1 $file | sort -k 7 | grep " $low " | awk '{print $6}' | sort | uniq | tr "\n" " ")
    echo
    echo notas agudas
    echo $hi: $(grep $1 $file | sort -k 10 | grep " $hi" | awk '{print $9}' | sort | uniq | tr "\n" " ")
}

function corais_graves {
    low=$(grep $1 $file | sort -k 7 | head -1 | awk '{print $7}')
    echo graves
    grep $1 $file | sort -k 7 | grep "$2  $low"
    echo
}

function corais_agudos {
    hi=$(grep $1 $file | sort -k 10 | tail -1 | awk '{print $10}')
    echo agudos
    grep $1 $file | sort -k 10 | grep "$2  $hi"
    echo 
    #grep $1 $file | sort -k 10 
}

#./rameau ambito -f music/chorales-bach/*.ly -a es-net -v > anppom/ambitos.txt

#notas soprano
corais_graves soprano c
corais_agudos soprano a

#notas alto
corais_graves alto f
corais_agudos alto d

#notas tenor
corais_graves tenor c
corais_agudos tenor a

#notas baixo
corais_graves baixo c
corais_agudos baixo e
for zipfile in *
do
    base=$(basename "${zipfile}")
    name="${base%.*}"
    ext="${base##*.}"

    if [[ "${ext}" == "zip" ]]
        then
        if [[ ! -d "$name" ]]
            then
            echo -e "Creating directory ${name}"
            mkdir $name
            echo -e "Extracting files from ${name} to ${name}."
            unzip $zipfile -d $name
        else
            echo -e "${zipfile} has already been extracted."
        fi
    fi
done
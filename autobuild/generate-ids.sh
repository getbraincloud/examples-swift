while getopts p:s:a:k: flag
do
    case "${flag}" in
	p) plistfile=${OPTARG};;
        s) serverurl=${OPTARG};;
        a) appid=${OPTARG};;
        k) secretkey=${OPTARG};;
    esac
done


if [ "${plistfile}" == "" ]; then
  echo "Must set arg -p path/to/plistfile."
  exit 1
fi

plutil -replace BCAppId -string "${appid}" "${plistfile}"
plutil -replace BCSecretKey -string "$secretkey}" "${plistfile}"
plutil -replace BCServerUrl -string "${serverurl}" "${plistfile}"

echo "-- Updated $plistfile"
plutil -p "${plistfile}"

git update-index --skip-worktree "${plistfile}"
echo "-- File excluded from git worktree"


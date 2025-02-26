CONFS="$HOME/git/desksetup
$HOME/.config/nvim/
$HOME/.i3/"

for CONF_DIR in ${CONFS}
do
  echo "I: updating ${CONF_DIR}"
  git -C ${CONF_DIR} pull 
done


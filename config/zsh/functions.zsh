function ns {
  touch $1 && chmod u+x $1 && $EDITOR $1
}

function ex {
  x > /dev/null $1 
}


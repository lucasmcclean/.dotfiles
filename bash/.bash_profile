if [ -f ~/.profile ]; then
  source ~/.profile
fi

if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

if [[ $OSTYPE == 'darwin'* ]]; then
  export PATH=${HOME}/brew/bin:${PATH}
  export BASH_SILENCE_DEPRECATION_WARNING=1
fi

if [ -f ~/.profile ]; then
  source ~/.profile
fi

if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

export BASH_SILENCE_DEPRECATION_WARNING=1

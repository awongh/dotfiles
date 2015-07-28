export MAGICK_HOME="/usr/bin/ImageMagick-6.8.5"

export PATH="$MAGICK_HOME/bin:$PATH"

export DYLD_LIBRARY_PATH="$MAGICK_HOME/lib/"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

export PATH="$PATH:/usr/local/bin/aws"

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/akira/.gvm/bin/gvm-init.sh" ]] && source "/Users/akira/.gvm/bin/gvm-init.sh"

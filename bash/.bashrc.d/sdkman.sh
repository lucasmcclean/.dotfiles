if [ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]; then
    export SDKMAN_DIR="$HOME/.sdkman"

    . "$SDKMAN_DIR/bin/sdkman-init.sh"

    if [ -d "$SDKMAN_DIR/candidates/java/21-tem" ]; then
        export JAVA_HOME="$SDKMAN_DIR/candidates/java/21-tem"
    fi
fi

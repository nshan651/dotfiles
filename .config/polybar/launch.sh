#!/usr/bin/env bash

dir="$HOME/.config/polybar"
themes=(`ls --hide="launch.sh" $dir`)

launch_bar() {
	# Terminate already running bar instances
	killall -q polybar

	# Wait until the processes have been shut down
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
    
	# Launch the bar
	polybar -q main -c "$dir/$style/config.ini" &	
    # Launch external bar
	polybar -q external -c "$dir/$style/config.ini" &	
    # Launch third bar
	polybar -q third -c "$dir/$style/config.ini" &	
}

# Add styling options here
if [[ "$1" == "--blocks" ]]; then
	style="blocks"
	launch_bar
elif [[ "$1" == "--simple" ]]; then
	style="simple"
	launch_bar

else
	cat <<- EOF
	Usage : launch.sh --theme
		
	Available Themes :
	--blocks    --colorblocks    --cuts      --docky
	--forest    --grayblocks     --hack      --material
	--shades    --shapes
	EOF
fi

#!/bin/sh
# Test runner for pybadges code

HIST_TREND=$(cat ~/Desktop/badges/hist_trend.txt)
LOGO=$(cat ~/Desktop/badges/logo.txt)
# Test center_image
#python __main__.py --left-text "workflows" --right-text "300" --center-color "#252525" --right-color "#9ed6f7" --left-color "#0996e8" --center-image $HIST_TREND > ~/Desktop/badges/hist_trend.svg 

# Test no image 
#python __main__.py --left-text "workflow runs" --right-text "300" --right-color "#9ed6f7" --left-color "#0996e8" > ~/Desktop/badges/hist_trend.svg 

# Broken unit test
python __main__.py --left-text "accuracy" --right-text "70%" --right-color "yellow" --logo "$LOGO" > ~/Desktop/badges/hist_trend.svg 

### Extra shit

#python __main__.py --left-text "workflows" --right-text "300" --center-color "#252525" --right-color "#9ed6f7" --left-color "#0996e8" --right-image $HIST_TREND > ~/Desktop/badges/hist_trend.svg 
#python __main__.py --left-text "workflow runs" --right-text "300" --center-color "#252525" --right-color "#9ed6f7" --left-color="#0996e8" > ~/Desktop/badges/hist_trend.svg 
#python __main__.py --left-text "workflow runs" --right-text "300" --right-color "#9ed6f7" --left-color="#0996e8" > ~/Desktop/badges/hist_trend.svg 

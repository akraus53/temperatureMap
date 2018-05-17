# My Quest of Finding some weird Point on Earth
I read online that there always has to be one point on earth, 
where the temperature and the air pressure is the same as on the opposite site of the globe (its called "antipod"). 

Have a look at [this](http://junq.info/?p=3126) for the whole explanation, why this point has to exist. I consider the explanation a mathematical proof and I completely believe it. 

In several discussions with friends that followed, I noticed I needed some way of showing what was going on and of course I wanted to find out where the mysterious point was (yeah, it moves, I know) - *so i decided I had to make a viualisation*, and I did. Here it is. Of course this is no proof, that there always has to be such a point, 
but hey, it's something. I am not planning on making a live version of this, because a complete set of points takes about an hour to fetch from the API and costs 1.80$. ~~In the near future I will increase the number of points from 18k to, say, 50k, but I'm not making promises.~~ I have since increased the database to 100.000 points.

## Explanation of the Visualisation
- Every point on the globe represents a API call at Tuesday night (May 15 2018) for the current temperature and air pressure at those coordinates
- Each point represents an area of about 70 times 70km (about 45 times 45 miles) 
- the color of the point represents the value, so the temperature (blue = cold, red = hot, or so extremely cold that HSB makes it red again), or if you switch the mode with the "P"-Button, the Presure (red = high, blue = low)
- very big spots have almost hte same temperature and air pressure as the antipod.

## So, what can *you* do?
Have a look at the hints at the bottom of the screen, you can
- Turn the globe with your finger or the mouse
- Disable the map, so you can look through the world ("M")
- Show the center of the World so you see, if the points on the other side line up ("L")
- Change the information to visualize
  - Temperature (HSB, "T")
  - Air Pressure (HSB, "P") 
  - A mix of both, where the temperature is the red value and the pressure the green value of a RGB color ("B") 
- Increase or decrease the sensitivity of calling temperatures the same ("J"/"K")
- Decide to show all points or only points with about the same temperature ("A"), this speeds op the rendering significally

Thanks to DarkSky for providing a source for the 18000-100.000 data points, which made this project possible.
If you're interested in the script I used to do the API calls, let me know.

# 2D-Raycaster
2D Raycaster: Processing 3.5.4: Java

I started this project back in June of 2021 and my friend was making his own too at the time, it was actually the last project I started before I took a break from coding. At the time I was really looking forward to it but I got busy with prepping for college and wanted to relax. I’m really glad I finished it!

The background/map was made using matrix iteration to project a map given the map’s scale for each node object (the bottom of the main class of code). The background can be easily changed and I just made different colors for fun, they don’t do anything lol that’s kinda the point.

The Raycasting was really cool and a bit more complicated as it involves trig. I originally was just going to make the player have a light all around them (bc I was lazy lol), but I decided it would be cooler if I made a flashlight thing that determines the way the player is facing using the x and y of the current and past frames and cast a beam of light out in front (see slide 5). 

Once I got the flashlight, I created a function that judged the distance the ray needed to go depending on if it hit an object or not. This was the most fun. Basically the function casts rays with increasing length out until it collides or hits the length (multiple of the size of a node) of the flashlight. If it collides, it then casts shorter rays until it no longer collides with a node, to which it returns the length of the ray. If it doesn’t hit anything it just keeps the flashlight length, which can be adjusted. It does this for all rays, and that’s it! 

This project wasn’t super complicated but it was a lot of fun to make, and I ran into some interesting bugs. I’ve been really liking the math driven ideas lately like with the collatz conjecture program (that I didn’t post here lol, I only post bigger cooler projects), but yeah this was a lot of fun I’m glad I’m coding again! Maybe one day I’ll do 3D Raycasting for fun lol
Lines of Code: ~350

Hours spent: ~10

Feel free to dm me any questions!

CONTROLS: 
V to reveal map
Mouse to control player
Epilepsy warning for if you find the goal

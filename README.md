# Traffic-Light-Controller
Design a traffic light controller for the intersection of street "A" and street "B". Each street has traffic sensors, which detect the presence of vehicles approaching or stopped at the intersection. 
𝑆𝑎=1 means a vehicle is approaching on street "A", and 
𝑆𝑏=1 means a vehicle is approaching on street "B".

Street "A" is a main street and has a green light until a car approaches on "B".
Then the lights change, and "B" has a green light.
At the end of 50 seconds, the lights change back unless there is a car on street "B" and none on "A", in which case the "B" cycle is extended for 10 additional seconds.
If cars continue to arrive on street "B" and no car appears on street "A", "B" continues to have a green light.
When "A" is green, it remains green at least 60 seconds, and then the lights change only when a car approaches on "B".
The controller has 6 outputs (𝐺𝑎,𝑌𝑎,𝑅𝑎) that drive the green, yellow, and red lights on street "A", and (𝐺𝑏,𝑌𝑏,𝑅𝑏) drive the corresponding lights on street "B".

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
![image](https://github.com/user-attachments/assets/0be4db7c-a245-4aa1-b7d3-1bf57c66f0b8)

 S0 = 3'b000;  // A = G, B = R 
 
 S1 = 3'b001;  // A = Y, B = R 
 
 S2 = 3'b010;  // A = R, B = R (Extra Safety)
 
 S3 = 3'b011;  // A = R, B = G
 
 S4 = 3'b100;  // A = R, B = Y   
 < p align = "center">
![image](https://github.com/user-attachments/assets/9cdc2f8f-ef80-4b0a-9c3b-e9e15948da17)

![image](https://github.com/user-attachments/assets/32490192-c541-4e9c-aaff-588f58ca13c3)

# GuessTheFlags
 Project 2 100DaysOfSwiftUI + Animation Challenge
![Screenshot 2023-07-24 at 01 42 49](https://github.com/Yannemal/GuessThe-Flags/assets/56878180/ef09c648-32e4-47e2-b4f4-0b5834e87128)

see the app in action: https://youtu.be/gSfD8pQ0vmE

This weekend project had me digging into previous projects' animation attempts and make it all come together in a massive update for the Guess the Flags project earlieer in the course.

It was good practice getting my head around layering using ZStacks within Zstacks

- I have an animating radialGradient with different colors and other settings each time
- I have reorganised my code to allow for more complicated flow of the game with more steps in between to allow for presentation like animated text for each round THEN show the flags
- succes or fail states of the game come with unique animations: changing the background / fade to black. appropriate emojis THEN the alert pop up with score and continue button
- THE ACTUAL CHALLENGE TO COMPLETE : twirling the flag chosen on the Y axis 

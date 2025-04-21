● What does the single responsibility principle consist of? What's its purpose?
The idea of SRP is that a class should have one purpose, one reason to change, and it's internal behavior should align to this. 
It's probably the most overlooked and underestimated SOLID principle. 
In this very challenge we can see for example plenty of ways that SRP can be broken, having the view handling business logic, having the view model handling networking or persistence, instead of having a repository or service, etc.

● What characteristics, in your opinion, does “good” code or clean code have?
Should follow the SOLID & GRASP principles.
Well defined and implemented architecture and programming guidelines (Lint, common design patterns).
You don't code for yourself, or the solution, you code for the next person who's gonna jump in and work in what you wrote.

● Detail how you would do everything that you have not completed.
I left plenty of TODO comments in the code marking everything that could be improved, since it's hard to polish everything in a short time line (I moved to a new house a couple of days ago so i had a pretty thin time to work on this challenge as i've wanted to)
The biggest ones i can think of now:
For persistence i did advance creating a swift data repository. I finished the behavior, i only had to connect it to the Detail View, and create a View model to communicate the view with the repo.
For the trailer player, i had to add a new request for the video endpoint in the service (fetchTrailer) to get the video key, add the dto and model, perform the fetch right after we fetch the details
From what i saw there's a few video services the trailer can come from, for an MVP i'd support Youtube app only, and add a deeplink when you press the play button to open the youtube app, otherwise, open the link in safari.




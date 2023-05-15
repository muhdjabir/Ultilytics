# Ultilytics-Orbital2022

Complete Documentation: https://docs.google.com/document/d/1vF7ZHm-PJaHFip4XTaZXBizEDc7PjvtzyzqgfEZQNrQ/edit?usp=sharing

Motivation
As athletes, it is natural for Ultimate players to desire to improve their game and excel in the sport that they pour tons of hours and effort into. However, to actually track their improvement, objectivity is an important aspect of fully realising your potential and providing solid and constructive direction as to which direction an individual should move toward.

Ultimate Frisbee in Singapore is still an underdeveloped sport, it currently lacks concerted efforts in helping players to track their progress and improvements whilst training. Individual stats keeping is an underutilised concept that would allow players to objectively determine what their strengths and weaknesses are.

Present statistics keeping applications available may be too generalized and not niche enough for ultimate whereby stats about the intricacies of an ultimate scrim are not effectively recorded. For example, how long the disc stays with a person before being passed off. Furthermore, this achieves the end goal of video analysis but in a quicker yet still effective manner as stats are recorded as the play happens and redundant information is sieved out.
Aim
Our goal for Ultilytics is to provide an accessible stat-tracking platform for players and coaches in Ultimate to add new data and review past game performances. This will help facilitate a deliberate effort in identifying a player and/or team’s strengths and weaknesses, allowing for a concerted training effort. Thus, we propose a free-to-use cross-mobile application where coaches and players can record stats from games in real-time.


How Are We Different From Existing Platforms?
UltiAnalytics (Android) / iUltimate (iOS)


Statto


User Stories
As a player who wants to know which parts of my game play is the weakest, I want to be able to efficiently find out my stats
As a player I want to know how many scores/turnovers I have contributed to the team (turnover is when you lose possession of the disc)
As a player I want to easily see my progress over the course of a period of time by keeping track of my stats throughout subsequent games/trainings
As a coach I want to be able to analyse which individuals need the most work and in which areas for more effective training regimes.
As a coach I want to have an overview of the stats mid game to see which players are underperforming or under-utilized, allowing me to make adjustments..
As a coach I want to be able to efficiently keep track of game stats to be easily reviewed for the teams strengths and weaknesses
As a player/coach I would like to be able to track and view the records of my previous games from any mobile device.

Tech Stack
Flutter (Frontend)
Firebase (Backend & Database)
Stores data as one large JSON tree
Dart (Programming Language)

Justification for Tech Stack
Flutter & Dart
Compared to other frameworks used to create cross-platform mobile applications such as React Native and Xamarin, Flutter requires only a single codebase to deploy both iOS and Android apps. Additionally, Flutter uses the programming language Dart which is an object-oriented language with syntax similar to that of C and Java. These are 2 of the few languages that our team is familiar with. Lastly, upon research, we have discovered that Flutter has been used to develop apps for multiple industrial leaders such as Google (Launched Flutter), Alibaba, Ebay and more.
Limitation
However, we do acknowledge that Flutter apps do cost more space due to its widget-based nature and also have less extensive resource libraries compared to other frameworks such as React Native and Xamarin.
Firebase (Firestore)
We decided to use Firebase as our backend as it officially supports the development of Flutter Apps. Furthermore, the fact that Firebase is hosted by Google means that there are clearer and more abundant documentation to help in the development of a Flutter app linked to a Firebase backend. Lastly, it is hosted with the goal of pushing rapid development of applications.
Limitation
Firebase is limited in its ability to upscale when our app increases in users. Migration of data to a different database and backend is impossible/non-trivial as all the data is hosted on Firebase. Moreover, Firebase is a costly option when data stored exceeds the free limit.
Scope of Project (Incomplete)
Features (Incomplete)
Features and Timeline
The iOS Mobile Application provides an interface for players to record stats and view the breakdown of a player’s performance. It interfaces with a database to store data of all the recorded players.

Features to be completed by the mid of June:

The iOS application has limited features, allowing for input of team and individual player statistics as well as basic counters for various individual statistics for storage in our database:
Timer(start/pause/stop)
Player names input
Score Tracker
Basic Offensive statistics counter for:
Individual:
Catches
Open Side Throws
Break side Throws
Turnovers
Drops
Throwaways
Scores
Assists
Possession Rate
Basic Defensive Statistics Counter for:
Individual:
Interceptions
Pulls


By mid of July:

The iOS application should be complete with team based statistical recording as well as more in-depth data analysis based on the basic individual statistics.
Offensive Statistical Analysis for:
Team:
Turnover Rate
Pass Completion Rate
Offensive Efficiency
Average Disc Time per individual possession
Defensive Statistical Analysis for:
Team:
Turnover Rate
Pass Completion Rate
Defensive Scoring Efficiency
Pull Efficiency
Sorting of players by aforementioned individual statistics
Sort individual statistics per point
Team Statistical Analysis from different scrimmages

Development Timeline (Incomplete)
Milestone
Task
Description
In-Charge
Date













Unified Modelling Language(UML) Diagrams
To provide a clearer visualisation of our mobile application, we have created 2 UML diagrams to portray our system design. The first diagram is an activity diagram used to portray our app behaviour while the second diagram is a widget tree used to portray our frontend app UI.

Activity Diagram


After registering, a user will be able to log in and will arrive at our home page. From this home page, users can choose to go to the games page where they have the option of creating a new game record.
They will then be routed to the Teams Page, where they can choose an existing team or create a new team of players. Afterwards, they will input the data of a list of players into their team. Upon confirmation, they will be routed to the Lines Page to choose the first 7 players playing.
Moving on, they will then be able to record the game play by play and take down the stats. At the end of each point, they will be rerouted back to the line page to choose the next 7 players.
At the end of the game, they can then edit key game information and will be led to a game summary page.

From the home page, users can also be routed to the View History page where they can choose to view individual game summaries or overall team stats.


Frontend Flutter Widget Tree


Backend Firestore JSON Tree Diagram (Incomplete)
Since we are utilizing Firebase as our Backend and Database in our tech stack, we will be using a JSON Tree Diagram to represent the structure of the keys and values in our database.
Proof-of-Concept
Project Log
Refer to attached spreadsheet
https://docs.google.com/spreadsheets/d/1nqymEBdmlQZEje_9yd4vORQsfiCwo-JPJLcv-deyQy8/edit?usp=sharing



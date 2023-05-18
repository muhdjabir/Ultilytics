# Ultilytics-Orbital2022

Complete Documentation: https://docs.google.com/document/d/1vF7ZHm-PJaHFip4XTaZXBizEDc7PjvtzyzqgfEZQNrQ/edit?usp=sharing

## Motivation
As athletes, it is natural for Ultimate players to desire to improve their game and excel in the sport that they pour tons of hours and effort into. However, to actually track their improvement, objectivity is an important aspect of fully realising your potential and providing solid and constructive direction as to which direction an individual should move toward.

Ultimate Frisbee in Singapore is still an underdeveloped sport, it currently lacks concerted efforts in helping players to track their progress and improvements whilst training. Individual stats keeping is an underutilised concept that would allow players to objectively determine what their strengths and weaknesses are.

Present statistics keeping applications available may be too generalized and not niche enough for ultimate whereby stats about the intricacies of an ultimate scrim are not effectively recorded. For example, how long the disc stays with a person before being passed off. Furthermore, this achieves the end goal of video analysis but in a quicker yet still effective manner as stats are recorded as the play happens and redundant information is sieved out.

## Aim
Our goal for Ultilytics is to provide an accessible stat-tracking platform for players and coaches in Ultimate to add new data and review past game performances. This will help facilitate a deliberate effort in identifying a player and/or team’s strengths and weaknesses, allowing for a concerted training effort. Thus, we propose a free-to-use cross-mobile application where coaches and players can record stats from games in real-time.

## User Stories
As a player who wants to know which parts of my game play is the weakest, I want to be able to efficiently find out my stats
As a player I want to know how many scores/turnovers I have contributed to the team (turnover is when you lose possession of the disc)
As a player I want to easily see my progress over the course of a period of time by keeping track of my stats throughout subsequent games/trainings
As a coach I want to be able to analyse which individuals need the most work and in which areas for more effective training regimes.
As a coach I want to have an overview of the stats mid game to see which players are underperforming or under-utilized, allowing me to make adjustments..
As a coach I want to be able to efficiently keep track of game stats to be easily reviewed for the teams strengths and weaknesses
As a player/coach I would like to be able to track and view the records of my previous games from any mobile device.

## Tech Stack
Flutter (Frontend)
Firebase (Backend & Database)
Stores data as one large JSON tree
Dart (Programming Language)

## Justification for Tech Stack
Flutter & Dart
Compared to other frameworks used to create cross-platform mobile applications such as React Native and Xamarin, Flutter requires only a single codebase to deploy both iOS and Android apps. Additionally, Flutter uses the programming language Dart which is an object-oriented language with syntax similar to that of C and Java. These are 2 of the few languages that our team is familiar with. Lastly, upon research, we have discovered that Flutter has been used to develop apps for multiple industrial leaders such as Google (Launched Flutter), Alibaba, Ebay and more.

Limitation
However, we do acknowledge that Flutter apps do cost more space due to its widget-based nature and also have less extensive resource libraries compared to other frameworks such as React Native and Xamarin.


Firebase (Firestore)
We decided to use Firebase as our backend as it officially supports the development of Flutter Apps. Furthermore, the fact that Firebase is hosted by Google means that there are clearer and more abundant documentation to help in the development of a Flutter app linked to a Firebase backend. Lastly, it is hosted with the goal of pushing rapid development of applications.
Limitation
Firebase is limited in its ability to upscale when our app increases in users. Migration of data to a different database and backend is impossible/non-trivial as all the data is hosted on Firebase. Moreover, Firebase is a costly option when data stored exceeds the free limit.

## Screens for Ultilytics
<h2 align="center"> User Authentication </h2>
<p align="center">
<img width="254" alt="Log In" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/5b5a60be-6457-4e20-9540-b3ea1e22b2c3"> 
<img width="254" alt="Registration Pop Ups" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/0d8c3fae-7c80-415f-8d57-628a001174fc">
</p>

<h2 align="center"> Game Creation </h2>
<p align="center">
  <img width="254" alt="Game creation" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/ad393e76-390d-48c8-81b3-cb2750ec2ace"> 
  <img width="254" alt="Game creation" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/9fe233a3-37d9-4381-ae36-38b8e05cc7c1"> 
</p>


<h2 align="center"> Line Selection </h2>
<p align="center">
  <img width="254" alt="Line selection" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/85e510a6-fb76-4502-859c-e0da51d3fdb1"> 
  <img width="254" alt="Line selection" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/b7863ee9-6c26-4a6c-9e2f-259bbca8435a"> 
</p>

<h2 align="center"> Team Creation </h2>
<p align="center">
<img width="254" alt="Team Creation" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/3baa0ad5-87c0-41a0-8e6f-4e2c405d35de"> 
</p>
  
<h2 align="center"> Player Creation </h2>
<p align="center">
<img width="254" alt="Team Creation" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/d51c01b2-e9f7-4342-b4fb-cdb59a88b447"> 
</p>
<h2 align="center"> Stat Tracking </h2>
<p align="center">
  <img width="254" alt="Line selection" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/7665c07a-51d9-4e49-badb-e20d17c081ba"> 
  <img width="254" alt="Line selection" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/6dc05bf1-16a6-4993-8032-4d007f882526"> 
</p>

<h2 align="center"> Game History </h2>
<p align="center">
  <img width="254" alt="Line selection" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/403f6443-6303-49bf-9fed-47372c6db25f"> 
  <img width="254" alt="Line selection" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/9e3a034f-f231-4cf5-b3b3-3f47e517fd79"> 
  <img width="254" alt="Line selection" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/840ddf2b-7b50-4f44-9a09-39dbfaf52de0"> 
</p>

<h2 align="center"> Team History </h2>
<p align="center">
  <img width="254" alt="Line selection" src="https://github.com/muhdjabir/Ultilytics/assets/99940885/b83dfa63-77f6-463d-8f37-adf503266c13"> 
</p>

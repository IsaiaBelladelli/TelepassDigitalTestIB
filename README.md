# TelepassDigitalTestIB

## Description

### General
This project aims to develop an app, for Telepass interview process, that shows a Pokémon list with its image and name.
When a user taps on a Pokémon, the app will show a view with Pokémon’s name, image, stats, and category (fire, smoke, etc).

<img src="images/screenshot_home.png" width="100" height="200">

<img src="images/screenshot_details.png" width="100" height="200">

### Technical 
For this project I used:

- Swift 5
- SwiftUI
- iOS 13 as Deployment Target (for SwiftUI purpose)
- Xcode 13
- **No external libraries or pods**
- [API link](https://pokeapi.co/)

### Architecture
I followed the MVVM architecture, dividing the project in:

#### Model
It contains the data struct of the API result.
#### APIManager
It contains the logic for data fetching by API request. It adopts ViewModel's protocols to be trasparent to it.
#### ViewModel
It contains the observable objects to be observed by views.
#### View
It contains the SwiftUI views.

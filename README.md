# TelepassDigitalTestIB

## General description

This project aims to develop an app, for Telepass interview process, that shows a Pokémon list with its image and name.
When a user taps on a Pokémon, the app will show a view with Pokémon’s name, image, stats, and category (fire, smoke, etc).

<img src="images/screenshot_home.png" width="100" height="200"> ---> <img src="images/screenshot_details.png" width="100" height="200">

## How to run

Download the project folder from GitHub, unzip it and open the project with Xcode.
Be sure to have an internet connection for API purpose.

## Technology

- **Swift 5**

- **SwiftUI**: Although the specifications required iOS dep target 11, I preferred to set it to iOS 13 so that I could use SwiftUI, a young cross-platform framework for building UI that soon or later will replace UIKit. 
But, to not overdo it, I decide to use the "oldest" target available for SwiftUI, even if it is recommended to use iOS 14+.
Moreover, I made this choice because the recruiter told me that in Telepass you are going to use SwiftUI for future projects.

- **Xcode 13**

- **No external libraries**: Althoug I have found convenient using CocoaPods in other projects, I followed the project's specifications using as few external libraries as possible.

- API suggested by the project's specs: [API link](https://pokeapi.co/)

## Architecture
As required, I followed the MVVM architecture, dividing the project in:

### Model
It contains the data struct of the API result and the single Pokemon.

### APIManager
It contains the logic for data fetching by API request. It adopts ViewModel's protocols to be trasparent to it.
I used URLSession for the API request. I could have used the pod Moya.

### ViewModel
It contains the observable objects to be observed by views. The main objects are:
- Pokedex: it contains the list of pokemon.
- ObservablePokemon: it contains the pokemon struct and published localized string.

### View
It contains the SwiftUI views. The main views are:
- Pokemon List View: it shows the list of pokemons in order of "id". It uses infinite scrolling.
- Pokemon Details View: it shows pokemon's stats and types.
Because of many properties are set asynchronously, for view state I used "@ObservedObject pattern". 

## Test
I implemented unit tests for async logic.

## Possible improvements
- Add search bar for pokemons list.
- Add the possibility to show the pokemons list ordered by name, id, type, etc.


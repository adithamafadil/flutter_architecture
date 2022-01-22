# flutter_architecture

An example Flutter project with Get management. Purposed as TDD clean architecture structure.

## Getting Started

To run this project, you have to:

1. Clone this project

```
git clone https://github.com/fadirru/flutter-architecture/
```

2. Get all packages using `flutter pub get` on your CLI
3. Run `flutter pub run build_runner build --delete-conflicting-outputs` to build all generated files
4. Run on your own devices

## Module Stuctue

<img src="https://miro.medium.com/max/1112/0*zUtZYiJ1bDTugOYY">

When you want to create new `feature`, you have to aware to all `modules`. In this project, the modules are:

1. Constants
   Contains every key constants you need so you don't have to use `String` hardcoded on your other modules.

2. Dependency Injection (DI)
   Modules that contains injection unit/service locator and modules that should be injectable at `modules` folder.

3. Data
   The data layer that contains all data flow cases you need. The structure will be:

   ```
   ├─ module_name 
   ├─── data 
   ├─────── dto 
   ├─────── mapper
   ├─────── repositories
   ├─── domain
   ├─────── entities
   ├─────── repositories 
   ├─────── usecases
   ```
   Data layer inside your module CANNOT be interacted with your view data/view. The only way you interact with them through domain layer
   
4. Feature
   Contains every feature that will shown at your view. Including:
   
   4.1. Navigation
   Wrapper for your navigation and the route name will be declared there.

   4.2. Screens
   The UI that will shown on user's device(s). Including its view and view model as controller.

   4.3. Utils
   Utilities to support your codes

   4.4. Widgets
   Shared widgets that will be used at different screens.

5. State
   The folder that contains state management configuration to support your app to route or classified the data flow.

## References:

1. https://medium.com/@fakhiradevina/flutter-tdd-clean-architecture-272373727699

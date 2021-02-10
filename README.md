# PokeApp

This app is composed of two pages, the first one is a list of Pokemon while the second displays the details of the selected Pokemon.

## Clean Architecture
The code is organized following the principles of the Clean Architecture with a separation between the layers of Data, Domain and Ui. This architecture provides several benefits like testable code and high maintainability.

### Dependency Injection
The dependencies for each class (except for the ViewController) are passed to the class with the init method. In this project I decided to do a manual injection and to provide defaults to the init methods. Thanks to the dependency injection it was possible to create tests for the classes in the project.

### Protocols
Each class requires that its dependencies conforms to a protocol, instead of requiring a specific class. This approach increase the maintenability of the code, because a refactor of a class that conforms to a protocol does not affect other classes if it still conforms to the procol after the refactor.


## External Libraries
In this project there are no external libraries. I could have used some libraries, like Alamofire for Network Request, PromiseKit for asyncronous programming or RxSwift/RxCocoa for reactive programming, but their usage is not necessary in this project due to its small dimensions.






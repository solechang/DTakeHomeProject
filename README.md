## Build tools & Version
Xcode 13.4.1
iOS 15.5
iPhone Only

## How to setup
- In DisneyTakeHomeProject's directory, open "DisneyTakeHomeProject.xcodeproj"
- **IMPORTANT** In NetworkingManager.swift, replace privateKey (line 18) to "4a44c3a5ee36c1dbb251ab9aad2fac544fa5bb9a". You will get an alert error if you do not set this up
- To run project: "Cmd + r"
- To test project: "Cmd + u"

## Covered within this take home:
- I've focused on abstraction to separate logic and for testability
- Time: 2 - 3 hours
- Covered within this take home:
    - Programmatic UI setup (no storyboard)
    - Unit Tests
        - Files to test:
            - ComicDetailsViewModelSuccessTests.swift
            - ComicDetailsSuccessUITests.swift
    - MVVM + Combine
    - UIKit
    - Error Handling
    - Bonus:
        - Autolayout
            - Handle both landscape and portrait modes
        - Dynamic Type: Font Accessibility (text sizes)
        - Dark & Light modes
        

NOTES:        
- In this take home project, I architected in MVVM because it is efficient to quickly set up unit testing. With dependency injection, I created networking mocks and stubs to test out a success scenario for fetching a comic. If I had more time, I would have done a failure scenario as well.
- In addition, I've utilized Combine because it works well with MVVM. Using Combine, we can subscribe and listen to events. For example, business logic will be within the ViewModel - when we fetch data within the ViewModel and we can listen to the data that have been retrieved and we can display those updates onto the view.
- There are no 3rd party libraries used or copied within this project.

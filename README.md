# Deezer

Demo app to use deezer api

Short description of my decisions:
- I've used Swift 5 as a main language
- Project is built on top of MVVM pattern with binding between ViewModel and ViewController
- I've choose simplified Coordinator pattern for app navigation with coordinator for every module and callbacks on blocks
- API is designed on top of URLSession with help of Generics, Request has Response as associatedtype
- All models is Codable
- UnitTests includes test of some logic, API tests and tests of ViewModels and Coordinators 

What could be done better?
- UI/UX experience with searchBar appearance 
- Configuration of StretchyTableHeaderView
- TableViews UI/UX experience

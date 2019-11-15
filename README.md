<h1 align="Center">
  <br>
  <a href="https://github.com/gayuru/Travo"><img src="https://i.ibb.co/B2hrVVY/Logo.png" alt="Travo" width="50"></a> Travo 
</h1>
<p align="Center">Your companion that will not make you feel lost when you go to a new city</p>

## What is Travo? ##
🤔Travo is your one stop travel companion when you visit a new place and feel lost just open our app and look for popular places nearby along with recommended places by user ratings. Travo utilizes Foursquare API to provide the user with a large collection of places near them alongside providing weather information using OpenWeather about the place they are going to visit.

## When to use it ##
💡When visiting a new city, you will not feel lost as you can use the app to explore new locations in the city and view popular places near you. Or you can press the “Feeling lucky” button which will show a random location which is popular near you.

## Getting Started ##
Starting off with Travo is easy as it can get but surely you do need some credentials to access the foursquare api and don't worry about it as I will guide you through the process.
  1. Download or Clone the Travo repo from above.
  2. After you've downloaded it make sure you open the **Travo-App.xcworkspace** file as it's incooperated with pods.
  3. Since you are done with the initial process now we have to get a **clientID** & **clientSecret** from [FourSquare](https://developer.foursquare.com/places) inorder to get access to their api which is being used.
  4. Proceed to create an account with them and then create a new App associated with them in their dashboard which will be then used to generate the keys.
  5. Then you can navigate to Model > RestRequest.swift and find the line 23 & 24 where you have to replace the **clientID** & **clientSecret** with your own keys which you generated earlier.
  6. Whoooray 🎉 🎉 now you're done with the setting up part ... Finally run the app on your simulator or your device of your choice and enjoy having **Travo** as your travel companion.
  
## Built With <img src="https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fcdn4.iconfinder.com%2Fdata%2Ficons%2Flogos-3%2F1300%2Fswift-seeklogo-512.png&f=1&nofb=1.png" alt="Swift" width="30"> <img src="https://www.websitemagazine.com/images/blog/foursquarenew.png" alt="Foursquare" width="30"> <img src="https://openweathermap.org/themes/openweathermap/assets/img/openweather-negative-logo-RGB.png" alt="Openweather" width="60"> <img src="https://raw.githubusercontent.com/Alamofire/Alamofire/master/alamofire.png" alt="Alamofire" width="60"> 

- [Swift](https://developer.apple.com/swift/) - Swift is a powerful and intuitive programming language for macOS, iOS, watchOS, tvOS and beyond. Writing Swift code is interactive and fun, the syntax is concise yet expressive, and Swift includes modern features developers love. <br>
- [Foursquare API](https://developer.foursquare.com/places) - The Foursquare Places API provides location based experiences with diverse information about venues, users, photos, and check-ins. The API supports real time access to places, Snap-to-Place that assigns users to specific locations, and Geo-tag. Additionally, Foursquare allows developers to build audience segments for analysis and measurement. JSON is the preferred response format.
- [Open Weather API](https://openweathermap.org/api) - Simple and fast and free weather API from OpenWeatherMap you have access to current weather data, 5- and 16-day forecasts, UV Index, air pollution and historical data.
- [Alamofire](https://github.com/Alamofire/Alamofire) - Alamofire is a Swift-based HTTP networking library for iOS and macOS. It provides an elegant interface on top of Apple’s Foundation networking stack that simplifies a number of common networking tasks.Alamofire provides chainable request/response methods, JSON parameter and response serialization, authentication, and many other features.
- [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) - SwiftyJSON makes it easy to deal with JSON data in Swift.

## Authors ##
- [Gayuru Gunawardena](https://gayurug.com/)
- [Sogyal Sherpa](https://github.com/sogyals429)
- [Jun Cheong](https://github.com/rmit-s3591154-jun-cheong)

<div align="center">
  <sub>Built with ❤︎ by Team iSwift for  <a href="http://www1.rmit.edu.au/browse/;CURPOS=1?QRY=+keywords=COSC2471&course=COSC2471"> iPhone Software Engineering </a>module 🔖
</div>

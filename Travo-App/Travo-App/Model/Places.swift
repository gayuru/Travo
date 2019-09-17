//
//  Places.swift
//  Travo-App
//
//  Created by Gayuru Gunawardana on 11/9/19.
//  Copyright © 2019 Sogyal Thundup Sherpa. All rights reserved.
//

import Foundation

class Places{
    
     private var _places:[Place] = []
    
    var places:[Place]{
        return _places;
    }
    
    init(){
        populatePlaces()
    }
    
    func sortFavourites() -> [Place]{
        return places.sorted(by: { $0.popularityScale > $1.popularityScale })
    }
    
    func sortRecommended() -> [Place]{
        return places.sorted(by: {$0.starRating > $1.starRating })
    }
    
    //temporary hard coded data for the places
    private func populatePlaces(){
        let placeOne = Place(name: "Federation Square",desc: "Federation Square is a venue for arts, culture and public events on the edge of the Melbourne central business district. It covers an area of 3.2 ha (7.9 acres) at the intersection of Flinders and Swanston Streets built above busy railway lines and across the road from Flinders Street station.", location: "Melbourne", address: "Corner Swanston and Flinders Streets, Melbourne", imageURL: "place_federation", openTime: "Open 24 Hours", starRating: 4.5,popularityScale: 10)
        self._places.append(placeOne)
        
        let placeTwo = Place(name: "Royal Botanical Garden",desc: "In the heart of green parkland extending south of the Yarra River, about two kilometers from the CBD, the Royal Botanic Gardens are among the finest of their kind in the world. Established in 1846, the gardens encompass two locations: Melbourne and Cranbourne. The Melbourne Gardens cover an area of 38 hectares with more than 8,500 species of plants, including many rare specimens.", location: "Melbourne", address: "Birdwood Ave, South Yarra", imageURL: "place_botanical_garden", openTime: "7.30AM - 6.30PM", starRating: 4.8,popularityScale: 8)
        self._places.append(placeTwo)
        
        let placeThree = Place(name: "Melbourne Cricket Ground",desc: "Melbourne is the sporting capital of Australia, so it's no surprise that a sports stadium numbers among the city's top tourist attractions. With a capacity of 100,000 and a history dating back to 1853, the MCG is considered one of the world's greatest stadiums.", location: "Melbourne", address: "Brunton Ave, East Melbourne", imageURL: "place_MCG", openTime: "9AM - 5PM", starRating: 4.7,popularityScale:  9)
        self._places.append(placeThree)
        
        let placeFour = Place(name: "Southbank and Arts Centre Melbourne", desc: "On the banks of the Yarra River, a short stroll from Flinders Street Station, this area is packed with cultural attractions. Southbank promenade is filled with indoor/outdoor cafés, restaurants, and live entertainment. An excellent arts and crafts market is held every Sunday, and the area is also home to many festivals throughout the year.", location: "Melbourne", address: "St. Kilda Road, Melbourne", imageURL: "place_art_centre", openTime: "9AM - 11PM", starRating: 4.7,popularityScale: 5)
        self._places.append(placeFour)
        
        let placeFive = Place(name: "National Gallery of Victoria", desc: "The oldest public art gallery in Australia, the National Gallery of Victoria holds more than 70,000 works of art in two city locations. The international collection is housed in the St. Kilda Road building, originally opened in 1968 and extensively renovated in 2003. The building is renowned for The Great Hall, where visitors are encouraged to lie on the floor and gaze at the colorful stained glass ceilin", location: "Melbourne", address: "St. Kilda Road, Melbourne and Federation Square", imageURL: "place_national_gallery", openTime: "10AM - 5PM", starRating: 4.7,popularityScale: 6)
        self._places.append(placeFive)
        
        let placeSix = Place(name: "Eureka Tower", desc: "Named in recognition of The Eureka Stockade, the 1854 rebellion of prospectors in the Victorian goldfields, the Eureka Tower stands 91 stories above ground in the heart of Southbank. The skyscraper's gold crown and gold-plated windows add to the theme and literally sparkle when the sun catches the top of the building.", location: "Melbourne", address: " 7 Riverside Quay, Southbank", imageURL: "place_eureka_tower", openTime: "10AM - 10PM", starRating: 4.5,popularityScale: 8)
        self._places.append(placeSix)
        
        let placeSeven = Place(name: "Arcades and Laneways", desc: "Wandering the labyrinth of lanes and alleyways around Flinders, Collins, and Bourke Streets reveals elegant, interesting, and quirky Melbourne at its best. The jewel in the crown is the magnificent Block Arcade in Collins Street. With its mosaic floor, period details, and unique shops, this is the place where late 19th-century gentry promenaded, coining the phrase, 'doing the block'.", location: "Melbourne", address: "Melbourne Laneways", imageURL: "place_laneways", openTime: "8AM - 10PM", starRating: 4.8,popularityScale: 6)
        self._places.append(placeSeven)
        
        let placeEight = Place(name: "Melbourne Museum", desc: "A short tram ride from the CBD, the Melbourne Museum is surrounded by beautiful gardens and parkland. This modern purpose-built museum houses a diverse collection depicting society and cultures. Highlights include Bunjilaka Aboriginal Cultural Centre; the Phar Lap exhibit, about Australia's greatest racehorse; and the Children's Gallery, a series of hands-on activities designed to stimulate and engage youngsters.", location: "Melbourne", address: "11 Nicholson Street, Carlton", imageURL: "place_melbourne_museum", openTime: "10AM - 5PM", starRating: 4.6,popularityScale: 3)
        self._places.append(placeEight)
        
    }
}

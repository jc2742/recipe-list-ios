//
//  Recipe.swift
//  A4
//
//  Created by Jack Chen on 4/19/24.
//

import Foundation

struct Publisher: Codable {
    let id: Int
    let username: String
}

struct Recipe : Decodable {
    let id: Float
    let description: String?
    let difficulty: String?
    let image_url: String?
    let title: String?
    let rating: Float?
    let ingredients: String
    let directions: String?
    let publisher: Publisher?
}

struct RecipeResponse: Decodable {
    let recipes: [Recipe]
}

//let dummyData : [Recipe] = [
//        Recipe(
//            id: "801343ed-fc1b-4ed0-a226-2381f0ec4186",
//            description: "This ropa vieja is great served on tortillas or over rice. Add sour cream, cheese, and fresh cilantro on the side.",
//            difficulty: "Intermediate",
//            image_url: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimages.media-allrecipes.com%2Fuserphotos%2F8368708.jpg&q=60&c=sc&orient=true&poi=auto&h=512",
//            name: "Cuban Ropa Vieja",
//            rating: 4.4,
//            ingredients: "YIP YAP",
//            directions: "Yipper Yapper"
//        ),
//        Recipe(
//            id: "9d40a3f8-a40f-48c0-9aa6-28031fddde81",
//            description: "You only need 3 ingredients for this crockpot Italian chicken with Italian dressing and Parmesan cheese. Nothing could be easier than this for a weekday meal that's ready when you get home.",
//            difficulty: "Beginner",
//            image_url: "https://www.allrecipes.com/thmb/cLLmeWO7j9YYI66vL3eZzUL_NKQ=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7501402crockpot-italian-chicken-recipe-fabeveryday4x3-223051c7188841cb8fd7189958c62f3d.jpg",
//            name: "Crockpot Italian Chicken",
//            rating: 4.5,
//            ingredients: "YIP YAP",
//            directions: "Yipper Yapper"
//        ),
//        Recipe(
//            id: "0c28ab59-e99d-4ec1-be2f-359a92537560",
//            description: "This crockpot mac and cheese recipe is creamy, comforting, and takes just moments to assemble in a slow cooker. Great for large family gatherings and to take to potluck dinners. It's always a big hit!",
//            difficulty: "Beginner",
//            image_url: "https://www.allrecipes.com/thmb/wRSDpUgu8VR2PpQtjGq97cuk8Fo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/237311-slow-cooker-mac-and-cheese-DDMFS-4x3-9b4a15f2c3344c1da22b034bc3b35683.jpg",
//            name: "Slow Cooker Mac and Cheese",
//            rating: 4.3,
//            ingredients: "YIP YAP",
//            directions: "Yipper Yapper"
//        ),
//        Recipe(
//            id: "ef10e605-65d0-4a85-9fd8-8e3294939473",
//            description: "My mother was one of the best cooks I ever knew. Whenever she made stews we mostly found homemade dumplings in them. We never ate things from packages or microwaves and you sure could taste what food was. That's the only way I cook today - I don't use any electronic gadgets to cook with except an electric stove.",
//            difficulty: "Beginner",
//            image_url: "https://www.allrecipes.com/thmb/neJT4JLJz7ks8D0Rkvzf8fRufWY=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/6900-dumplings-DDMFS-4x3-c03fe714205d4f24bd74b99768142864.jpg",
//            name: "Homemade Dumplings",
//            rating: 4.7,
//            ingredients: "YIP YAP",
//            directions: "Yipper Yapper"
//        ),
//        Recipe(
//            id: "a69bdffc-c9ba-428b-8f06-24cef356a611",
//            description: "Succulent pork loin with fragrant garlic, rosemary, and wine.",
//            difficulty: "Advanced",
//            image_url: "https://www.allrecipes.com/thmb/llWmU-j1PO7kCPvKkzQnfmeBf0M=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/21766-roasted-pork-loin-DDMFS-4x3-42648a2d6acf4ef3a05124ef5010c4fb.jpg",
//            name: "Roasted Pork Loin",
//            rating: 4.5,
//            ingredients: "YIP YAP",
//            directions: "Yipper Yapper"
//        ),
//        Recipe(
//            id: "85745755-11dd-4e68-8953-15f5194971bc",
//            description: "My version of chicken Parmesan is a little different than what they do in the restaurants, with less sauce and a crispier crust.",
//            difficulty: "Intermediate",
//            image_url: "https://www.allrecipes.com/thmb/0NW5WeQpXaotyZHJnK1e1mFWcCk=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/223042-Chicken-Parmesan-mfs_001-7ab952346edc4b2da36f3c0259b78543.jpg",
//            name: "Chicken Parmesan",
//            rating: 4.8,
//            ingredients: "YIP YAP",
//            directions: "Yipper Yapper"
//        )
//    ]

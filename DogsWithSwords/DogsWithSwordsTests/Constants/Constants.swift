//
//  Constants.swift
//  DogsWithSwordsTests
//
//  Created by Manuel Peixoto on 30/06/2023.
//

import Foundation
@testable import DogsWithSwords

struct TestStrings {
    static let breedOkString = """
[
    {
        "weight": {
            "imperial": "6 - 13",
            "metric": "3 - 6"
        },
        "height": {
            "imperial": "9 - 11.5",
            "metric": "23 - 29"
        },
        "id": 1,
        "name": "Affenpinscher",
        "bred_for": "Small rodent hunting, lapdog",
        "breed_group": "Toy",
        "life_span": "10 - 12 years",
        "temperament": "Stubborn, Curious, Playful, Adventurous, Active, Fun-loving",
        "origin": "Germany, France",
        "reference_image_id": "BJa4kxc4X",
        "image": {
            "id": "BJa4kxc4X",
            "width": 1600,
            "height": 1199,
            "url": "https://cdn2.thedogapi.com/images/BJa4kxc4X.jpg"
        }
    }
]
"""

    static let responseErrorString = """
            Couldn't find an image matching the passed 'id' of rkiByec4
"""

    static let imageSearchOkString = """
    {
        "id": "rkiByec47",
        "url": "https://cdn2.thedogapi.com/images/rkiByec47_390x256.jpg",
        "breeds": [
            {
                "weight": {
                    "imperial": "44 - 66",
                    "metric": "20 - 30"
                },
                "height": {
                    "imperial": "30",
                    "metric": "76"
                },
                "id": 3,
                "name": "African Hunting Dog",
                "bred_for": "A wild pack animal",
                "life_span": "11 years",
                "temperament": "Wild, Hardworking, Dutiful",
                "origin": "",
                "reference_image_id": "rkiByec47"
            }
        ],
        "width": 500,
        "height": 335
    }
    """

    static let searchOkString = """
    [
        {
            "weight": {
                "imperial": "8 - 15",
                "metric": "4 - 7"
            },
            "height": {
                "imperial": "Varies",
                "metric": "Varies"
            },
            "id": 263,
            "name": "Yorkipoo",
            "breed_group": "Mixed",
            "life_span": "15 years"
        },
        {
            "weight": {
                "imperial": "4 - 7",
                "metric": "2 - 3"
            },
            "height": {
                "imperial": "8 - 9",
                "metric": "20 - 23"
            },
            "id": 264,
            "name": "Yorkshire Terrier",
            "bred_for": "Small vermin hunting",
            "breed_group": "Toy",
            "life_span": "12 - 16 years",
            "temperament": "Bold, Independent, Confident, Intelligent, Courageous",
            "reference_image_id": "B12BnxcVQ"
        }
    ]
    """
}

struct DefaultModels {

    static let breedsModel = BreedModel(id: 1,
                                        name: "Name",
                                        breedGroup: "Group",
                                        origin: "Origin",
                                        referenceImageID: "123",
                                        category: "Category",
                                        temperament: "Temperament")
}

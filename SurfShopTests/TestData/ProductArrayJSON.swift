//
//  TestProductArray.swift
//  SurfShopTests
//
//  Created by James Pacheco on 2/20/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation

let productArrayJSON = """
[
    {
        "colors":null,
        "id":"584337500384",
        "image_url":"http://localhost:8090/images/slim-flip-flop",
        "price":2700,
        "categoryId":7,
        "specs":[
            "Model Number: SANDAL-2400",
            "Dimensions: 14 x 5 x 5",
            "Weight: 5 oz",
            "Material: Rubber"
        ],
        "sizes":[
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13"
        ],
        "description":"For simple and classic summer style, stick with these flip flops. This perfect flip flop has a molded thin rubber upper, a shock absorbing midsole, and a durable rubber outsole for premium footing. Hit the beach in style this summer.",
        "name":"Slim Flip Flop"
    },
    {
        "colors":null,
        "id":"741014871285",
        "image_url":"http://localhost:8090/images/womans-thong-sandal",
        "price":1699,
        "categoryId":7,
        "specs":[
            "Model Number: SANDAL-1500",
            "Dimensions: 14 x 5 x 5",
            "Weight: 4.5 oz",
            "Material: Rubber, Leather"
        ],
        "sizes":[
            "5",
            "6",
            "7",
            "8",
            "9",
            "10",
            "11",
            "12",
            "13"
        ],
        "description":"Warm weather is more enjoyable with these sandals. The upper of this women's sandal is crafted using faux leather or leather upper and it has an open round toe. To provide comfort for the toe a rolled toe thong post is provided. Interior comfort is provided by the N5 comfort system cushioning insole and the smooth lining. Heel height is inch and non-slip outsole provides a solid grip on different surfaces. Women can have more fun on warm weather days while wearing the Naturalizer Alka women's sandals.",
        "name":"Woman's Thong Sandal"
    },
]
""".data(using: .utf8)!

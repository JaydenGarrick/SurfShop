//
//  TestOrderJSON.swift
//  SurfShopTests
//
//  Created by James Pacheco on 2/20/18.
//  Copyright © 2018 James Pacheco. All rights reserved.
//

import Foundation

let orderJSON = """
{
    "account_id":null,
    "id":"F081FAAE-C91D-4CFA-86B8-D878E8D4290C",
    "subtotal":899,
    "tax":60.682500000000005,
    "date":540854542.05850506,
    "total":959.6825,
    "order_state":"Confirmed",
    "items":[
        {
            "product":{
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
            "quantity":1,
            "size": "7"
        }
    ]
}
""".data(using: .utf8)!

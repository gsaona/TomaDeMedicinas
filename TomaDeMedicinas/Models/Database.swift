//
//  Database.swift
//  TomaDeMedicinas
//
//  Created by Gloria Saona Vázquez  on 17/11/21.
//

import Foundation
import UIKit


struct Profile {
    var name: String
}

struct Medication {
    var name: String
}

struct TakingsOfMedication {
    var profile: Profile
    var medicationName: Medication
    var date: String
    var hour: String
    var quantity: Double
}

var profiles: [Profile] = [Profile(name: "gloria")]

var medicationNames: [Medication] = [Medication(name: "Sintrom"),
                                     Medication(name: "Trankimacin")]

var takingDaysAndQauntity: [TakingsOfMedication] = [TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[0], date: "30/11/2021", hour: "21:00", quantity: 0.5),
                                                    TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[0], date: "01/12/2021", hour: "21:00", quantity: 0.75),
                                                    TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[0], date: "02/12/2021", hour: "21:00", quantity: 0.75),
                                                    TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[0], date: "03/12/2021", hour: "21:00", quantity: 0.5),
                                                    TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "30/11/2021", hour: "21:00", quantity: 1.5),
                                                    TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "01/12/2021", hour: "21:00", quantity: 1.5),
                                                    TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "02/12/2021", hour: "21:00", quantity: 1.5),
                                                    TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "03/12/2021", hour: "21:00", quantity: 1.5),
                                                    TakingsOfMedication(profile: profiles[0], medicationName: medicationNames[1], date: "04/12/2021", hour: "21:00", quantity: 1.5)
                                                   ]

//var takingDaysAndQauntity = [["30/11/2021 21:00", "0.5"],
//                             ["01/12/2021 21:00", "0.75"],
//                             ["02/12/2021 21:00", "0,75"],
//                             ["03/12/2021 21:00", "0.5"]
//                            ]]
//
//
//
//var tomas = [
//    ["gloria", ["Sintrom", [["30/11/2021 21:00", "0.5"],
//                            ["01/12/2021 21:00", "0.75"],
//                            ["02/12/2021 21:00", "0,75"],
//                            ["03/12/2021 21:00", "0.5"]
//                           ]],
//                ["Trankimancin", [["30/11/2021 21:00", "1.5"],
//                                  ["01/12/2021 21:00", "1.5"],
//                                  ["02/12/2021 21:00", "1.5"],
//                                  ["03/12/2021 21:00", "1.5"]
//                                 ]]
//    ]
//]

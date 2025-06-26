//
//  SignCalculator.swift
//  SGNS
//  A simple Swift app for looking up someone's sun and moon signs
//
//  Created by Jeremy Kanter on 6/6/25.
//
//  Copyright (C) 2025 Jeremy Kanter
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

import Foundation
import SwissEphemeris

func initializeSwissEphemeris() {
    JPLFileManager.setEphemerisPath()
}

func getSunSign(from date: Date) -> Zodiac {
    let calendar = Calendar.current
    let month = calendar.component(.month, from: date)
    let day = calendar.component(.day, from: date)
    
    switch (month, day) {
    case (3, 21...31), (4, 1...19):
        return .aries
    case (4, 20...30), (5, 1...20):
        return .taurus
    case (5, 21...31), (6, 1...20):
        return .gemini
    case (6, 21...30), (7, 1...22):
        return .cancer
    case (7, 23...31), (8, 1...22):
        return .leo
    case (8, 23...31), (9, 1...22):
        return .virgo
    case (9, 23...30), (10, 1...22):
        return .libra
    case (10, 23...31), (11, 1...21):
        return .scorpio
    case (11, 22...30), (12, 1...21):
        return .sagittarius
    case (12, 22...31), (1, 1...19):
        return .capricorn
    case (1, 20...31), (2, 1...18):
        return .aquarius
    case (2, 19...29), (3, 1...20):
        return .pisces
    default:
        return .capricorn // Fallback
    }
}

func getMoonSign(from date: Date) -> Zodiac {
    let calendar = Calendar.current
    var components = calendar.dateComponents([.year, .month, .day], from: date)
    components.hour = 12
    components.minute = 0
    components.second = 0
    components.timeZone = TimeZone(identifier: "UTC")
    let noonDate = calendar.date(from: components) ?? date
    
    let moonCoordinate = Coordinate<Planet>(body: .moon, date: noonDate)
    return moonCoordinate.tropical.sign
}

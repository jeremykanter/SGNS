//
//  SGNSApp.swift
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

import SwiftUI
import SwissEphemeris

@main
struct SGNSApp: App {
    init() {
        initializeSwissEphemeris()
    }
    
    var body: some Scene {
        WindowGroup("SGNS") {
            ContentView()
                .frame(minWidth: 320, idealWidth: 400, maxWidth: .infinity, minHeight: 400, idealHeight: 500, maxHeight: .infinity)
        }
        .defaultSize(width: 400, height: 500)
        
        WindowGroup("About SGNS", id: "about-sgns") {
            AboutView()
                .frame(minWidth: 400, idealWidth: 480, maxWidth: .infinity, minHeight: 480, idealHeight: 600, maxHeight: .infinity)
        }
        .defaultSize(width: 480, height: 600)
    }
}

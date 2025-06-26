//
//  AboutView.swift
//  SGNS
//  A simple Swift app for looking up someone's sun and moon signs
//
//  Created by Jeremy Kanter on 6/25/25.
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

struct AboutView: View {
    
    @State private var licenseText : LocalizedStringKey = ""
    
    var body: some View {
        List {
            Section(header: Text("About").monospaced()) {
                Text("SGNS is a simple app for looking up someone's sun and moon signs. It makes use of the Swiss Ephemeris projects by [Astrodienst](https://www.astro.com/swisseph/swephinfo_e.htm) and [Vincent Smithers](https://github.com/vsmithers1087/SwissEphemeris) and is released under the GNU Affero General Public License.")
                    .font(.subheadline)
                    .monospaced()
            }
            Section(header: Text("License").monospaced()) {
                Text(licenseText)
                    .font(.subheadline)
                    .monospaced()
                    .onAppear {
                        self.loadLicense()
                    }
            }
        }
    }
    
    private func loadLicense() {
        guard let path = Bundle.main.path(forResource: "license", ofType: "txt"),
              let content = try? LocalizedStringKey(String(contentsOfFile: path, encoding: .utf8)) else {
            licenseText = "License file not found."
            return
        }
        licenseText = content
    }
    
}

#Preview {
    AboutView()
}

//
//  ContentView.swift
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

struct ContentView: View {
    
    @Environment(\.openWindow) private var openWindow
    
    @State private var date = Date()
    @State private var logoPressed = false
    @State private var showAboutSheet = false

    let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: 1800, month: 1, day: 1)
        let endComponents = DateComponents(year: 2399, month: 12, day: 31)
        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }()
    
    var body: some View {
        VStack(spacing: 4) {
            Spacer()
            Spacer()
            Text("SGNS")
                .font(.largeTitle)
                .monospaced()
                .scaleEffect(logoPressed ? 0.9 : 1.0)
                .padding(4)
                .onLongPressGesture(minimumDuration: 0, maximumDistance: .infinity, pressing: { pressing in
                    withAnimation(.spring(duration: 0.2, bounce: 0.5)) {
                        logoPressed = pressing
                    }
                }, perform: {
                    date = Date.now
                })
            Spacer()
            DatePicker(
                "Birthdate",
                selection: $date,
                in: dateRange,
                displayedComponents: [.date]
            )
            #if os(iOS)
                .datePickerStyle(.wheel)
                .labelsHidden()
            #elseif os(macOS)
                .datePickerStyle(.field)
                .labelsHidden()
            #endif
            Spacer()
            HStack(spacing: 16) {
                VStack(spacing: 8) {
                    Image(systemName: "sun.max")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text(getSunSign(from: date).formatted.dropLast(2))
                        .monospaced()
                }
                .frame(maxWidth: .infinity)
                VStack(spacing: 8) {
                    Image(systemName: "moon.stars")
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                    Text(getMoonSign(from: date).formatted.dropLast(2))
                        .monospaced()
                }
                .frame(maxWidth: .infinity)
            }
            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
            Spacer()
            Spacer()
            Text("Moon signs may not be completely accurate. For better accuracy, use a tool that takes into account the time and place of birth. [View license information.](internal://showAbout)")
                .environment(\.openURL, OpenURLAction { url in
                    if url.absoluteString == "internal://showAbout" {
                        #if os(iOS)
                        showAboutSheet = true
                        #elseif os(macOS)
                        openWindow(id: "about-sgns")
                        #endif
                        return .handled
                    }
                    return .systemAction
                })
                .font(.caption2)
                .foregroundStyle(.tertiary)
                .tint(.accent)
                .frame(alignment: .bottom)
                .multilineTextAlignment(.center)
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                #if os(iOS)
                .sheet(isPresented: $showAboutSheet) {
                    NavigationView {
                        AboutView()
                            .toolbar {
                                ToolbarItem(placement: .topBarLeading) {
                                    Button("Close") {
                                        showAboutSheet = false
                                    }
                                }
                            }
                    }
                }
                #endif
        }
        .padding(8)
    }
    
}

#Preview {
    ContentView()
}

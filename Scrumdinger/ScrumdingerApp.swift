//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Misha Causur on 09.08.2021.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.data
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
           
        }
    }
}

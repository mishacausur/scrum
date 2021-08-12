//
//  ScrumData.swift
//  Scrumdinger
//
//  Created by Misha Causur on 12.08.2021.
//

import Foundation

class ScrumData: ObservableObject {
    @Published var scrums: [DailyScrum] = []
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("scrums.data")
    }
}

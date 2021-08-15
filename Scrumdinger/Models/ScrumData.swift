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
    
    func load() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let data = try? Data(contentsOf: Self.fileURL) else {
                #if DEBUG
                DispatchQueue.main.async {
                    self?.scrums = DailyScrum.data
                }
                #endif
                return
            }
            guard let scrumData = try? JSONDecoder().decode([DailyScrum].self, from: data) else {
                fatalError("Cant read data")
            }
            DispatchQueue.main.async {
                self?.scrums = scrumData
            }
        }
    }
    
    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let scrumData = self?.scrums else {
                fatalError("self is out of scope")
            }
            guard let data = try? JSONEncoder().encode(scrumData) else { fatalError("Error encoding data") }
            do {
                let outFile = Self.fileURL
                try data.write(to: outFile)
            } catch {
                fatalError("Can't write file")
            }
        }
    }
}

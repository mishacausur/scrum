//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Misha Causur on 10.08.2021.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresented = false
    @State private var newScrum = DailyScrum.Data()
    var body: some View {
        List {
            ForEach(scrums) { scrums in
                NavigationLink(destination: DetailView(scrum: binding(for: scrums))) {
                    CardView(scrum: scrums)
                        
                }
                .listRowBackground(scrums.color)
            }
        }
        .navigationTitle("Daily Scrum")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrum)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let newScrum = DailyScrum(title: newScrum.title, attendees: newScrum.attendees, lengthInMinutes: Int(newScrum.lengthInMinutes), color: newScrum.color)
                        scrums.append(newScrum)
                        isPresented = false
                    })
                    
            }
        }
    }
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else { fatalError("Cannot find index") }
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data))
        }
        
    }
}

//
//  HistoryView.swift
//  Scrumdinger
//
//  Created by Misha Causur on 15.08.2021.
//

import SwiftUI

struct HistoryView: View {
    let history: History
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding([.bottom])
                Text("Attendees")
                    .font(.headline)
                Text(history.attendeeString)
                    .padding([.bottom])
                if let transcript = history.transcript {
                    Text("Transript")
                        .font(.headline)
                    Text(transcript)
                }
            }
        }
        .navigationTitle(Text(history.date, style: .date))
        .padding()
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(history: History(attendees: ["Jon", "Darla", "Luis"], lengthInMinutes: 10, transcript: "Darla, would you like to start today? Sure, yesterday I reviewed Luis' PR and met with the design team to finalize the UI..."))
    }
}

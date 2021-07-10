//
//  DonutListView.swift
//  IterableSample
//
//  Created by Christina Schell on 7/9/21.
//

import SwiftUI

struct DonutListView: View {
    @EnvironmentObject var appState: AppState
    var donuts = Donuts.all
    var body: some View {
        NavigationView {
            List(donuts) { donut in
                NavigationLink(
                    destination: DonutDetailView(donut: donut),
                    tag: donut.id,
                    selection: self.$appState.selectedDonut)
                    {
                        DonutRowView(donut: donut)
                }
            }
            .navigationTitle("Menu")
        }
    }
}

struct DonutRowView: View {
    var donut: Donut
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(donut.name)
                    .font(.system(size: 20))
                Text(String(donut.price))
                    .font(.caption)
            }
            Spacer()
            Image(donut.image)
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .modifier(CircleImageView(shadowRadius: 3, lineWidth: 1, color: .gray))
        }
    }
}

struct DonutListView_Previews: PreviewProvider {
    static var previews: some View {
        DonutListView()
    }
}

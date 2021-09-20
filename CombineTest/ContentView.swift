//
//  ContentView.swift
//  CombineTest
//
//  Created by Eneko Alonso on 7/6/19.
//  Copyright © 2019 Eneko Alonso. All rights reserved.
//

import SwiftUI
import Combine

//@Published

struct ContentView : View {
    @State var circuits: [Circuit] = []
    @State var time: String = ""

    var body: some View {
        VStack {
            Text("Circuits: \(circuits.count)")
            Text("The time is:\n\(time)").lineLimit(2)

            Button(action: {
                _ = CircuitPublisher.shared.publisher.sink { completion in
                    dump(completion)
                } receiveValue: { circuits in
                    self.circuits = circuits
                }
                _ = TimePublisher.shared.publisher.sink(receiveCompletion: { (completion) in
                    dump(completion)
                }, receiveValue: { (time) in
                    self.time = time.datetime
                })
            }, label: { Text("Get Time") })
            .padding()
        }
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif

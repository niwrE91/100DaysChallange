import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        
        let amountPerPerson = subTotal / peopleCount

        return amountPerPerson
    }
    
    var subTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let subTotal = checkAmount + tipValue
        
        return subTotal
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Betrag", value: $checkAmount, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    
                    Picker("Anzahl der Leute", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) Leute")
                        }
                    }
                }
                Section {
                    Picker("Trinkgeld in Prozent", selection: $tipPercentage) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.menu)
                } header: {
                    Text("Wie viel Trinkgeld wollt ihr da lassen?")
                }
                Section {
                    Text(subTotal, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                }header: {
                    Text("Zwischensumme (Rechnung + Trinkgeld)")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "EUR"))
                }header: {
                    Text("Betrag pro Person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

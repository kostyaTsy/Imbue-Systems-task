//
//  ContentView.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 18.07.22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dbManager = DBManager.manager
    
    // MARK: vars to displaying errors in DBManager
    @State var errorMsg: String = ""
    @State var errorOccurred: Bool = false
    var body: some View {
        VStack {
            Text("Diagram")
                .font(.title).bold()
            Image(systemName: "photo")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
                .padding()
            
            
            List(dbManager.paymentsInfo) {item in
                VStack {
                    PaymentCellView(paymentInfo: item)
                }
            }
            .listStyle(.inset)
            
        }
        .alert(errorMsg, isPresented: $errorOccurred, actions: {
            Button("OK", role: .cancel) { }
        })
        .onAppear {
            do {
                try dbManager.getDBData()
            }
            catch SQLiteError.DatabaseNotOpened(let msg) {
                errorMsg = msg
                errorOccurred.toggle()
            }
            catch {
                errorMsg = error.localizedDescription
                errorOccurred.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

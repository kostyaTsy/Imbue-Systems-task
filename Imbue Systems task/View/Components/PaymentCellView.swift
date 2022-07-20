//
//  PaymentCellView.swift
//  Imbue Systems task
//
//  Created by Kostya Tsyvilko on 19.07.22.
//

import SwiftUI

struct PaymentCellView: View {
    @State var paymentInfo: PaymentModel
    var body: some View {
        HStack {
            // Image near name
            VStack {
                Image(systemName: paymentInfo.status == .succeeded ? "checkmark" : "clock.badge.checkmark")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20)
                Spacer()
            }
            
            // Content (name, email, phone number)
            VStack {
                // Name and amount of payment
                HStack {
                    Text(paymentInfo.name)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, bottomPadding)
                
                // Phone number
                if let phoneNumber = paymentInfo.phoneNumber {
                    HStack {
                        Image(systemName: "phone.fill")
                        Text(phoneNumber)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom, bottomPadding)
                }
                
                // Email
                if let email = paymentInfo.email {
                    HStack {
                        Image(systemName: "mail.fill")
                        Text(email)
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.bottom, bottomPadding)
                }
                
                if paymentInfo.email == nil && paymentInfo.phoneNumber == nil {
                    Spacer()
                }
                
            }
            .padding(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Amount of payment, date
            VStack {
                Text("$"+String(paymentInfo.amountOfPayment))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                Spacer()
                Text("\(paymentInfo.date.formattedDate())")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, bottomPadding)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(maxWidth: 100, alignment: .trailing)
        }
        .padding(.vertical, bottomPadding)
        
    }
    
    // MARK: constnats
    let bottomPadding: CGFloat = 5
}

struct PaymentCellView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCellView(paymentInfo: PaymentModel(id: 1, name: "Kostya Tsyvilko", email: "kostya.tsyvilko@gmail.com", phoneNumber: "+1 (717) 456-1234", amountOfPayment: 50.01, date: Date(), status: .pending))
    }
}

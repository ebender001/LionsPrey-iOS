//
//  AboutContainerView.swift
//  Lions Prey
//
//  Created by Edward Bender on 9/6/21.
//

import SwiftUI

struct AboutContainerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Text("Information")
                    .font(.title)
                    .bold()
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Dismiss")
                        .foregroundColor(.secondary)
                })
                    
                }
            AboutView()
        }
        .padding()
    }
}

struct AboutContainerView_Previews: PreviewProvider {
    static var previews: some View {
        AboutContainerView()
    }
}

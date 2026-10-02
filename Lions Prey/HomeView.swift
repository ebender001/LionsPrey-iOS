//
//  HomeView.swift
//  Lions Prey
//
//  Created by Edward Bender on 10/3/25.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var dataCalculator = DataCalculator()
        
    let ageUpperLimit: Double = 86
    let ageLowerLimit: Double = 17
    let noduleSizeLowerLimit: Double = 0
    let noduleSizeUpperLimit: Double = 41
    let suvLowerLimit: Double = 0
    let suvUpperLimit: Double = 31
    let packYearsLowerLimit: Double = 0
    let packYearsUpperLimit: Double = 101
    let sizeDynamicsLowerLimit: Double = 0
    let sizeDynamicsUpperLimit: Double = 31
    
    let height = UIScreen.main.bounds.height
    
    @State private var showResult = false
    @State private var showAbout = false
    
    @AppStorage("disclaimerShown") var disclaimerShown = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                patientAge
                smokingCancer
                packYears
                noduleSize
                spiculatedSolid
                followUpCT
                petCT
                
                Spacer()
                
                calculateButton
                
                
            }
            .alert(isPresented: $showResult) {
                Alert(title: Text("Probability of malignancy"),
                      message: Text("\(dataCalculator.predictedMalignancy)"),
                      dismissButton: .default(Text("Dismiss")))
            }
            .padding()
            .background(Image("bgImage")
                            .resizable()
                            .ignoresSafeArea(.all)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            )
            .navigationBarTitle("LIONS PREY", displayMode: height > 700 ? .large : .inline)
            .navigationBarItems(leading: Button("About") {
                showAbout = true
            }, trailing: Button("Clear") {
                dataCalculator.clearData()
            })
            .foregroundColor(.white)
        }
        .onAppear {
            if !disclaimerShown {
                showAbout = true
                disclaimerShown = true
            }
        }
        .sheet(isPresented: $showAbout) {
            AboutContainerView()
        }
    }
    
    
    
    //MARK: - COMPONENT VARIABLES
    
    var patientAge: some View {
        VStack(alignment: .leading) {
            Text("Patient Age")
                .bold()
            HStack {
                Slider(value: $dataCalculator.age, in: ageLowerLimit...ageUpperLimit)
                Text("\(dataCalculator.ageString) years")
                    .foregroundColor(.black)
            }
            .padding(6)
            .background(Color(UIColor.white).opacity(0.7))
            .cornerRadius(10)
        }
    }
    
    var smokingCancer: some View {
        VStack {
            HStack {
                Text("Smoker")
                Spacer()
                Text("Cancer History")
            }
            .bold()
            .foregroundColor(.white)
            HStack {
                Toggle("", isOn: $dataCalculator.smoker)
                    .labelsHidden()
                    .padding(6)
                    .background(.white.opacity(0.7))
                    .cornerRadius(10)
                Spacer()
                Toggle("", isOn: $dataCalculator.cancerHistory)
                    .labelsHidden()
                    .padding(6)
                    .background(.white.opacity(0.7))
                    .cornerRadius(10)
            }
        }
    }
    
    var packYears: some View {
        VStack {
            HStack {
                Text("Pack Years")
                    .bold()
                    .foregroundStyle(.white)
                Spacer()
            }
            HStack {
                Slider(value: $dataCalculator.packYears, in: packYearsLowerLimit...packYearsUpperLimit, step: 1)
                Text("\(dataCalculator.packYearsString) PY")
                    .foregroundStyle(.black)
                    
            }
            .padding(5)
            .background(.white.opacity(0.7))
            .cornerRadius(10)
        }
    }
    
    var noduleSize: some View {
        VStack(alignment: .leading) {
            Text("Nodule Size")
                .bold()
            HStack {
                Slider(value: $dataCalculator.noduleSize, in: noduleSizeLowerLimit...noduleSizeUpperLimit)
                Text("\(dataCalculator.noduleSizeString) mm")
                    .foregroundColor(.black)
            }
            .padding(6)
            .background(Color(UIColor.white).opacity(0.7))
            .cornerRadius(10)
        }
    }
    
    var spiculatedSolid: some View {
        VStack {
            HStack {
                Text("Spiculated")
                Spacer()
                Text("Solid")
            }
            .bold()
            .foregroundColor(.white)
            HStack {
                Toggle("", isOn: $dataCalculator.spiculated)
                    .labelsHidden()
                    .padding(6)
                    .background(.white.opacity(0.7))
                    .cornerRadius(10)
                Spacer()
                Toggle("", isOn: $dataCalculator.solid)
                    .labelsHidden()
                    .padding(6)
                    .background(.white.opacity(0.7))
                    .cornerRadius(10)
            }
        }
    }
    
    var followUpCT: some View {
        VStack(alignment: .leading) {
            Toggle("Follow-up CT scan available", isOn: $dataCalculator.followupCT.animation())
            if dataCalculator.followupCT {
                VStack(alignment: .leading) {
                    Text("Size dynamics")
                    HStack {
                        Slider(value: $dataCalculator.sizeDynamics, in: sizeDynamicsLowerLimit...sizeDynamicsUpperLimit)
                        Text("\(dataCalculator.sizeDynamicsString) mm/3 months")
                    }
                }
            }
        }
        .foregroundStyle(.black)
        .padding(6)
        .background(.white.opacity(0.7))
        .cornerRadius(10)
    }
    
    var petCT: some View {
        VStack {
            Toggle("PET/CT scan available", isOn: $dataCalculator.petAvailable.animation())
                .foregroundStyle(.black)
            if dataCalculator.petAvailable {
                HStack {
                    Text("SUV max")
                    Slider(value: $dataCalculator.suvMax, in: suvLowerLimit...suvUpperLimit)
                    Text("\(dataCalculator.suvMaxString)")
                }
                .foregroundStyle(.black)
            }
        }
        .padding(5)
        .background(.white.opacity(0.7))
        .cornerRadius(10)
    }
    
    var calculateButton: some View {
        HStack {
            Spacer()
            Button(action: {
                showResult = true
            }) {
                Text("Calculate")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            Spacer()
        }
        .padding()
        .background(Color("DarkBlue"))
        .cornerRadius(3)
    }
}

#Preview {
    HomeView()
}

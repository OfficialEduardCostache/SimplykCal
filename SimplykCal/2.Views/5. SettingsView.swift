//
//  5. SettingsView.swift
//  SimplykCal
//
//  Created by Eduard Costache on 21/08/2025.
//
import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack{
            ScrollView{
                GeneralSection()
                ThemeSection()
            }
            .background(Color("background").ignoresSafeArea(.all))
        }
    }
}

private struct GeneralSection: View {
    var body: some View {
        VStack{
            Text("General")
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .foregroundStyle(Color("text1"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            VStack{
                SectionContent(systemImageName: "person", title: "Profile")
                    .padding(.leading, 20)
                    .padding(.top, 20)
                
                Rectangle()
                    .frame(height: 1)
                    .padding(.horizontal, 36)
                    .padding(.vertical, 4)
                    .foregroundStyle(Color("secondary").opacity(0.2))
                
                SectionContent(systemImageName: "creditcard", title: "Subscription")
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
            }

            .background(
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .fill(Color("background2"))
            )
            .padding(.horizontal)
        }
       
    }
}

private struct SectionContent: View {
    let systemImageName: String
    let title: String
    
    var body: some View {
        HStack{
            Image(systemName: systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(Color("text2"))
            
            Text(title)
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .foregroundStyle(Color("text2"))
            
            Spacer()
            
            Image(systemName: "chevron.forward")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .padding(.trailing, 20)
                .foregroundStyle(Color("text2"))
        }
    }
}

private struct ThemeSection: View{
    var body: some View{
        VStack{
            Text("Themes")
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .foregroundStyle(Color("text1"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            
            HStack{
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .fill(Color("background2"))
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .fill(Color("background2"))
                    .frame(width: 100, height: 100)
                
                Spacer()
                
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .fill(Color("background2"))
                    .frame(width: 100, height: 100)
            }
            .padding(.horizontal)
        }
    }
}



#Preview {
    SettingsView()
}

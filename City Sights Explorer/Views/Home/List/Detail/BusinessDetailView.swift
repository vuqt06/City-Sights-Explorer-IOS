//
//  BusinessDetailView.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/23/22.
//

import SwiftUI

struct BusinessDetailView: View {
    var business: Business
    @State private var showDirectons = false
    private let turquoise = Color(red: 55/255, green: 197/255, blue: 192/255)
    var body: some View {
        VStack(alignment: .leading) {
            VStack(spacing: 0) {
                GeometryReader {
                    geo in
                    let uiImage = UIImage(data: business.imageData ?? Data())
                    Image(uiImage: uiImage ?? UIImage())
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: geo.size.height)
                        .clipped()
                }.ignoresSafeArea(.all, edges: .top)
                
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 36)
                        .foregroundColor(business.is_closed! ? .gray : .blue)
                    
                    Text(business.is_closed! ? "Closed" : "Open")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.leading)
                }
            }
            
            Group {
                BusinessTitle(business: business)
                    .padding()
                Divider()
                
                // Phone
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.display_phone ?? "")
                    Spacer()
                    Link(destination: URL(string: "tel:\(business.phone ?? "")")!) {
                        Image(systemName: "phone.fill")
                    }
                }
                .padding()
                
                Divider()
                
                // Reviews
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.review_count ?? 0))
                    Spacer()
                    Link(destination: URL(string: "\(business.url ?? "")")!) {
                        Image(systemName: "arrow.forward.circle.fill")
                    }
                }
                .padding()
                
                Divider()
                
                // Website
                HStack {
                    Text("Website:")
                        .bold()
                    Text(String(business.url ?? ""))
                        .lineLimit(1)
                    Spacer()
                    Link(destination: URL(string: "\(business.url ?? "")")!) {
                        Image(systemName: "arrow.up.right.circle.fill")
                    }
                }
                .padding()
                
                Divider()
            }
            // TODO: Get direction buttion
            Button {
                showDirectons = true
            } label: {
                ZStack{
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(turquoise)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }.padding()
                .sheet(isPresented: $showDirectons) {
                    DirectionView(business: business)
                }
        }
    }
}

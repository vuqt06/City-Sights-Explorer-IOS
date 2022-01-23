//
//  BusinessDetailView.swift
//  City Sights Explorer
//
//  Created by Vu Trinh on 1/23/22.
//

import SwiftUI

struct BusinessDetailView: View {
    var business: Business
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
                // Business Name
                Text(business.name!)
                    .font(.largeTitle)
                    .padding()
                // Address
                if business.location?.display_address != nil {
                    ForEach(business.location!.display_address!, id: \.self) {
                        display in
                        Text(display)
                            .padding(.horizontal)
                    }
                }
                
                // rating
                Image("regular_\(business.rating ?? 0)")
                    .padding()
                Divider()
                
                // Phone
                HStack {
                    Text("Phone:")
                        .bold()
                    Text(business.display_phone ?? "")
                    Spacer()
                    Link("Call", destination: URL(string: "tel:\(business.phone ?? "")")!)
                }
                .padding()
                
                Divider()
                
                // Reviews
                HStack {
                    Text("Reviews:")
                        .bold()
                    Text(String(business.review_count ?? 0))
                    Spacer()
                    Link("Read", destination: URL(string: "\(business.url ?? "")")!)
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
                    Link("Visit", destination: URL(string: "\(business.url ?? "")")!)
                }
                .padding()
                
                Divider()
            }
            // TODO: Get direction buttion
            Button {
                
            } label: {
                ZStack{
                    Rectangle()
                        .frame(height: 48)
                        .foregroundColor(.blue)
                        .cornerRadius(10)
                    
                    Text("Get Directions")
                        .foregroundColor(.white)
                        .bold()
                }
            }.padding()
        }
    }
}

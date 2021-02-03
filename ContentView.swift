//
//  ContentView.swift
//  huangli
//
//  Created by yintao on 2/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var pickDate: Date = NSDate.now
    @ObservedObject var  huangLiManager = HuangLiManager.shared
    
    var body: some View {
        //print("****")
        return ZStack{
            VStack{
                
                PickDateView(pickDate: $pickDate)
                
                List{
                    //show day
                    HStack{
                        Spacer()
                        Text("\(huangLiManager.day)")
                            .font(Font.system(size: 100))
                        Spacer()
                    }
                    
                    ForEach(huangLiManager.huangLis){ item in
                        HuangLiItemView(huangLiItem: item)
                        
                    }
                    
                    Divider().padding()
                    
                    ForEach(huangLiManager.huangLiTimes){ item in
                        HuangLiTimeItemView(timeItem: item)
                    }
                    
                    //for admob
                    Spacer().frame(height:65)
                }
                
            }
            
        }.onAppear{
            HuangLiManager.shared.loadJS()
            HuangLiManager.shared.setPickDate(date: pickDate)
            HuangLiManager.shared.update()
            
        }.onChange(of: pickDate){ value in    //when pickDate changed , trigger
            //print("\(pickDate)")
            HuangLiManager.shared.setPickDate(date: pickDate)
            HuangLiManager.shared.update()
        }
    }
}

/*
 HuangLiManager.shared.execJS(year: 2021, month: 8, day: 1)
 HuangLiManager.shared.showHuangLis()
 */
struct PickDateView: View {
    @Binding var pickDate: Date
    
    let dateRange = HuangLiManager.shared.getDateRange()
    
    var body: some View{
        HStack{
            Button(action: {
                pickDate = HuangLiManager.shared.prevDate()
            }, label: {
                Image(systemName: "chevron.left")
            }).padding(.horizontal)
            
            DatePicker("择日", selection: $pickDate, in: dateRange, displayedComponents: .date)
                .labelsHidden()
            
            Button(action: {
                pickDate = HuangLiManager.shared.nextDate()
            }, label: {
                Image(systemName: "chevron.right")
            }).padding(.horizontal)
            
            
        }
    }
}

//-------------------------------
struct HuangLiItemView : View {
    let  huangLiItem : HuangLiItem
    @ObservedObject var  huangLiManager = HuangLiManager.shared
    
    var body: some View{
        //print("------")
        return VStack(alignment: .leading) {
            if !huangLiItem.title.isEmpty{
                HStack{
                    Text(huangLiItem.title)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                    
                    Spacer()
                }.padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
            }
            
            Text( huangLiItem.content)
                .font(.body)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
            
        }
        .padding(8)
        .background( (huangLiItem.id % 2 == 0) ? Color(UIColor.secondarySystemBackground): Color(UIColor.systemBackground))
    }
}

//-------------------------------
struct HuangLiTimeItemView : View {
    let  timeItem : TimeItem
    @ObservedObject var  huangLiManager = HuangLiManager.shared
    
    var body: some View{
        //print("------")
        return VStack(alignment: .leading) {
    
                HStack{
                    Text(timeItem.title)
                        .multilineTextAlignment(.leading)
                        .font(.body)
                    
                    Spacer()
                }.padding(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 0))
                .background(Color(UIColor.secondarySystemBackground))
        
            
            Text( timeItem.content)
                .font(.body)
                .fontWeight(.heavy)
                .multilineTextAlignment(.leading)
                .lineLimit(nil)
            
        }.padding(8)
       
    }
}

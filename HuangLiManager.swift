//
//  HuangLiManager.swift
//  huangli
//
//  Created by yintao on 2/1/21.
//

import Foundation
import JavaScriptCore
import Combine

class HuangLiItem : Identifiable {
    var  id = 0
    var title:String
    var htmlID : String  //only for map , tip
    var script : String //js script
    var  explain: String
    var  content: String
    
    init(){
       title = ""
        htmlID = ""
        script = ""
        explain = ""
        content = ""
    }
    
}

class TimeItem : Identifiable {
    var  id = 0
    var title:String
    var content: String
    
    init(){
       title = ""
        content = ""
    }
    
}

//---------------------------------------------------

class HuangLiManager : ObservableObject {
    public static let shared = HuangLiManager()
    
    private init(){
        
        huangLis = []
        
        
        var item = HuangLiItem()
        
        item.title = "公历"
        item.htmlID = "c"
        item.script = "s.getYear() + '年 ' + s.getMonth() + '月 ' + s.getDay() + '日 星期' + s.getWeekInChinese() + ' ' + s.getXingZuo() + '座 (阳历)';"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "农历"
        item.htmlID = "b"
        item.script = "d.getYearInChinese() + '年 ' + d.getMonthInChinese() + '月 ' + d.getDayInChinese() + ' (阴历)';"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "年"
        item.htmlID = "a"
        item.script = "d.getYearInGanZhi() + '年 属' + d.getYearShengXiao() + ' ' + d.getYearNaYin();"
        huangLis.append(item)
                          
        item = HuangLiItem()
        item.title = "月"
        item.htmlID = "a1"
        item.script = "d.getMonthInGanZhi() + '月 属' + d.getMonthShengXiao() + ' ' + d.getMonthNaYin();"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "日"
        item.htmlID = "a2"
        item.script = "d.getDayInGanZhi() + '日 属' + d.getDayShengXiao() + ' ' + d.getDayNaYin();"
        huangLis.append(item)
     
        item = HuangLiItem()
        item.title = "儒略日"
        item.htmlID = "a3"
        item.script = "s.getJulianDay();"
        item.explain = "olar.jd.html"
        huangLis.append(item)
      
        item = HuangLiItem()
        item.title = "月名"
        item.htmlID = "m"
        item.script = "d.getSeason();"
        item.explain = ""
        huangLis.append(item)
      
        item = HuangLiItem()
        item.title = "月相"
        item.htmlID = "yuexiang"
        item.script = "d.getYueXiang();"
        item.explain = "lunar.yuexiang.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "物候"
        item.htmlID = "wuhou"
        item.script = "d.getWuHou();"
        item.explain = "lunar.wuhou.html"
        huangLis.append(item)
        
     
        
        item = HuangLiItem()
        item.title = "六曜"
        item.htmlID = "liuyao"
        item.script = "d.getLiuYao();"
        item.explain = "lunar.liuyao.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "彭祖百忌"
        item.htmlID = "d"
        item.script = "d.getPengZuGan() + ' ' + d.getPengZuZhi();"
        item.explain = "lunar.pengzu.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "每日宜忌"
        item.htmlID = "yj"
        item.script = "'宜：' + d.getDayYi().join(' ');"
        item.explain = "lunar.yiji.html"
        huangLis.append(item)
        item = HuangLiItem()
        
        item.title = ""
        item.htmlID = "yj"
        item.script = "'忌：' + d.getDayJi().join(' ');"
        item.explain = "lunar.yiji.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "吉神宜趋"
        item.htmlID = "js"
        item.script = "d.getDayJiShen().join(' ');"
        item.explain = "lunar.jishenxiongsha.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "吉神宜趋"
        item.htmlID = "js"
        item.script = "d.getDayJiShen().join(' ');"
        item.explain = "lunar.jishenxiongsha.html"
        huangLis.append(item)
  
        item = HuangLiItem()
        item.title = "凶煞宜忌"
        item.htmlID = "xs"
        item.script = "d.getDayXiongSha().join(' ');"
        item.explain = "lunar.jishenxiongsha.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "相冲"
        item.htmlID = "e"
        item.script = "d.getDayShengXiao() + '日 冲' + d.getChongDesc();"
        item.explain = "lunar.chongsha.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "岁煞"
        item.htmlID = "f"
        item.script = "d.getSha();"
        item.explain = "lunar.chongsha.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "星宿"
        item.htmlID = "g"
        item.script = "d.getGong() + '方' + d.getXiu() + d.getZheng() + d.getAnimal() + ' (' + d.getXiuLuck() + ')';"
        item.explain = "lunar.xiu.html"
        huangLis.append(item)
       
    
        item = HuangLiItem()
        item.title = "星宿歌诀"
        item.htmlID = "g1"
        item.script = "d.getXiuSong();"
        item.explain = "lunar.xiu.html"
        huangLis.append(item)
        
                       
        item = HuangLiItem()
        item.title = "贵神方位"
        item.htmlID = "h"
        item.script = "'阳贵神：' + d.getPositionYangGuiDesc() + ' 阴贵神：' + d.getPositionYinGuiDesc();"
        item.explain = "lunar.jishen.html"
        huangLis.append(item)
 
        item = HuangLiItem()
        item.title = "喜神方位"
        item.htmlID = "i"
        item.script = "d.getPositionXiDesc();"
        item.explain = "lunar.jishen.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "福神方位"
        item.htmlID = "i1"
        item.script = "d.getPositionFuDesc();"
        item.explain = "lunar.jishen.html"
        huangLis.append(item)
      
        item = HuangLiItem()
        item.title = "财神方位"
        item.htmlID = "i2"
        item.script = "d.getPositionCaiDesc();"
        item.explain = "lunar.jishen.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "本月胎神"
        item.htmlID = "i3"
        item.script = "d.getMonthPositionTai();"
        item.explain = "lunar.taishen.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "今日胎神"
        item.htmlID = "i4"
        item.script = "d.getDayPositionTai();"
        item.explain = "lunar.taishen.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "值星"
        item.htmlID = "j"
        item.script = "d.getZhiXing();"
        item.explain = "lunar.zhixing.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "十二天神"
        item.htmlID = "k"
        item.script = "d.getDayTianShen() + '(' + d.getDayTianShenType() + ') ' + d.getDayTianShenLuck();"
        item.explain = "lunar.tianshen.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "空亡所值"
        item.htmlID = "xun"
        item.script = "'年：' + d.getYearXunKong() + '   月：' + d.getMonthXunKong() + '   日：' + d.getDayXunKong();"
        item.explain = "lunar.xun.html"
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "九星"
        item.htmlID = "jiuxing"
        item.script = " jiuxing.getNumber() + jiuxing.getColor() + ' - ' + jiuxing.getNameInTaiYi() + '星(' + jiuxing.getWuXing() + ') - ' + jiuxing.getTypeInTaiYi();"
        item.explain = "lunar.nine.html"
        huangLis.append(item)
      
        
        item = HuangLiItem()
        item.title = "九星歌诀"
        item.htmlID = "jiuxing-song"
        item.script = "jiuxing.getSongInTaiYi();"
        item.explain = "lunar.nine.html"
        huangLis.append(item)

        item = HuangLiItem()
        item.title = "上一节气"
        item.htmlID = "p"
        item.script = "p.getName() + ' ' + p.getSolar().toYmdHms() + ' 星期' + p.getSolar().getWeekInChinese();"
        item.explain = ""
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "下一节气"
        item.htmlID = "n"
        item.script = "n.getName() + ' ' + n.getSolar().toYmdHms() + ' 星期' + n.getSolar().getWeekInChinese();"
        item.explain = ""
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "节日"
        item.htmlID = "x"
        item.script = "d.getFestivals().join('、') + ' ' + s.getFestivals().join('、');"
        item.explain = ""
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "纪念日"
        item.htmlID = "y"
        item.script = "d.getOtherFestivals().join('、') + ' ' + s.getOtherFestivals().join('、');"
        item.explain = ""
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "数九"
        item.htmlID = "shuJiu"
        item.script = "shuJiu ? shuJiu.toFullString() : '';"
        item.explain = ""
        huangLis.append(item)
        
        item = HuangLiItem()
        item.title = "三伏"
        item.htmlID = "fu"
        item.script = "fu ? fu.toFullString() : '';"
        item.explain = "lunar.fu.html"
        huangLis.append(item)
        
        for (i, item) in huangLis.enumerated(){
            item.id = i
        }
     
        //----------------------------
      
        for i in 0...12 {
            let timeItem = TimeItem()
            timeItem.id = i
            huangLiTimes.append(timeItem)
        }
        
    }
    //-----------------------------------
  
   @Published var  huangLis : [HuangLiItem]
    @Published var  huangLiTimes : [TimeItem] = []
    
    var jsContext : JSContext!
     
    let jsfile = "lunar.js"
    
    var year:Int = 0
    var month:Int = 0
    var day:Int = 0
    var pickDate : Date = Date()
    
    func getScriptResult(at index:Int)->String {
        let script = huangLis[index].script
        let result = execJS(script: script)
        return result
    }
    
    //0,1,3,5,7,9,11,13,15,17,19,21,23
    func getHuangLiTime(_ index:Int )-> String {
        if index == 0  {return  "0:00-0:59"}
        
        let i = index - 1
        let t1 = (i + 1) * 2 - 1
        let t2 = (i + 1) * 2 - (i < 11 ? 0 : 1)
        //return "时刻: \(t1):00-\(t2):59"
        return "\(t1):00-\(t2):59"
        
    }
    
    func getHuangLiTimeInfo(_ index:Int )-> String {
        var js1 = ""
        if index == 0 {
         js1 = "var l = Solar.fromYmdHms(\(year), \(month), \(day), 0, 0, 0).getLunar();"
        }else  {
            let i = index - 1
            let t = (i + 1) * 2 - 1
            js1 = "var l = Solar.fromYmdHms(\(year), \(month), \(day), \(t), 0, 0).getLunar();"
        }
        
        runJS(script: js1)
        
        let r1 = "时辰:" + execJS(script:"l.getTimeInGanZhi();")
        let r2 = "天神:" + execJS(script:"l.getTimeTianShen();")
        let r3 = "黑黄道:" + execJS(script:"l.getTimeTianShenType();")
        let r4 = "冲:" + execJS(script:"l.getTimeChongDesc();")
        let r5 = "煞:" + execJS(script:"l.getTimeSha();")
        let r6 = "宜:" + execJS(script:"l.getTimeYi().join(' ');")
        let r7 = "忌:" + execJS(script:"l.getTimeJi().join(' ');")
        
        return
"""
\(r1)
\(r2)
\(r3)
\(r4)
\(r5)
\(r6)
\(r7)
"""
        
    }
    
    //for test, debug
    func showHuangLis(){
       
        for item in huangLis {
            print("\(item.title)   \(execJS(script: item.script)) \n")
        }
        
        for i in 0...12 {
            let time = getHuangLiTime( i)
            print("\(time)")
            
            let info = getHuangLiTimeInfo(i)
            
            print("\(info)")
            
        }
        
    }
   
    func evalueHuangLis(){
       
        for item in huangLis {
            //print("\(item.title)   \(execJS(script: item.script)) \n")
            item.content = execJS(script: item.script)
           
            //print("\(item.content)")
        }
        
        
        for i in 0...12 {
            let time = getHuangLiTime( i)
            //print("\(time)")
            
            let info = getHuangLiTimeInfo(i)
            
            //print("\(info)")
            
            huangLiTimes[i].title = time
            huangLiTimes[i].content = info
            
        }
        
        
    }
    //for datepicker 1901--2099  range
    func getDateRange()->ClosedRange<Date>{
        var  startDC = DateComponents()
        startDC.year = 1901
        startDC.month = 1
        startDC.day = 1
        startDC.hour = 0
        startDC.minute = 0
        startDC.second = 0
        let startDate = Calendar.current.date(from: startDC)!
        
        var  endDC = DateComponents()
        endDC.year = 2099
        endDC.month = 12
        endDC.day = 31
        endDC.hour = 0
        endDC.minute = 0
        endDC.second = 0
        let endDate = Calendar.current.date(from: endDC)!
        
        return startDate ... endDate

    }
    
    func setPickDate(date:Date){
        self.pickDate = date
        let dc = Calendar.current.dateComponents([.day, .year, .month], from: pickDate)
     
        year = dc.year!
        month = dc.month!
        day = dc.day!
        
        print("\(year) \(month) \(day)")
        
       
    }
    
    func update(){
        print("\(#function)")
        
        execJS(year: year, month: month, day: day)
        evalueHuangLis()
        
        objectWillChange.send()
    }
    
    func prevDate()->Date{
        let newDate = Calendar.current.date(byAdding: .day, value: -1, to: pickDate)!
        setPickDate(date: newDate)
        return newDate
    }
    
    func nextDate()->Date{
        let newDate = Calendar.current.date(byAdding: .day, value: 1, to: pickDate)!
        setPickDate(date: newDate)
        return newDate
    }
  
}

//MARK: javascript
extension HuangLiManager {
    func loadJS(){
        guard let url = Bundle.main.url(forResource: jsfile, withExtension: nil) else {
            return
        }
        
        guard let js = try? String(contentsOf: url) else {return}
        
        //print(js)
        jsContext = JSContext()
        jsContext.evaluateScript(js)
        
    }
    
    func execJS(year:Int,month:Int,day:Int ){
        //self.year = year
       // self.month = month
        //self.day = day
        
        let js1 = "var s = Solar.fromYmd(\(year),\(month),\(day));"
        let js2 = "var d = s.getLunar();"
        let js3 = "var jiuxing = d.getDayNineStar();"
        let js4 = "var p = d.getPrevJieQi(), n = d.getNextJieQi();"
        let js5 = "var shuJiu = d.getShuJiu();"
        let js6 = "var fu = d.getFu();"
        
        jsContext.evaluateScript(js1)
        jsContext.evaluateScript(js2)
        jsContext.evaluateScript(js3)
        jsContext.evaluateScript(js4)
        jsContext.evaluateScript(js5)
        jsContext.evaluateScript(js6)
    }
    
    
    func runJS(script:String) {
        jsContext.evaluateScript(script)
        
    }
    
    func execJS(script:String)->String {
        let js = "var temp = \(script)"
        jsContext.evaluateScript(js)
        let temp = jsContext.objectForKeyedSubscript("temp")
        //print("temp:\(temp!)")
        
        if let temp = temp {
            if temp.isString {
                return temp.toString()
            }else if temp.isNumber {
                return "\(temp.toDouble())"
            }
        }
        
        return ""
    }

}

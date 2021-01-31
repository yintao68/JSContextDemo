//
//  MyJSManager.swift
//  swiftuiTest
//
//  Created by yintao on 1/4/21.
//

import Foundation
import JavaScriptCore

class MyJSManager {
   static let shared = MyJSManager()

   var jsContext : JSContext!
    
   let jsfile = "lunar.js"
    
    init() {
    }
    //-----------------------------
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
        let js1 = "var s = Solar.fromYmd(\(year),\(month),\(day));"
        let js2 = "var d = s.getLunar();"
        jsContext.evaluateScript(js1)
        jsContext.evaluateScript(js2)
        
        if let yuexiang = jsContext.evaluateScript("d.getYueXiang();") {
            print("\(yuexiang)")
        }
        if let a = jsContext.evaluateScript("function a(){ return d.getYearInGanZhi();}; a()"){
            print("\(a)")
        }
       //let jsString = "var solar = Solar.fromYmd(2021,1,4);"
       //let jsString1 =  "solar.getLunar().toFullString();"
        //jsContext.evaluateScript(jsString)
        //guard  let result1 = jsContext.evaluateScript(jsString1) else { return}
       
        //print("\(result1) \(result1.isString)")
        
    }
}

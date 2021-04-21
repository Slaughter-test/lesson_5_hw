//
//  Chain.swift
//  lesson_5_hw
//
//  Created by Юрий Егоров on 21.04.2021.
//

import UIKit

func data(from file: String) -> Data {
    let path1 = Bundle.main.path(forResource: file, ofType: "json")!
    let url = URL(fileURLWithPath: path1)
    let data = try! Data(contentsOf: url)
    return data
}

let data1 = data(from: "1")
let data2 = data(from: "2")
let data3 = data(from: "3")

struct DataResult: Codable {
    enum CodingKeys: String, CodingKey {
        case data
    }
    let data: [Person]
}

struct JsonResult: Codable {
    enum CodingKeys: String, CodingKey {
        case result
    }
    let result: [Person]
}

struct Person: Codable {
    let name: String
    let age: Int
    let isDeveloper: Bool
}
protocol DataParser {
    
    var next: DataParser? { get set }
    
    func parseData(_ data: Data) -> [Person?]
    
}
class SimpleDataParser: DataParser {
    
    var next: DataParser?
    
    func parseData(_ data: Data) -> [Person?] {
        guard let parsedData = try? JSONDecoder().decode([Person].self, from: data) else {
            return self.next?.parseData(data) ?? []
        }
        return parsedData
    }
    
    
}
class JsonResultDataParser: DataParser {
    
    var next: DataParser?
    
    func parseData(_ data: Data) -> [Person?] {
        guard let parsedData = try? JSONDecoder().decode(JsonResult.self, from: data) else {
           return self.next?.parseData(data) ?? []

        }
        return parsedData.result
    }
    
}
class DataResultDataParser: DataParser {
    
    var next: DataParser?
    
    func parseData(_ data: Data) -> [Person?] {
        guard let parsedData = try? JSONDecoder().decode(DataResult.self, from: data) else {
           return self.next?.parseData(data) ?? []

        }
        return parsedData.data
    }
}
let sdp = SimpleDataParser()
let jdp = JsonResultDataParser()
let drdp = DataResultDataParser()

//sdp.next = jdp
//jdp.next = drdp
//drdp.next = nil
//sdp.parseData(data1)


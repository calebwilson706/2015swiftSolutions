//
//  day8.swift
//  2015swiftSolutions
//
//  Created by Caleb Wilson on 21/02/2021.
//

import Foundation

struct GraphVertex<T: Hashable> : Hashable {
    var data : T
    
}

struct Edge<T : Hashable> : Hashable {
    var source : GraphVertex<T>
    var destination : GraphVertex<T>
    var weight : Int
}

protocol Graphable {
  associatedtype Element: Hashable // 1
  //var description: CustomStringConvertible { get } // 2
  
  func createVertex(data: Element) // 3
  func add(from source: GraphVertex<Element>, to destination: GraphVertex<Element>, weight: Int) // 4
  func weight(from source: GraphVertex<Element>, to destination: GraphVertex<Element>) -> Int? // 5
  func edges(from source: GraphVertex<Element>) -> [Edge<Element>]? // 6
}

class AdjacencyList<T : Hashable> : Graphable {
    var adjacencyDict : [GraphVertex<T> : [Edge<T>]] = [:]
    
    typealias Element = T
    
    init() {
        
    }
    
    func createVertex(data: T) {
        let vertex = GraphVertex(data: data)
        
        if adjacencyDict[vertex] == nil {
            adjacencyDict[vertex] = []
        }
        
    }
    
    func add(from source: GraphVertex<T>, to destination: GraphVertex<T>, weight: Int) {
        let newEdge = Edge(source: source, destination: destination, weight: weight)
        adjacencyDict[source]?.append(newEdge)
        let secondEdge = Edge(source: destination, destination: source, weight: weight)
        adjacencyDict[destination]?.append(secondEdge)
    }
    func weight(from source: GraphVertex<T>, to destination: GraphVertex<T>) -> Int? {
        return adjacencyDict[source]?.first {$0.destination == destination}?.weight
    }
    func edges(from source: GraphVertex<T>) -> [Edge<T>]? {
        return adjacencyDict[source]
    }
}


class Day9 {
    var myGraph = AdjacencyList<String>()
    
    func getNodes() {
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day9Input.txt"
        
        do {
            let contents = try String(contentsOfFile: filePath)
            let components = contents.components(separatedBy: "\n")
            var ports = [String]()
            
            components.forEach { it in
                let temp = it.filter { $0.isLetter }
                let parts = temp.components(separatedBy: "to")
                ports.append(parts[0])
                ports.append(parts[1])
            }
            
            ports.forEach { port in
                myGraph.createVertex(data: port)
            }
            
            //print(myGraph.adjacencyDict.keys.map {$0.data})
        } catch {
           print(error)
        }
    }
    
    init() {
        getNodes()
        for item in getConnections() {
            myGraph.add(from: GraphVertex(data: item.start), to: GraphVertex(data: item.end), weight: item.weight)
        }
        
        //print(myGraph.edges(from: GraphVertex(data : "AlphaCentauri"))!)
    }
    
    func getConnections() -> [pathToUse] {
        let filePath = "/Users/calebjw/Documents/AdventOfCode/2015/inputs/Day9Input.txt"
        var results = [pathToUse]()
        do {
            let contents = try String(contentsOfFile: filePath)
            let components = contents.components(separatedBy: "\n")
            
            components.forEach { it in
                let firstPartsSplit = it.components(separatedBy: " to ")
                let secondParts = firstPartsSplit.last!.components(separatedBy: " = ")
                
                results.append(pathToUse(start: firstPartsSplit.first!, end: secondParts.first!, weight: Int(secondParts.last!)!))
            }
        } catch {
            print(error)
        }
        
        return results
    }
    
    func getPathsForUsage(starting : String) -> [[String] : Int] {
        var results : [[String] : Int] = [:]
        
        
        
        func getPaths(from : String, current : [String] = [], incomingWeight : Int = 0, currentTotal : Int = 0, offLimits : [String] = []) {
            //print(offLimits)
            var workingOffLimits = offLimits
            workingOffLimits.append(from)
            var working = current
            var workingSize = currentTotal
            working.append(from)
            workingSize += incomingWeight
            
            let next = myGraph.edges(from: GraphVertex(data: from))
            
            if  next == nil || next!.map({ $0.destination.data }).sorted() == offLimits.sorted() {
                results[working] = workingSize
            } else {
                for item in next!.filter({!workingOffLimits.contains($0.destination.data)}) {
                    //print("\(item.source.data) -" + "> \(item.destination.data)")
                    getPaths(from: item.destination.data, current: working, incomingWeight: item.weight, currentTotal: workingSize, offLimits: workingOffLimits)
                    
                }
                
            }
        }
        
        getPaths(from : starting)
        return results
    }
    
    func part1() {
        var currentMinimum = 1000
        for key in self.myGraph.adjacencyDict.keys.map({$0.data}) {
            let allPaths : [[String] : Int] = getPathsForUsage(starting: key)
            let new = allPaths.filter( {$0.key.count == myGraph.adjacencyDict.count}).values.min() ?? currentMinimum
            //print(new)
            if  new < currentMinimum {
                currentMinimum = new
            }
        }
        print(currentMinimum)
        
    }
    
    func part2() {
        var currentMaximum = 0
        for key in self.myGraph.adjacencyDict.keys.map({$0.data}) {
            let allPaths : [[String] : Int] = getPathsForUsage(starting: key)
            let new = allPaths.filter( {$0.key.count == myGraph.adjacencyDict.count}).values.max() ?? currentMaximum
            //print(new)
            if  new > currentMaximum {
                currentMaximum = new
            }
        }
        print(currentMaximum)
        
    }
    
    //for optomisation check if current is bigger than the lowest and if so then return
    //see about generalising the method
    
    
}


struct pathToUse {
    let start : String
    let end : String
    let weight : Int
}

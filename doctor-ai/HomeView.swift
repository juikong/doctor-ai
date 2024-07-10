//
//  HomeView.swift
//  doctor-ai
//
//  Created by Juiko Ong on 06/07/2024.
//

import SwiftUI
import PDFKit

struct HomeView: View {
    @State private var inputText: String = ""
    @State private var textSpacing: String = "\n\n"
    @State private var showFileImporter = false
    @State private var resultColumn = 1
    @State private var haematologyExpanded: Bool = true
    @State private var biochemistryExpanded: Bool = true
    @State private var serologyExpanded: Bool = true
    @State private var microbiologyExpanded: Bool = true
    @State private var navigationPath = NavigationPath()
    @State private var newBatch = 0
    @State private var additionalBatch = 0
    @State private var recognizedResults = [String]()
    @State private var haematologyResults = [Matched]()
    @State private var biochemistryResults = [Matched]()
    @State private var serologyResults = [Matched]()
    @State private var microbiologyResults = [Matched]()
    @StateObject private var itemModel = ItemModel()
    @StateObject private var testnameModel = TestnameModel()
    @StateObject private var testresultModel = TestresultModel()
    @StateObject private var testmatchModel = TestmatchModel()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                Spacer(minLength: 50)
                Text("Upload Medical Report")
                    .font(.largeTitle).foregroundColor(Color(red: 17 / 255, green: 24 / 255, blue: 39 / 255))
                    .padding(.top, 10)
                HStack {
                    Button(action: {
                        showFileImporter.toggle()
                    }) {
                        Text("Choose File")
                            .padding()
                            .background(Color.gray)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding(.leading, 10)
                    
                    TextEditor(text: $inputText)
                        .frame(height: 50)
                        .border(Color.gray, width: 1)
                        .padding()
                }
                .padding(.top, 10)
                Spacer()
                List {
                    DisclosureGroup("Haematology", isExpanded: $haematologyExpanded) {
                        ForEach(haematologyResults, id: \.self) { haematology in
                            HStack {
                                Text(haematology.sub)
                                    .font(.subheadline)
                                Spacer()
                                Text(haematology.result)
                                    .font(.title3)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationPath.append(Matched(main: haematology.main, sub: haematology.sub, result: haematology.result))
                            }
                        }
                    }
                    DisclosureGroup("Biochemistry", isExpanded: $biochemistryExpanded) {
                        ForEach(biochemistryResults, id: \.self) { biochemistry in
                            HStack {
                                Text(biochemistry.sub)
                                    .font(.subheadline)
                                Spacer()
                                Text(biochemistry.result)
                                    .font(.title3)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationPath.append(Matched(main: biochemistry.main, sub: biochemistry.sub, result: biochemistry.result))
                            }
                        }
                    }
                    DisclosureGroup("Serology", isExpanded: $serologyExpanded) {
                        ForEach(serologyResults, id: \.self) { serology in
                            HStack {
                                Text(serology.sub)
                                    .font(.subheadline)
                                Spacer()
                                Text(serology.result)
                                    .font(.title3)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationPath.append(Matched(main: serology.main, sub: serology.sub, result: serology.result))
                            }
                        }
                    }
                    DisclosureGroup("Microbiology", isExpanded: $microbiologyExpanded) {
                        ForEach(microbiologyResults, id: \.self) { microbiology in
                            HStack {
                                Text(microbiology.sub)
                                    .font(.subheadline)
                                Spacer()
                                Text(microbiology.result)
                                    .font(.title3)
                            }
                            .contentShape(Rectangle())
                            .onTapGesture {
                                navigationPath.append(Matched(main: microbiology.main, sub: microbiology.sub, result: microbiology.result))
                            }
                        }
                    }
                }
                .listStyle(SidebarListStyle())
                Spacer()
                Button(action: {
                    for recognized in recognizedResults {
                        testresultModel.addTestresult(withResult: recognized, batch: Int16(newBatch))
                    }
                    itemModel.updateItem(withId: 2, newValue: newBatch)
                    itemModel.updateItem(withId: 3, newValue: additionalBatch)
                    for haematology in haematologyResults {
                        //print("Main: \(haematology.main), Sub: \(haematology.sub), Result: \(haematology.result)")
                        testmatchModel.addTestmatch(withName: haematology.main, sub: haematology.sub, result: haematology.result, batch: Int16(newBatch))
                    }
                    for biochemistry in biochemistryResults {
                        //print("Main: \(biochemistry.main), Sub: \(biochemistry.sub), Result: \(biochemistry.result)")
                        testmatchModel.addTestmatch(withName: biochemistry.main, sub: biochemistry.sub, result: biochemistry.result, batch: Int16(newBatch))
                    }
                    for serology in serologyResults {
                        //print("Main: \(serology.main), Sub: \(serology.sub), Result: \(serology.result)")
                        testmatchModel.addTestmatch(withName: serology.main, sub: serology.sub, result: serology.result, batch: Int16(newBatch))
                    }
                    for microbiology in microbiologyResults {
                        //print("Main: \(microbiology.main), Sub: \(microbiology.sub), Result: \(microbiology.result)")
                        testmatchModel.addTestmatch(withName: microbiology.main, sub: microbiology.sub, result: microbiology.result, batch: Int16(newBatch))
                    }
                }) {
                    Text("Add Records")
#if os(iOS)
                        .frame(maxWidth: .infinity)
#else
                        .frame(maxWidth: 200)
#endif
                        
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
#if os(iOS)
                .padding(.horizontal, 10)
                .padding(.bottom, 100)
#else
                .padding(.top, 10)
                .padding(.bottom, 20)
#endif
            }
            .background(Color.white)
            .edgesIgnoringSafeArea(.all) // Ensure the background covers the entire screen
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
                    itemModel.fetchRevision()
                }
            }
            .navigationDestination(for: Matched.self) { matched in
                HomeDetailView(sub: matched.sub, result: matched.result)
            }
            .fileImporter(isPresented: $showFileImporter, allowedContentTypes: [.pdf], allowsMultipleSelection: false) { result in
                switch result {
                case .success(let urls):
                    if let url = urls.first {
                        //selectedFileURL = url
#if os(iOS)
                        inputText = url.lastPathComponent
#else
                        inputText = textSpacing + url.lastPathComponent
#endif
                        print("Selected file: \(url)")
                        if url.startAccessingSecurityScopedResource() {
                            itemModel.fetchLastBatch()
                            itemModel.fetchTotalBatch()
                            testnameModel.fetchHaematology()
                            testnameModel.fetchBiochemistry()
                            testnameModel.fetchSerology()
                            testnameModel.fetchMicrobiology()
                            recognizeTextUsingAzure(url: url) { recognizedText in
                                DispatchQueue.main.async {
                                    //self.recognizedText = recognizedText
                                    inspectRecognizedText(recognizedText: recognizedText) { success in
                                        if success {
                                            // Pass the array to the completion handler if insert was successful
                                            //completion(recognizedArray)
                                            print("inspected")
                                        } else {
                                            // Handle the error (if needed)
                                            //print("Error inserting into database")
                                            //completion([])
                                            print("not inspected")
                                        }
                                    }
                                }
                            }
                            url.stopAccessingSecurityScopedResource()
                        } else {
                            print("Failed to start accessing security scoped resource")
                        }
                    }
                case .failure(let error):
                    print("File import failed: \(error.localizedDescription)")
                    }
                }
        }
        .tabViewStyle(DefaultTabViewStyle())
    }

    func inspectRecognizedText(recognizedText: [String], completion: @escaping (Bool) -> Void) {
        newBatch = Int(itemModel.lastbatch)! + 1
        //print("New batch \(newBatch.description)")
        additionalBatch = Int(itemModel.totalbatch)! + 1
        //print("Total batch \(additionalBatch.description)")
        recognizedResults = recognizedText
        let matchedHaematology = testnameModel.haematologyTestname.map { $0.sub ?? "" }
        let matchedBiochemistry = testnameModel.biochemistryTestname.map { $0.sub ?? "" }
        let matchedSerology = testnameModel.serologyTestname.map { $0.sub ?? "" }
        let matchedMicrobiology = testnameModel.microbiologyTestname.map { $0.sub ?? "" }
        var matchedResults = [String]()
        
        let reducedHaematology = matchedHaematology.filter { recognizedResults.contains($0) }
        //print("Reduced Haematology: \(reducedHaematology)")
        for index in 0..<recognizedResults.count - 1 {
            let recognizedResult = recognizedResults[index]
            if (recognizedResult == "MCV") {
                resultColumn = detectResultColumn(firstValue: recognizedResults[index + 1], secondValue: recognizedResults[index + 2])
            }
            if (!matchedResults.contains(where: {$0 == recognizedResult})) {
                if reducedHaematology.contains(where: { $0.hasPrefix(recognizedResult) }) {
                    matchedResults.append(recognizedResult)
                    let matched = Matched(main: "Haematology", sub: recognizedResult, result: checkForDecimalResult(firstValue: recognizedResults[index + 1], secondValue: recognizedResults[index + 2]))
                    haematologyResults.append(matched)
                    //print("Matched Haematology: \(matched.sub), Matched Result \(matched.result)")
                }
            }
        }
        let reducedBiochemistry = matchedBiochemistry.filter { recognizedResults.contains($0) }
        //print("Reduced Biochemistry: \(reducedBiochemistry)")
        for index in 0..<recognizedResults.count - 1 {
            let recognizedResult = recognizedResults[index]
            if (!matchedResults.contains(where: {$0 == recognizedResult})) {
                if reducedBiochemistry.contains(where: { $0.hasPrefix(recognizedResult) }) {
                    matchedResults.append(recognizedResult)
                    let matched = Matched(main: "Biochemistry", sub: recognizedResult, result: checkForDecimalResult(firstValue: recognizedResults[index + 1], secondValue: recognizedResults[index + 2]))
                    biochemistryResults.append(matched)
                    //print("Matched Biochemistry: \(matched.sub), Matched Result \(matched.result)")
                }
            }
        }
        let reducedSerology = matchedSerology.filter { recognizedResults.contains($0) }
        //print("Reduced Serology: \(reducedSerology)")
        for index in 0..<recognizedResults.count - 1 {
            let recognizedResult = recognizedResults[index]
            if (!matchedResults.contains(where: {$0 == recognizedResult})) {
                if reducedSerology.contains(where: { $0.hasPrefix(recognizedResult) }) {
                    matchedResults.append(recognizedResult)
                    let matched = Matched(main: "Serology", sub: recognizedResult, result: checkForDecimalResult(firstValue: recognizedResults[index + 1], secondValue: recognizedResults[index + 2]))
                    serologyResults.append(matched)
                    //print("Matched Serology: \(matched.sub), Matched Result \(matched.result)")
                }
            }
        }
        let reducedMicrobiology = matchedMicrobiology.filter { recognizedResults.contains($0) }
        //print("Reduced Microbiology: \(reducedMicrobiology)")
        for index in 0..<recognizedResults.count - 1 {
            let recognizedResult = recognizedResults[index]
            if (!matchedResults.contains(where: {$0 == recognizedResult})) {
                matchedResults.append(recognizedResult)
                if reducedMicrobiology.contains(where: { $0.hasPrefix(recognizedResult) }) {
                    let matched = Matched(main: "Microbiology", sub: recognizedResult, result: checkForDecimalResult(firstValue: recognizedResults[index + 1], secondValue: recognizedResults[index + 2]))
                    microbiologyResults.append(matched)
                    //print("Matched Microbiology: \(matched.sub), Matched Result \(matched.result)")
                }
            }
        }
        let success = true
        completion(success)
    }
    
    func detectResultColumn(firstValue: String, secondValue: String) -> Int {
        if isItNumberOrDecimal(firstValue) {
            return 1
        } else if isItNumberOrDecimal(secondValue) {
            return 2
        } else {
            return 1
        }
    }
    
    func isItNumberOrDecimal(_ stringValue: String) -> Bool {
        let pattern = "\\b[<>]?\\d+(\\.\\d+)?\\b"
        
        do {
            let regex = try NSRegularExpression(pattern: pattern)
            let range = NSRange(location: 0, length: stringValue.utf16.count)
            let matches = regex.firstMatch(in: stringValue, options: [], range: range)
            
            return matches != nil
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }
    
    func checkForDecimalResult(firstValue: String, secondValue: String) -> String {
        if isItNumberOrDecimal(firstValue) {
            return firstValue
        } else if isItNumberOrDecimal(secondValue) {
            return secondValue
        } else {
            if (resultColumn == 1) {
                return firstValue
            } else if (resultColumn == 2) {
                return secondValue
            } else {
                return ""
            }
        }
    }
}

func recognizeTextUsingAzure(url: URL, completion: @escaping ([String]) -> Void) {
    let endpoint = "https://medicalreportextraction.cognitiveservices.azure.com"
    let apiVersion = "2023-07-31"
    let apiKey = "66815bb015484fb39ed60ee6db6ef6eb"

    guard let fileData = try? Data(contentsOf: url) else {
        print("Failed to load file data")
        completion([])
        return
    }

    let base64String = fileData.base64EncodedString()

    guard let apiUrl = URL(string: "\(endpoint)/formrecognizer/documentModels/prebuilt-document:analyze?api-version=\(apiVersion)") else {
        print("Invalid URL")
        completion([])
        return
    }

    var request = URLRequest(url: apiUrl)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")

    let requestBody: [String: Any] = [
        "base64Source": base64String
    ]

    guard let httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: []) else {
        print("Failed to serialize JSON")
        completion([])
        return
    }

    request.httpBody = httpBody

    URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion([])
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            print("No HTTP response received")
            completion([])
            return
        }

        if httpResponse.statusCode != 202 {
            print("HTTP Response Headers: \(httpResponse.allHeaderFields)")
            print("Failed with status code: \(httpResponse.statusCode)")
            completion([])
            return
        }

        guard data != nil else {
            print("No data received")
            completion([])
            return
        }

        // Extract the apim-request-id from the headers
        if let requestId = httpResponse.allHeaderFields["apim-request-id"] as? String {
            print("apim-request-id: \(requestId)")
            // Perform GET request with the requestId
            fetchAnalysisResult(requestId: requestId, endpoint: endpoint, apiKey: apiKey, apiVersion: apiVersion, completion: completion)
        } else {
            print("apim-request-id not found in response headers")
            completion([])
        }
        
        
    }.resume()
}

func fetchAnalysisResult(requestId: String, endpoint: String, apiKey: String, apiVersion: String, completion: @escaping ([String]) -> Void) {
    // Adding delay of 15 seconds before fetching the analysis result
    DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
        guard let resultUrl = URL(string: "\(endpoint)/formrecognizer/documentModels/prebuilt-document/analyzeResults/\(requestId)?api-version=\(apiVersion)") else {
            print("Invalid URL for fetching analysis result")
            completion([])
            return
        }

        var request = URLRequest(url: resultUrl)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching analysis result: \(error.localizedDescription)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received")
                completion([])
                return
            }

            // Print raw data for debugging
            //let responseString = String(data: data, encoding: .utf8) ?? "Failed to convert data to string"
            //print("Raw Response Data: \(responseString)")

            // Parse JSON response
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    //print("Azure response: \(jsonResponse)")

                    var extractedText = ""
                    if let analyzeResult = jsonResponse["analyzeResult"] as? [String: Any],
                       let readResults = analyzeResult["content"] as? String {
                        extractedText = readResults
                        
                    }
                    let newlines = CharacterSet.newlines
                    let recognized = extractedText.components(separatedBy: newlines)

                    completion(recognized)
                } else {
                    print("Failed to parse JSON response")
                    completion([])
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
                completion([])
            }
        }.resume()
    }
}

#Preview {
    HomeView()
}

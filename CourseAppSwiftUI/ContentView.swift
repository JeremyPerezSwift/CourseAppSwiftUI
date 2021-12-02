//
//  ContentView.swift
//  CourseAppSwiftUI
//
//  Created by Jérémy Perez on 01/12/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            CustomTabView()
                .navigationTitle("Test")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CustomTabView: View {
    
    @State var selectedTab = "home"
    @State var edge = UIApplication.shared.windows.first?.safeAreaInsets
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            
            TabView(selection: $selectedTab) {
                Home()
                    .tag("home")
                
                EmailView()
                    .tag("email")
                
                FolderView()
                    .tag("folder")
                
                SettingsView()
                    .tag("gear")
            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea(.all, edges: .bottom)
            
            HStack(spacing: 0) {
                
                ForEach(tabs, id: \.self) { image in
                    
                    TabButton(image: image, selectTab: $selectedTab)
                    
                    if image != tabs.last {
                        Spacer(minLength: 0)
                    }
                    
                }
                
            }
            .padding(.horizontal, 25)
            .padding(.vertical, 5)
            .background(Color.white)
            .clipShape(Capsule())
            .padding(.horizontal)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: 5, y: 5)
            .shadow(color: Color.black.opacity(0.15), radius: 5, x: -5, y: -5)
//            .padding(.bottom, edge!.bottom == 0 ? 20 : 0)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        
    }
    
}

var tabs = ["home", "email", "folder", "gear"]

struct TabButton: View {
    
    var image: String
    @Binding var selectTab: String
    
    var body: some View {
        
        Button(action: { selectTab = image }) {
            Image(image)
                .renderingMode(.template)
                .foregroundColor(selectTab == image ? Color.black : Color.black.opacity(0.4))
                .padding()
        }
        
    }
    
}

struct Home: View {
    @State var txt = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text("Hello Carlos")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Let's upgrade your skill")
                }
                .foregroundColor(.black)
                
                Spacer(minLength: 0)
                
                Button(action: {}) {
                    Image("profile")
                        .resizable()
                        .renderingMode(.original)
                        .frame(width: 50, height: 50)
                }
            }
            .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    
                    HStack(spacing: 15) {
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        
                        TextField("Search Courses", text: $txt)
                        
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal)
                    .background(Color.white)
                    .clipShape(Capsule())
                    
                    HStack {
                        Text("Categoris")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 0)
                        
                        Button(action: {}) {
                            Text("View All")
                        }
                    }
                    .foregroundColor(.black)
                    .padding(.top, 25)
                    
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                        ForEach(courses) { course in
                            
                            NavigationLink(destination: DetailView(course: course)) {
                                CourseCardView(course: course)
                            }
                            
                        }
                    }
                    .padding(.top)
                    
                }
                .padding()
            }
        }
        .background(Color.black.opacity(0.03).ignoresSafeArea(.all, edges: .all))
    }
}

struct CourseCardView: View {
    var course: Course
    
    var body: some View {
        
        VStack {
            VStack {
                
                Image(course.asset)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, 10)
                    .padding(.leading, 10)
                    .background(Color(course.asset))
                
                HStack {
                    VStack(alignment: .leading, spacing: 22) {
                        Text(course.name)
                            .font(.title3)
                        
                        Text("\(course.numCourse) Courses")
                    }
                    .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                
            }
            .background(Color.white)
            .cornerRadius(15)
            
            Spacer(minLength: 0)
        }
    }
}

struct EmailView: View {
    
    var body: some View {
        
        VStack {
            Text("Email")
        }
        .background(Color.black.opacity(0.03).ignoresSafeArea(.all, edges: .all))
        
    }
}

struct FolderView: View {
    
    var body: some View {
        
        VStack {
            Text("Folder")
        }
        .background(Color.black.opacity(0.03).ignoresSafeArea(.all, edges: .all))
        
    }
}

struct SettingsView: View {
    
    var body: some View {
        
        VStack {
            Text("Settings")
        }
        .background(Color.black.opacity(0.03).ignoresSafeArea(.all, edges: .all))
        
    }
}

// Model Data

struct Course: Identifiable {
    var id = UUID().uuidString
    var name: String
    var numCourse: Int
    var asset: String
}

var courses = [
    Course(name: "Undraw_1", numCourse: 12, asset: "undraw_1"),
    Course(name: "Undraw_2", numCourse: 12, asset: "undraw_2"),
    Course(name: "Undraw_3", numCourse: 12, asset: "undraw_3"),
    Course(name: "Undraw_4", numCourse: 12, asset: "undraw_4"),
    Course(name: "Undraw_5", numCourse: 12, asset: "undraw_5")
]


struct DetailView: View {
    
    var course: Course
    
    var body: some View {
        
        VStack {
            Text(course.name)
                .font(.title2)
                .fontWeight(.bold)
        }
        .navigationTitle(course.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
    
}

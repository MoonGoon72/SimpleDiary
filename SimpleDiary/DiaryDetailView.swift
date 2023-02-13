import SwiftUI

struct DiaryDetailView: View {
    @State var diary:DiaryModel
    @State var isEditMode:Bool = false
    @State var contents:String = ""
    
    func getImageName() -> String {
        if let weather = diary.weather {
            return "weather." + weather.rawValue
        }
        
        return "weather.cloudy"
    }
    
    var weatherImage: some View {
        GeometryReader { _ in
            Image(getImageName())
                .resizable()
                .scaledToFill()
                .clipped()
        }
    }
    
    
    func getStateList() -> Array<String> {
        if let state = diary.state {
            return Array(repeating: "star.fill", count: state.rawValue)
        }
        return Array()
    }
    
    var diaryHead: some View {
        HStack {
            Text(diary.keyDateString())
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
            Spacer()
            HStack(spacing: 0) {
                ForEach(getStateList(), id: \.self) { imageName in
                    Image(systemName: imageName)
                        .imageScale(.medium)
                        .foregroundColor(.red)
                }
            }
        }
    }
    
    var bottomButtons: some View {
        HStack {
            Spacer()
            Button {
                if let content = diary.contents {
                    self.contents = content
                }
                modeChange()
            } label: {
                HStack {
                    Image(systemName: "trash")
                    Text("취소")
                        .fontWeight(.semibold)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(40)
            }
            Button {
                diary.contents = self.contents
                self.isEditMode = !DiaryDataManager.shared.saveDiary(Diary:self.diary)
                self.contents = ""
            } label: {
                HStack {
                    Image(systemName: "pencil.circle")
                    Text("수정 완료")
                        .fontWeight(.semibold)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.green)
                .cornerRadius(40)
            }
        }
        .opacity(isEditMode ? 1 : 0)
        .padding()
    }
    
    var body: some View {
        ZStack {
            weatherImage
            
            GeometryReader { geo in
                VStack(spacing: 0) {
                    Spacer()
                    diaryContents
                        .frame(height: geo.size.height * 0.67)
                }
            }
            
            VStack {
                Spacer()
                bottomButtons
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    var diaryContents: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                diaryHead
                diaryTitle
                Text("")
                diaryDescription
                Spacer()
            }
            .frame(height: $0.size.height + 10)
            .padding()
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        }
        .onTapGesture(count: 2) {
            modeChange()
        }
    }
    func modeChange() {
        if let content = diary.contents {
            self.contents = content
        }
        
        self.isEditMode.toggle()
    }
    
    var diaryTitle: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(diary.title)
                    .font(.largeTitle)
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                Spacer()
            }
        }
    }
    
    var diaryDescription: some View {
        ScrollView {
            if (isEditMode == false) {
                Text(getDiaryContents())
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            else {
                TextField("일기 내용", text: $contents, axis: .vertical)
            }
            
        }
    }
    
    func getDiaryContents() -> String {
        var text = "일기 내용입니다."
        if let contents = diary.contents {
            text = contents
        }
        return text
    }
    
    
    
}

struct DiaryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryDetailView(diary: DiaryModel(keyDate: Date(), title: "한줄 일기", feeling: .happy, state: .good))
    }
}

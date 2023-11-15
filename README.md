# Weathers

## Goal
- Weather Open API, Combine framework 이용해서 가볍게 서버 통신 구현해보기

## Branch
```
weather-[본인 이름]
```
- 브랜치파서 작업 후에 PR 올려놓으면 다른 팀원들은 가볍게 확인 후 Emoji나 Comment 남겨주기

## Get Started
```
enum APIEnvironment {
  static let Key = "ENTER_YOUR_API_KEY"
}
```
- `Network/` > `APIEnvironment.swift` > `Key`로 이동하세요.
- `https://www.weatherapi.com/`에서 API KEY를 발급받아 넣어서 시작하세요.

## Combine

### 👍 Strong points

```
1. 가독성이 좋음 (= 코드의 흐름 파악이 좋음)
2. 코드를 중앙 집중화해서 관리할 수 있음
3. 다양한 연산자의 사용으로 데이터를 쉽게 가공할 수 있음
```

### 🛜 Network Calls

#### 1. 네트워크 요청 수행 시 장점
네트워크 통신 과정에서 발생하는 여러 작업을 하나의 파이프라인으로 구성해서 코드를 작성할 수 있다는 점이 장점인 것 같습니다:
```
- mapping
- decoding
- error propagation, error handling
- ...
```

<br />

#### 2. 네트워크 요청 병렬적 수행
```swift
isLoading = true
let publishers = ["Seoul", "London", "Tokyo", "Los Angeles", "Berlin"].map(weatherWorker.fetchCurrentWeatherData)

Publishers.MergeMany(publishers)
  .collect()
  .receive(on: RunLoop.main)
  .sink { [weak self] completion in
    self?.isLoading = false
  } receiveValue: { [weak self] results in
    self?.weathers = results
  }
  .store(in: &cancellables)
```
- 여러 API 요청을 병렬적으로 수행하고 싶을 때, Merge or MergeMany Publisher를 사용할 수 있습니다.
- collect 연산자는 upstream publisher에서 방출한 데이터를 배열의 형태로 모아줍니다.

<br />

#### 3. 네트워크 요청 순차적 실행
다중 요청을 순차적으로 실행하고 싶다면 Sequence Publisher를 사용할 수 있습니다.

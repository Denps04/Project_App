# Setup

새 사람이 `git clone` 후 **5분 안에 실행**할 수 있도록 작성된 문서입니다.

---

## 1. 사전 요구 도구

| 도구 | 권장 버전 | 확인 명령 |
|---|---|---|
| Git | 2.40+ | `git --version` |
| Flutter SDK | 3.19+ | `flutter --version` |
| Dart | 3.3+ (Flutter에 포함) | `dart --version` |
| Android Studio | 2023.x+ | 설치 후 실행 확인 |
| VS Code | 최신 | 선택 사항 (편집기) |

> **Flutter SDK에 Dart가 포함되어 있습니다.** Dart를 별도로 설치할 필요 없습니다.

---

## 2. Flutter SDK 설치

### Windows

```powershell
# winget으로 설치
winget install Google.Flutter
```

설치 후 환경 변수 PATH에 Flutter bin 경로 추가:
```
C:\flutter\bin
```

확인:
```powershell
flutter doctor
```

### macOS

```bash
# Homebrew로 설치
brew install --cask flutter
```

확인:
```bash
flutter doctor
```

### Linux (Ubuntu)

```bash
sudo snap install flutter --classic
```

확인:
```bash
flutter doctor
```

---

## 3. Android 에뮬레이터 설정

Android Studio를 실행한 후 아래 순서로 설정합니다.

```
Android Studio 실행
→ More Actions (또는 Tools 메뉴)
→ Virtual Device Manager
→ Create Device
→ Pixel 7 (권장) 선택
→ API Level 34 (Android 14) 이미지 다운로드
→ Finish
```

에뮬레이터 실행 확인:
```bash
flutter emulators --launch [에뮬레이터 이름]
```

---

## 4. VS Code 확장 설치 (선택)

VS Code를 사용하는 경우 아래 확장을 설치합니다.

```
확장 탭 (Ctrl+Shift+X) 검색:
- Flutter  (Dart Code 작성자)
- Dart     (Dart Code 작성자)
```

---

## 5. 프로젝트 클론

```bash
git clone https://github.com/[user]/[repo].git
cd [repo]
```

> `[user]`와 `[repo]`는 실제 GitHub 주소로 변경하세요.

---

## 6. 의존성 설치

```bash
flutter pub get
```

성공 시 터미널에 아래와 유사한 메시지가 출력됩니다:
```
Resolving dependencies...
Got dependencies!
```

---

## 7. 환경 변수

이 프로젝트는 **로컬 저장소(Hive)만 사용**하므로 별도의 API 키나 `.env` 파일이 필요하지 않습니다.

> 추후 외부 API 연동이 추가될 경우 이 항목을 업데이트합니다.

---

## 8. 첫 실행

에뮬레이터 또는 실기기를 연결한 상태에서:

```bash
flutter run
```

실기기(Android) 연결 시 USB 디버깅을 활성화해야 합니다:
```
설정 → 개발자 옵션 → USB 디버깅 ON
```

**성공 시**: 홈 화면이 표시되며 "오늘의 수업", "마감 임박 과제" 섹션이 보입니다.

---

## 9. 빌드 명령

### 개발용 실행
```bash
flutter run
```

### Android APK 빌드 (테스트용)
```bash
flutter build apk --debug
```

결과물 위치: `build/app/outputs/flutter-apk/app-debug.apk`

### Android APK 빌드 (배포용)
```bash
flutter build apk --release
```

### iOS 빌드 (macOS 필요)
```bash
flutter build ios --release
```

---

## 10. 테스트 실행

```bash
# 전체 테스트 실행
flutter test

# 특정 파일만 실행
flutter test test/domain/calculate_gpa_test.dart
```

---

## 11. 자주 발생하는 문제

### Q1. `flutter` 명령어를 찾을 수 없어요 (command not found)
→ Flutter SDK가 PATH에 등록되지 않은 것입니다.
→ Windows: 시스템 환경 변수 → Path → `C:\flutter\bin` 추가 후 터미널 재시작
→ macOS/Linux: `~/.zshrc` 또는 `~/.bashrc`에 아래 줄 추가 후 재시작
```bash
export PATH="$PATH:[flutter 설치 경로]/bin"
```

### Q2. `flutter doctor`에서 경고가 떠요
→ 모든 항목이 ✅일 필요는 없습니다.
→ **Flutter**, **Android toolchain**, **Connected device** 세 항목만 ✅이면 실행 가능합니다.
→ Xcode 관련 경고는 iOS 빌드가 필요 없으면 무시해도 됩니다.

### Q3. 에뮬레이터가 실행되지 않아요
→ Android Studio → Virtual Device Manager에서 에뮬레이터가 생성되어 있는지 확인하세요.
→ BIOS에서 가상화(Virtualization) 옵션이 활성화되어 있어야 합니다.
→ Windows: BIOS → Intel VT-x 또는 AMD-V 활성화

### Q4. `flutter pub get` 실행 시 오류가 나요
→ Flutter SDK 버전이 낮을 수 있습니다. 아래 명령으로 업그레이드하세요:
```bash
flutter upgrade
```

### Q5. Android Gradle 동기화 실패
→ 아래 명령으로 빌드 캐시를 초기화한 후 다시 시도하세요:
```bash
flutter clean
flutter pub get
flutter run
```

---

## 12. 실행 성공 확인 기준

아래 항목이 모두 확인되면 정상입니다.

- [ ] 홈 화면이 표시된다
- [ ] 시간표 화면에서 과목을 추가할 수 있다
- [ ] 과제 메모 화면에서 과제를 등록하고 완료 체크가 된다
- [ ] 결석 계산기에서 결석 횟수가 한도에 따라 색상이 바뀐다
- [ ] 학점 계산기에서 GPA가 자동으로 계산된다

---

## 관련 문서

- `docs/ADR-0001-platform-selection.md` — Flutter 선택 근거
- `docs/architecture.md` — 전체 아키텍처 설계

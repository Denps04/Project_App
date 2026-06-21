# ADR-0001: 모바일 플랫폼 선택

- **상태**: 확정 (Accepted)
- **날짜**: 2025-06-02
- **작성자**: 이준오

---

## Context (배경)

대학생 올인원 학사 관리 앱을 개발한다.
주요 기능은 시간표, 학사일정, 결석 계산기, 학점 계산기, 과제 메모이며
7주 안에 완성하여 발표해야 한다.

- 개발 인원: 1인
- 개발 기간: 1주
- 목표 OS: Android + iOS 모두
- 개발자 경험: 모바일 개발 초급

---

## Decision (결정)

**Flutter (Dart)** 를 선택한다.

---

## Alternatives (비교한 대안)

| 항목 | Flutter | React Native (Expo) | Android (Kotlin) |
|---|---|---|---|
| iOS/Android 동시 지원 | ✅ | ✅ | ❌ |
| 초급자 진입 난이도 | 낮음 | 보통 | 높음 |
| 개발 속도 | 빠름 (Hot Reload) | 보통 | 느림 |
| AI 학습 데이터 | 많음 | 많음 | 보통 |
| 서버 없이 로컬 저장 | ✅ (Hive) | ✅ | ✅ |
| 상태관리 | Riverpod | Zustand | ViewModel + StateFlow |

---

## Consequences (결과 및 트레이드오프)

**장점**
- iOS/Android를 단일 코드베이스로 개발 → 1인 개발에 최적
- Hot Reload로 UI 수정이 빠름
- Riverpod + Hive 조합으로 서버 없이 로컬 저장 가능
- AI Agent(Claude 등)의 Flutter 학습 데이터가 풍부하여 도움받기 좋음

**단점 / 감수하는 것**
- Dart 언어를 새로 배워야 함
- 네이티브 기능(카메라, 알림 등)을 깊게 다룰 경우 별도 플러그인 필요
- npm 생태계보다 패키지 수가 적음

**감수 이유**
이번 프로젝트는 로컬 저장 기반의 화면 위주 앱이므로
네이티브 깊은 기능이 필요하지 않다.
7주 내 완성과 발표 품질이 최우선이므로 Flutter가 최선의 선택이다.

---

## 60초 발표 요약

> "저희는 Flutter를 선택했습니다.
> 이유는 세 가지입니다.
> 첫째, iOS와 Android를 동시에 개발할 수 있어 1인 개발에 적합합니다.
> 둘째, Hot Reload 덕분에 UI 수정이 빠르고 개발 속도가 높습니다.
> 셋째, AI 도구의 Flutter 지원이 풍부해 초급자도 도움받기 좋습니다.
> React Native도 고려했지만, Dart 학습 비용보다
> 단일 코드베이스의 이점이 더 크다고 판단했습니다."

---

## 관련 문서

- `docs/architecture.md` — 전체 아키텍처 설계
- `docs/setup.md` — Flutter 환경 설정 가이드

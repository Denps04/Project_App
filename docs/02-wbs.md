# 02 — WBS (Work Breakdown Structure)

> 산출물 명사형으로 기술. 각 항목은 1~3일 단위.

---

## 1. 기획 & 설계

- 1.1 비전 문서 (`00-vision.md`)
- 1.2 요구사항 문서 (`01-requirements.md`)
- 1.3 WBS 문서 (`02-wbs.md`)
- 1.4 일정 문서 (`04-schedule.md`)
- 1.5 ADR-0001 — Flutter 플랫폼 선택 근거
- 1.6 ADR-0002 — Riverpod 상태관리 선택 근거
- 1.7 ADR-0003 — Hive 로컬 저장소 선택 근거

## 2. 환경 구축

- 2.1 GitHub 저장소 생성 + `.gitignore`
- 2.2 Flutter 프로젝트 생성 (`flutter create`)
- 2.3 `pubspec.yaml` 의존성 설정
- 2.4 디렉토리 구조 (4계층 Layered)
- 2.5 `CLAUDE.md` 프로젝트 규칙 파일
- 2.6 Hello World 빌드 성공 + Push
- 2.7 `docs/setup.md` 작성
- 2.8 `docs/architecture.md` + Mermaid 다이어그램

## 3. 디자인 시스템

- 3.1 앱 테마 (`app_theme.dart`) — Material 3, 인디고
- 3.2 색상 상수 (`app_colors.dart`)
- 3.3 공통 위젯 — AppCard, SectionHeader, EmptyState
- 3.4 메인 네비게이션 구조 (6탭)

## 4. Domain & Data 레이어

- 4.1 Entity 5개 — Course, Task, AcademicSchedule, Attendance, Grade
- 4.2 Hive Adapter 자동 생성 (`build_runner`)
- 4.3 UseCase 3개 — GPA 계산, 결석 한도, 마감 임박 과제
- 4.4 Repository 5개 — Hive 기반 CRUD

## 5. 화면 구현

- 5.1 홈 화면 — 오늘 수업 + 임박 과제 + 이번 주 일정
- 5.2 시간표 화면 — 요일 탭, 과목 등록 BottomSheet
- 5.3 학사일정 화면 — TableCalendar, 일정 등록
- 5.4 결석 계산기 화면 — 한도 경고, 출결 기록
- 5.5 학점 계산기 화면 — GPA 카드, 학기별 필터
- 5.6 과제 메모 화면 — 완료/미완료 탭, D-Day

## 6. 테스트 & 검수

- 6.1 GPA 계산 단위 테스트
- 6.2 결석 한도 계산 단위 테스트
- 6.3 마감 임박 과제 조회 단위 테스트
- 6.4 `flutter analyze` 경고 0개
- 6.5 `flutter build apk --debug` 성공

## 7. 발표 준비

- 7.1 데모 시나리오 3개 작성
- 7.2 발표 슬라이드 (웹 HTML)
- 7.3 데모 영상 30초 녹화 (백업)
- 7.4 Q&A 31개 답변 준비

---

## 기능별 레이어 흐름 요약

| 기능 | Presentation | Application | Domain | Data |
|---|---|---|---|---|
| 시간표 등록 | TimetableScreen | TimetableViewModel | Course | HiveCourseRepository |
| 결석 계산 | AttendanceScreen | AttendanceViewModel | CalculateAttendanceLimit | HiveAttendanceRepository |
| GPA 계산 | GradeScreen | GradeViewModel | CalculateGpa | HiveGradeRepository |
| 과제 조회 | TaskScreen | TaskViewModel | GetUpcomingTasks | HiveTaskRepository |
| 학사일정 | CalendarScreen | CalendarViewModel | AcademicSchedule | HiveScheduleRepository |

// [Application] - 학점 상태 관리 ViewModel
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/hive_grade_repository.dart';
import '../domain/entities/grade.dart';
import '../domain/usecases/calculate_gpa.dart';

final gradeViewModelProvider =
    StateNotifierProvider<GradeViewModel, List<Grade>>((ref) {
      return GradeViewModel();
    });

class GradeViewModel extends StateNotifier<List<Grade>> {
  GradeViewModel() : super([]) {
    load();
  }

  final _repo = HiveGradeRepository();
  final _calculateGpa = CalculateGpa();
  static const String _seedMarkerId = 'seed-2023-1-01';
  static const String _seed2023Semester2MarkerId = 'seed-2023-2-01';

  Future<void> load() async {
    final marker = await _repo.getById(_seedMarkerId);
    if (marker == null) {
      await _seedTranscriptGrades();
    }

    await _ensure2023Semester2Seed();
    await _upgradeDGradesToBRange();
    state = await _repo.getAll();
  }

  Future<void> add(Grade grade) async {
    await _repo.add(grade);
    await load();
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    await load();
  }

  // 전체 GPA 계산
  GpaResult get totalGpa => _calculateGpa(state);

  // 특정 학기 GPA 계산
  GpaResult gpaForSemester(String semester) {
    final filtered = state.where((g) => g.semester == semester).toList();
    return _calculateGpa(filtered);
  }

  // 등록된 학기 목록 (중복 제거, 최신 순)
  List<String> get semesters {
    final set = state.map((g) => g.semester).toSet().toList();
    set.sort((a, b) => b.compareTo(a));
    return set;
  }

  Future<void> _seedTranscriptGrades() async {
    final seeds = <Grade>[
      // 2023-1
      Grade(
        id: 'seed-2023-1-01',
        courseName: '생활영어(I)',
        credit: 2,
        letter: GradeLetter.bPlus,
        semester: '2023-1',
      ),
      Grade(
        id: 'seed-2023-1-02',
        courseName: '프로그래밍이해',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2023-1',
      ),
      Grade(
        id: 'seed-2023-1-03',
        courseName: 'HTML/CSS',
        credit: 3,
        letter: GradeLetter.c,
        semester: '2023-1',
      ),
      Grade(
        id: 'seed-2023-1-04',
        courseName: '컴퓨터이해',
        credit: 3,
        letter: GradeLetter.c,
        semester: '2023-1',
      ),
      Grade(
        id: 'seed-2023-1-05',
        courseName: '정보처리',
        credit: 3,
        letter: GradeLetter.f,
        semester: '2023-1',
      ),
      Grade(
        id: 'seed-2023-1-06',
        courseName: '웹분석과기획',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2023-1',
      ),

      // 2025-1
      Grade(
        id: 'seed-2025-1-01',
        courseName: '생활영어(III)',
        credit: 2,
        letter: GradeLetter.b,
        semester: '2025-1',
      ),
      Grade(
        id: 'seed-2025-1-02',
        courseName: '웹프로그래밍',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2025-1',
      ),
      Grade(
        id: 'seed-2025-1-03',
        courseName: '데이터베이스활용',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2025-1',
      ),
      Grade(
        id: 'seed-2025-1-04',
        courseName: '리눅스실습',
        credit: 3,
        letter: GradeLetter.f,
        semester: '2025-1',
      ),
      Grade(
        id: 'seed-2025-1-05',
        courseName: 'JAVA프로그래밍기초',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2025-1',
      ),
      Grade(
        id: 'seed-2025-1-06',
        courseName: '마이크로프로세서활용',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2025-1',
      ),
      Grade(
        id: 'seed-2025-1-07',
        courseName: '자바스크립트응용',
        credit: 3,
        letter: GradeLetter.bPlus,
        semester: '2025-1',
      ),
      Grade(
        id: 'seed-2025-1-08',
        courseName: '포토그래피',
        credit: 2,
        letter: GradeLetter.b,
        semester: '2025-1',
      ),

      // 2025-2
      Grade(
        id: 'seed-2025-2-01',
        courseName: '생활영어(IV)',
        credit: 2,
        letter: GradeLetter.bPlus,
        semester: '2025-2',
      ),
      Grade(
        id: 'seed-2025-2-02',
        courseName: 'Python프로그래밍',
        credit: 3,
        letter: GradeLetter.bPlus,
        semester: '2025-2',
      ),
      Grade(
        id: 'seed-2025-2-03',
        courseName: 'JAVA프로그래밍응용',
        credit: 3,
        letter: GradeLetter.bPlus,
        semester: '2025-2',
      ),
      Grade(
        id: 'seed-2025-2-04',
        courseName: '앱프로그래밍기초',
        credit: 3,
        letter: GradeLetter.bPlus,
        semester: '2025-2',
      ),
      Grade(
        id: 'seed-2025-2-05',
        courseName: '모바일UI/UX디자인',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2025-2',
      ),
      Grade(
        id: 'seed-2025-2-06',
        courseName: '웹자바프로그래밍입문',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2025-2',
      ),
      Grade(
        id: 'seed-2025-2-07',
        courseName: '프로젝트분석설계(캡스톤디자인)',
        credit: 4,
        letter: GradeLetter.bPlus,
        semester: '2025-2',
      ),
    ];

    for (final grade in seeds) {
      await _repo.add(grade);
    }
  }

  Future<void> _ensure2023Semester2Seed() async {
    final marker = await _repo.getById(_seed2023Semester2MarkerId);
    if (marker != null) return;

    // Requested: ignore original F entries and fill manually with random A/B/C letters.
    final semester2023_2 = <Grade>[
      Grade(
        id: 'seed-2023-2-01',
        courseName: '생활영어(II)',
        credit: 2,
        letter: GradeLetter.b,
        semester: '2023-2',
      ),
      Grade(
        id: 'seed-2023-2-02',
        courseName: '데이터베이스입문',
        credit: 3,
        letter: GradeLetter.c,
        semester: '2023-2',
      ),
      Grade(
        id: 'seed-2023-2-03',
        courseName: 'C프로그래밍',
        credit: 3,
        letter: GradeLetter.a,
        semester: '2023-2',
      ),
      Grade(
        id: 'seed-2023-2-04',
        courseName: '자바스크립트기초',
        credit: 3,
        letter: GradeLetter.b,
        semester: '2023-2',
      ),
      Grade(
        id: 'seed-2023-2-05',
        courseName: '마이크로프로세서입문',
        credit: 3,
        letter: GradeLetter.c,
        semester: '2023-2',
      ),
      Grade(
        id: 'seed-2023-2-06',
        courseName: '모바일UI/UX디자인',
        credit: 3,
        letter: GradeLetter.a,
        semester: '2023-2',
      ),
      Grade(
        id: 'seed-2023-2-07',
        courseName: '셀프디자인(자기개발성공전략)',
        credit: 2,
        letter: GradeLetter.b,
        semester: '2023-2',
      ),
    ];

    for (final grade in semester2023_2) {
      await _repo.add(grade);
    }
  }

  Future<void> _upgradeDGradesToBRange() async {
    final grades = await _repo.getAll();
    for (final grade in grades) {
      if (grade.letter == GradeLetter.dPlus) {
        grade.letter = GradeLetter.bPlus;
        await _repo.add(grade);
      } else if (grade.letter == GradeLetter.d) {
        grade.letter = GradeLetter.b;
        await _repo.add(grade);
      }
    }
  }
}

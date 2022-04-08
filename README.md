# Gamer_mini

# 목차

1. [Gamer Git 커밋 & Pull Request 컨벤션](#Gamer-git-커밋--pull-request-컨벤션)
2. [Gamer 브랜치 규칙](#Gamer-브랜치-규칙)


## Gamer Git 커밋 & Pull Request 컨벤션
  
### Summary

```kotlin
type(옵션):[#issueNumber]Subject //-> 제목
개행
body(옵션):// ->본문
개행
footer(옵션)://-> 꼬리말
```

### 커밋 작성 방법
[태그]: 내용 #이슈번호


### 제목 작성 방법

타입은 **태그**와 **제목**으로 구성되며, **태그**는 영어로 쓰되 첫 문자는 대문자로 한다.

“태그: 제목” 의 형태이며, : 뒤에만 공백이 들어간다.

**태그**

| 태그 이름  | 설명 |
| --- | --- |
| Feat | 새로운 기능을 추가 |
| Fix | 버그를 고친 경우 |
| Design | 사용자 UI 디자인 변경 |
| !BREAKING CHANGE | 커다란 API 의 변경 |
| !HOTFIX | 급하게 치명적인 버그를 고쳐야하는 경우 |
| Style | 코드 포맷 변경, 세미 클론 누락 (오타 수정, 탭 사이즈 변경, 변수명 변경) |
| Refactor | 프로덕션 코드 리팩토링 |
| Comment | 필요한 주석 추가 및 변경 |
| Docs | 문서 수정 |
| Test | 테스트 추가, 테스트 리팩토링 (프로덕션 코드 변경 X) |
| Chore | 빌드 테스트 업데이트, 패키지 매니저를 설정 |
| Rename | 파일 혹은 폴더명을 수정하거나 옮기는 작업만인 경우 |
| Remove | 파일을 삭제하는 작업만 수행한 경우 |

#### 제목의 작성 방법

1. 제목의 처음은 동사 원형으로 시작한다.<br>
2. 총 글자 수는 50자 이내로 작성<br>
3. 마지막에 특수문자는 삽입하지 않는다<br>
4. 제목은 **개조식 구문**으로 작성

영어로 작성하는 경우

- 첫 글자는 **대문자**로 시작
- **Fix, Add, Change** 의 명령어로 시작

한글로 작성하는 경우

- **고침, 추가, 변경** 의 명령어로 시작

예시 - Feat: 추가 login api

### 본문 작성 방법

- 본문은 **한 줄당 72자 내**로 작성
- 양에 구애받지 않고 **최대한 상세히 작성**
- **무엇을 왜 변경했는지 설명**

### 꼬리말 작성 방법

- 꼬리말은 선택이고 이슈 트래커 ID 를 작성한다
- 꼬리말은 “유형: #이슈 번호” 형식으로 사용
- 여러 개의 이슈 번호를 적을 때는 쉼표로 구분
- 이슈 트래커 유형은 다음 중 하나를 사용
    - Fixes: 이슈 수정중
    - Resolves: 이슈 해결함
    - Ref: 참고할 이슈
    - Related to: 해당 커밋에 관련된 이슈번호
- ex) Fixes: #45 Related to: #34, #23

### 예시

```kotlin
Feat: "userdefaults에 스트레스, 보상 데이터 넣기"

stress struct와 reward struct 생성
userdefaults의 키값을 각각 stressArray ㄹ 설정

Resolves: #12
Ref: #5
Related to: #1, #2
```
## Gamer 브랜치 규칙

```kotlin
이름

예시)
Goban

```

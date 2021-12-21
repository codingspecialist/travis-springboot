![blog](https://postfiles.pstatic.net/MjAyMTEyMjFfNDIg/MDAxNjQwMDc3ODQ1NjI3.E2EKQ8_xdv7Woclhq5nerAwC0815DtbkTXLhIraIqwEg.swSqKiM0n-ZRWQSTFfjzdfYhT-3muMwmx24dDZSSRzwg.PNG.getinthere/Screenshot_18.png?type=w773)

### 실행 흐름
- github 코드 배포
- travis에서 낚아채서 (테스트, 빌드 후 zip파일로 묶기)
- s3에 zip 파일 배포
- codedeploy에서 zip파일 낚아채서 ec2에 배포 (자동으로 압축 풀림)
- 배포된 파일에 build/libs/*.jar 파일을 복사해서 실행(실행전 이전에 실행된 pid 강제 종료)

### EC2 인스턴스 생성
- 태그명 만들어주기 (Name: 프로젝트명)
- 위 태그명을 나중에 codedeploy에서 그룹 배포시 참고해야 한다.

### IAM 사용자 설정 (외부 프로그램에서 접근할 때)
- AmazonS3FullAccess
- AWSCodeDeployFullAccess

### IAM 역할 설정 (내부 프로그램에서 접근할 때)
- AWSCodeDeployRole   - CodeDeploy 역할
- AmazonEC2RoleforAWS - EC2 역할

### CI/CD 배포시 주의할점
- ec2의 태그명과 codedeploy의 배포그룹 설정시 태그명이 일치하기만 하면 된다.
- S3에 배포시에 코드 전체를 배포하는게 아니라 배포전에 zip파일로 압축해서 던진다.
- zip파일로 압축해서 던진 파일을 codedeploy하게 되면 bundle_type에 맞게 자동으로 압축이 풀려서 배포된다.(새로운 기능)
- 최종 배포 후 jar파일 실행할 때 입출력 재지정 하지 않으면 stdout 익셉션발생

```gradle
// plain.jar 파일 생기지 않게 처리하기
jar {
	enabled = false 
}
```
본 폴더는 SouP 서비스에서 xingAPI 연동을 담당하는 서버 코드입니다.

본 Docker Container는 AWS ECS에서 구동되고 있습니다.

Container Image를 AWS ECR에 자동 배포해주고 ECS에 적용하는 CI/CD 작업은 현재 되어있지 않음으로, 추후 서비스의 실제 출시시에는 관련 작업이 필요합니다.

Docker Container를 배포할 시에는 현재 Github에 올라와 있지않은 'xingapi_library.zip'를 개인적으로 개발자에게 전달받은 후 프로젝트 폴더에 넣어주어야 합니다.
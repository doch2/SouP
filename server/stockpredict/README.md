본 폴더는 SouP 서비스에서 주가 급등 예측을 담당하는 서버 코드입니다.

Python 코드는 AWS Lambda에서 구동되고 있으며, 인공지능 모델 파일은 Firebase Storage에 업로드되어 있습니다.

파이썬 코드를 AWS Lambda에 자동 배포해주는 CI/CD 작업은 현재 되어있지 않음으로, 추후 서비스의 실제 출시시에는 관련 작업이 필요합니다. Docker Image 제작시에 ARM 환경에서는 정상적으로 빌드가 되지 않으니 빌드 시에 참고해주세요.

AWS Lambda에 파이썬 코드를 배포할 시에는 현재 Github에 올라와 있지않은 'url.env'를 개인적으로 개발자에게 전달받은 후 이를 이용하여 파이썬 코드 상단에 있는 modelDownloadUrl 변수를 초기화해주어야 합니다.
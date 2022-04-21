FROM public.ecr.aws/amazonlinux/amazonlinux:latest

RUN yum update -y

RUN amazon-linux-extras install python3.8 -y

RUN yum install -y python38-devel
RUN pip3.8 install --upgrade pip

COPY requirements.txt  /
RUN python3.8 -m pip install -r requirements.txt

COPY soup-5b5a0-firebase-adminsdk-y0okj-0544671e41.json /

COPY app.py /

CMD [ "python3.8", "app.py" ]
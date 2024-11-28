FROM dart:stable-sdk AS build
WORKDIR /app

ENV PATH="${PATH}:/root/.pub-cache/bin"
RUN dart pub global activate webdev

ADD pubspec.yaml pubspec.yaml
RUN dart pub get

ADD web/ web/
RUN webdev build --output web:build

FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
COPY bridgebuilder.db /usr/share/nginx/html
RUN apk update && \
    apk add python3 py3-pip && \
    apk add sqlite

RUN pip install Flask flask_login flask_session Flask-RESTful flasgger flask_cors

EXPOSE 80

CMD ["python", "/usr/share/nginx/html/rest.py"]

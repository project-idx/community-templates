import flask
import functions_framework

@functions_framework.http
def my_cloud_function(request: flask.Request) -> flask.typing.ResponseReturnValue:
    return "Hello world!"

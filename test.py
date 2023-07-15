from app import app


def test_my_app():
    response = app.test_client().get('/')
    assert response.status_code == 200
    assert response.data == b'Simple Flask app'

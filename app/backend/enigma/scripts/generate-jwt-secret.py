import os
import base64
import re

ENV_FILE_PATH = "../.env"

def generate_key():
    return base64.urlsafe_b64encode(os.urandom(32)).decode('utf-8')


def update_key_in_env(key):
    with open(ENV_FILE_PATH, 'r') as file:
        content = file.read()

    content = re.sub(r'(JWT_SECRET=)[^\n]*', f'\g<1>{key}', content)

    with open(ENV_FILE_PATH, 'w') as file:
        file.write(content)


if __name__ == '__main__':
    key = generate_key()
    update_key_in_env(key)
    print(f'Key updated in .env: {key}')

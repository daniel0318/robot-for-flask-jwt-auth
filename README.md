# robot-for-flask-jwt-auth
Some test cases using robot framework to test jwt-token authentication API

## Reference
1. [server API] https://github.com/realpython/flask-jwt-auth
2. [robot framework restAPI library] https://github.com/asyrjasalo/RESTinstance

## Test Suites
source.robot:
    - Contain Variables and shared Keywords
    
1. valid_api.robot
    - positive testing for 4 route APIs
    - workflow tests
    
2. invalid_login.robot
    - negative testing for login
    - data-driven tests
    
3. token_timeout.robot
    - positive and negative testing related to whether token expires
    - workflow tests
### Generated Results
- [report.html](https://daniel0318.github.io/robot-for-flask-jwt-auth/report.html)
- [log.html](https://daniel0318.github.io/robot-for-flask-jwt-auth/log.html)
## How to generate testing report

### Install
- Follow 2 references tutorial, do all their installations
  ex. install postgres, install robot
- Run login server
```sh
$ python manage.py runserver
```


### run robot test
```sh
$ robot --outputdir results tests
```
Then check report.html in result/

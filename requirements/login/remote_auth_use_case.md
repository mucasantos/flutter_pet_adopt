# Remote authentication Use Case

## Success case

1. System validates the user credentials
2. System does a request to the remote server (login endpoint)
3. System receives the response with the user data and token
4. System stores the user data and token in the local storage
5. System redirects the user to the home page

## Exception - invalid Url
1. System shows an error message "unexpected error"

## Exception - invalid credentials
1. System shows an error message "invalid credentials"

## Exception - no internet connection
1. System shows an error message "no internet connection"

## Exception - server error
1. System shows an error message "server error"

## Exception - timeout


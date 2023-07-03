# SwordHealthChallenge
Sword Health Interview Code Challenge

To run the app? 
To be able to do so you will need to create a configuration file with the API key and Private API key, come with me and follow the steps:

1. Create a file inside the DogsWithSowrds target called **Development.xcconfig**
2. Go to the API page ever [DOG API]:(https://thedogapi.com/) and retrieve the keys
3. Create a config file like this:
<img width="893" alt="Screenshot 2023-07-03 at 17 13 06" src="https://github.com/pitxis/SwordHealthChallenge/assets/4854890/a14fe1a3-ab65-499b-9638-cdb06456fc30">
5. Add the keys to the config file like this
  ```
  API_KEY=apikey
  ```
4. Back to xcode, click the Project icon, go to info, configurations, select the target, usualy debug
5. In the blue icon select the configuration matching your file's name
<img width="747" alt="Screenshot 2023-07-03 at 17 11 17" src="https://github.com/pitxis/SwordHealthChallenge/assets/4854890/875e5539-c244-441a-a9d4-ce086a53ce78">
5. And you should be set to go, the Info.plist will read the values
6. You can do this for every build target.

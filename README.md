[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]


<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="#">
    <img src="./assets/UPM-icon-640.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">UPM</h3>

  <p align="center">
    A New & Modern Password Manager for day to day Life!
    <br />
    ·
    <a href="https://github.com/Abled-Taha/upm/issues/new">Report Bug</a>
    ·
    <a href="https://github.com/Abled-Taha/upm/issues/new">Request Feature</a>
  </p>
</p>
<br>


<!-- ABOUT THE PROJECT -->
## About The Project
There are many great Password Managers available out-there having more features than this application and I even recommend using those ones as your main Password Manager, however, I just started this project as a hobby and I am working on it so, if you want to try it, you are more than welcome to. This Project started as a [**Random Password Generator**](https://github.com/Abled-Taha/Random-Password-Generator-GUI), It then evolved into a Password Manager but it still was made poorly & was not made for managing passwords but just for randomly generating new passwords. I then, started the next generation of this project, carefully choosing the features I want in it, what will be it's limitaions & carefully choosing the technologies it will use. It came to be known as [UPM](https://github.com/Abled-Taha/upm), The Ultimate Password Manager.

### Features
* Managing Passwords in separate Accounts
* Password Generation
* Encrypting Passwords before storing
* One Master Password for each Account to protect all Passwords stored in that Account
* No Data Collected
* Free
* Open-Source
* Community Driven
* No Second-Party Servers, only You run Your Server
* Stores Passwords in cache, as well
* Supporting Multiple Platforms (Windows, Linux, Android)
* Customizable

### Built With
* [Flutter](https://flutter.dev)
* [Flask](https://flask.palletsprojects.com/en/2.2.x/)
* [MongoDB](https://www.mongodb.com)

### Usage
I am not responsible for any kind of use of this software, it was made for generally ethical use and anyone who uses this software for any malicious purpose is responsible for himself/herself.

### Roadmap
[X] Add Releases for Linux.
[] Add Main Functionality of Storing Password.
[] Add Password Generation Functionality.
[] Add Encryption while Trasfering Data over Internet.

See the [open issues](https://github.com/Abled-Taha/upm/issues) for a list of proposed features (and known issues).


<!-- GETTING STARTED -->
## Getting Started
This project is supported to Windows, Linux & Android, & I have releases for all of them but if for any case you want to build it yourself, you can but the instructions of it are not updated as of now.

### Setting Up Server
#### Requirements
* Python 3
#### For Windows & Linux (Debian / Arch)
1. Download & Install [MongoDB](https://www.mongodb.com/try/download/community).
2. Download & Install [MongoShell](https://www.mongodb.com/try/download/shell).
3. Download the latest Server zip from [Releases](https://github.com/Abled-Taha/upm/releases).
4. Extract the zip, a folder named ```upm_server``` should be seen.
5. Edit the ```dbPath``` & ```path``` variables in ```upm_server/assets/mongod.cfg``` to where you want to store the database and logs, respectively.
6. Optionally, you can also change the ```port``` & ```bindIp``` variables but would have to change them in client and server config as well (Not Recommended).
7. Start the database with this config file ```mongod -f upm_server/assets/mongod.cfg```.
8. Run ```mongosh.exe``` located in ```MongoShell/bin```.
9. Here, you might need to authenticate & log in with the ```root``` user.
10. Create a database ```use upmdata```.
11. Create a user ```db.createUser({user: "upm",pwd:passwordPrompt(),passwordroles:[{role:"readWrite",db:"upmdata"}]})```.
12. Type Password for the user and hit Enter.
13. Set the ```passwordDatabase``` variable in ```upm_server/config.json``` to the password you just have set.
14. All Done.
### Setting Up Client
#### For Windows, Android & Linux (Debian / Arch)
1. Download one of the [release](https://github.com/Abled-Taha/upm/releases) according to your system.
* If on Anrdoid, install the APK file.
* If on Linux, extract the zip file and put the directory where you want the program to be & it can run directly.
* If on Windows, run the installer and install like any normal program.
**For Windows And Linux the config file of the program will be stored in ```Documents```, atleast for now. If deleted you have to configure you client settings once again.**

<!-- CONTRIBUTING -->
## Contributing
Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.
1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License
Distributed under the MIT License. See `LICENSE` for more information.


<!-- CONTACT -->
## Contact
Abled Taha - [@AbledTaha](https://twitter.com/@AbledTaha) - abledtaha@gmail.com
Project Link: [Project](https://github.com/Abled-Taha/upm)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Abled-Taha/upm.svg?style=for-the-badge
[contributors-url]: https://github.com/Abled-Taha/upm/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Abled-Taha/upm.svg?style=for-the-badge
[forks-url]: https://github.com/Abled-Taha/upm/network/members
[stars-shield]: https://img.shields.io/github/stars/Abled-Taha/upm.svg?style=for-the-badge
[stars-url]: https://github.com/Abled-Taha/upm/stargazers
[issues-shield]: https://img.shields.io/github/issues/Abled-Taha/upm.svg?style=for-the-badge
[issues-url]: https://github.com/Abled-Taha/upm/issues
[license-shield]: https://img.shields.io/github/license/Abled-Taha/upm.svg?style=for-the-badge
[license-url]: https://github.com/Abled-Taha/upm/blob/main/LICENSE.txt


# 🚀 Scroll Text Application Documentation

<p align="center">
<img src="./assets/app_logo.png" width="50%">
</p>

Scroll Text is an app designed to display different types of content (like text, images, videos, and more) on Liquid Galaxy screens. This project has two main parts: a service running on the master and an application installed on the tablet. They communicate with each other using SSH and web pages.

## 📝 Before Running

1. Ensure the Liquid Galaxy core is installed. More information about the installation can be found in this [repository](https://github.com/LiquidGalaxyLAB/liquid-galaxy).
2. Ensure **Node.js version 14** is installed on the master machine by running:

   ```bash
   node -v
   ```

3. The output should look like `v14.17.5`. If not, use the following link for installation tips:
   [How To Install Node.js on Ubuntu 16.04](https://tecadmin.net/install-latest-nodejs-npm-on-ubuntu/).
4. After installing Node.js, install pm2 on the master machine. Execute the command:

   ```bash
   sudo npm i -g pm2
   ```

## 👨‍💻 Installing The Project

First, open a new terminal and go to the default terminal directory with the command:

```bash
cd
```

Now, clone the repository **in the home directory (default directory on terminal)** of the master machine with the command:

```bash
git clone https://github.com/0xbaggi/scroll-text-application.git
```

Once cloned, navigate to the cloned folder and execute the installation script with the following commands:

```bash
cd scroll_text_application

bash install.sh {port} {password}
```

> _The {password} is the rig password._
> 
> _The {port} is where the service will be installed._

After installation, reboot the machine.

## 📱 App Setup

With the server running, ensure the Android device and Liquid Galaxy are on the **same wi-fi** network before running the app. Then, the setup is simple.

- First, open the app and go to the settings page.

- On the settings screens, set all the variables as follows:
  - Server Ip: Master machine ipv4 (including the dots, e.g., 192.168.1.86)
  - Server Port (ssh port): 22
  - Server Username: username for ssh connection (default: lg)
  - Server Password: password for ssh connection
  - Service Port: 3000 (port of the service previously installed on the master using install.sh)
- Once set, click the “Connect” button at the bottom of the screen.
- Return to the home screen and click on "Start service."
- The app is now ready: you can access the editor and trackpad pages!
## 🛠️ Tested on 
- Ubuntu: 16.04
- Node: 14.21
- Andorid: 11 (API 30)

## Environment setup
- [Installing Python3.9 on an Ubuntu machine](https://linuxize.com/post/how-to-install-python-3-9-on-ubuntu-20-04/)
- Install virutal env, configure it, and install pip `requirements.txt` file:
```bash
cd code
python3.9 -m pip install virtualenv
source env/bin/activate
pip install -r requirements.txt
```
- Install CBC solver: `sudo apt-get install coinor-cbc`
import urllib
import requests
import os

def download_daily_image(path):
    response = requests.get("https://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-US").json()
    url = "https://bing.com" + response['images'][0]['url']
    filename, _ = urllib.request.urlretrieve(url, path)
    return filename

if __name__ == '__main__':
    # get location
    home = os.getenv("HOME")
    location = os.path.join(home, ".data/wallpapers/")
    os.makedirs(location, exist_ok=True)

    # download picture
    download_daily_image(os.path.join(location, "bing_wallpaper.jpg"))

    # update nitrogen (wallpaper app)
    os.system("nitrogen --restore")


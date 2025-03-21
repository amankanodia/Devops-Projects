import requests

def fetch_nse_data(endpoint):
    headers = {
        "User-Agent": "Mozilla/5.0",
        "Accept-Language": "en-US,en;q=0.9"
    }
    url = f"https://www.nseindia.com/api/{endpoint}"
    response = requests.get(url, headers=headers)
    return response.json()

def get_top_gainers():
    return fetch_nse_data("live-analysis-variations?index=gainers")["data"]

def get_top_losers():
    return fetch_nse_data("live-analysis-variations?index=loosers")["data"]
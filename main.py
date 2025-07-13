from fastapi import FastAPI, Request
from fastapi.responses import HTMLResponse, JSONResponse
import requests
import os

app = FastAPI()

# ✅ Set your API key here
ACCESS_KEY = "access_key"  # Replace this with your actual access key

HTML_TEMPLATE = """
<!DOCTYPE html>
<html>
<head><title>Currency Converter</title></head>
<body>
    <h2>Currency Converter</h2>
    <form action="/convert" method="get">
        From:
        <select name="from_currency">
            <option value="USD">USD</option>
            <option value="EUR">EUR</option>
            <option value="INR">INR</option>
            <option value="GBP">GBP</option>
        </select><br><br>
        To:
        <select name="to_currency">
            <option value="INR">INR</option>
            <option value="USD">USD</option>
            <option value="EUR">EUR</option>
            <option value="GBP">GBP</option>
        </select><br><br>
        Amount: <input type="text" name="amount"><br><br>
        <input type="submit" value="Convert">
    </form>
    {result}
</body>
</html>
"""

@app.get("/", response_class=HTMLResponse)
def home():
    return HTML_TEMPLATE.format(result="")

@app.get("/convert", response_class=HTMLResponse)
def convert_ui(from_currency: str, to_currency: str, amount: float):
    url = (
        f"http://api.exchangerate.host/convert"
        f"?access_key={ACCESS_KEY}"
        f"&from={from_currency}&to={to_currency}&amount={amount}&format=1"
    )
    try:
        res = requests.get(url).json()
        if res.get("success") and res.get("result") is not None:
            converted = res["result"]
            result_html = f"<h3>{amount} {from_currency} = {converted:.2f} {to_currency}</h3>"
        else:
            result_html = f"<h3>Conversion failed: {res.get('error', {}).get('info', 'Unknown error')}</h3>"
    except Exception as e:
        result_html = f"<h3>Error: {str(e)}</h3>"

    return HTML_TEMPLATE.format(result=result_html)

@app.get("/api/convert")
def convert_api(from_currency: str, to_currency: str, amount: float):
    url = (
    f"http://api.exchangerate.host/convert"
    f"?access_key={ACCESS_KEY}"
    f"&from={from_currency}"
    f"&to={to_currency}"
    f"&amount={amount}"
    f"&format=1"
)
    try:
        res = requests.get(url).json()
        if res.get("success") and res.get("result") is not None:
            return {"converted_amount": res["result"]}
        return JSONResponse(status_code=400, content={"error": res})
    except Exception as e:
        return JSONResponse(status_code=500, content={"error": str(e)})

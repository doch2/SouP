import pandas as pd
import numpy as np
from keras.models import load_model
import matplotlib.pyplot as plt
import PIL.Image as pilimg

from pykrx import stock
import mpl_finance

from urllib import parse
from ast import literal_eval
import requests
from bs4 import BeautifulSoup as bs
import datetime
import os
import json

rootDirPath = ""

fileDownloadUrl = {}

def fileDownload(url, file_name):
    with open(file_name, "wb") as file:
        response = requests.get(url)
        file.write(response.content)

def createFolder(directory):
    try:
        if not os.path.exists(directory):
            os.makedirs(directory)
    except OSError:
        print ('Error: Creating directory. ' +  directory)

def SE(html,num):
    string = html[num].text
    string = string.replace(',','')
    return int(string)

def getStockPriceData(ticker, priceKind): #priceKind: hour, day, week
    todayDate = str(datetime.date.today()).replace("-", "")
    #todayDate = "20220401" #원하는 날짜로 하고싶을 경우에만 주석 풀고 사용

    if priceKind == "hour":
      htmlSelection = []
      for i in range(1, 42):
        get_param = {
          'code': ticker,
          'thistime': todayDate + "161137",
          'page': str(i),
        }
        get_param = parse.urlencode(get_param)
        url="https://finance.naver.com/item/sise_time.naver?%s"%(get_param)
        response = requests.get(
            url,
            headers={'User-Agent': "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99.0.4844.84 Safari/537.36"}
        )

        originalData = response.text.strip()

        soup = bs(originalData, 'html.parser')
        tempVar = soup.select('span.tah.p11')
        tempResult = []
        previousIndex = 0
        for i in range(0, len(tempVar), 6):
          tempResult.append(tempVar[previousIndex:(i+6)])
          previousIndex = i
        htmlSelection.append(tempResult)

        if "09:00" in originalData:
          break

      price = []
      volume = []

      l = len(htmlSelection)
      for i in range(0,l):
          htmla = htmlSelection[i]
          L = len(htmla)
          for n in range(0,L):
              htmlb = htmla[n]
              LL = len(htmlb)
              for m in range(0,LL):
                  if m == 0:
                      price.append(SE(htmlb,m))
                  elif m == 4:
                      volume.append(SE(htmlb,m))
                  else:
                      pass


      if len(price) != 400:
        return None


      finalResult = pd.DataFrame(columns=['시가', '고가', '저가', '종가', '거래량'])
      previousIndex = 0
      for i in range(0, 400, 60):
        tempVar = price[previousIndex:(i+60)]
        finalResult.loc[len(finalResult)] = [tempVar[0], max(tempVar), min(tempVar), tempVar[59], sum(volume[previousIndex:(i+60)])]
        previousIndex = i


      return finalResult
    elif priceKind == "day":
      return stock.get_market_ohlcv((datetime.datetime.now() - datetime.timedelta(days=6)).strftime("%Y%m%d"), todayDate, ticker)
    elif priceKind == "week":
      get_param = {
        'symbol': ticker,
        'requestType':1,
        'startTime': (datetime.datetime.now() - datetime.timedelta(days=28)).strftime("%Y%m%d"),
        'endTime': todayDate,
        'timeframe': priceKind,
      }
      get_param = parse.urlencode(get_param)
      url="https://api.finance.naver.com/siseJson.naver?%s"%(get_param)
      response = requests.get(url)

      originalData = literal_eval(response.text.strip())
      return pd.DataFrame(originalData[1:], columns=originalData[0])

def getChartPictureArray(tempPriceDataFrame):
    imgPath = rootDirPath + "temp.jpg"


    plt.figure(figsize=(0.44, 0.28), dpi=100)
    ax = plt.subplot()
    plt.axis('off')

    mpl_finance.candlestick2_ohlc(
        ax,
        abs(tempPriceDataFrame['시가']),
        abs(tempPriceDataFrame['고가']),
        abs(tempPriceDataFrame['저가']),
        abs(tempPriceDataFrame['종가']),
        width=0.5,
        colorup='r',
        colordown='b'
    )

    plt.savefig(imgPath)
    plt.close()

    im = np.array(pilimg.open("{}".format(imgPath)))
    im = np.reshape(im, (1,28,44,3))/255
    return im


def lambda_handler(event, context):
  createFolder(rootDirPath + "models/")
  createFolder(rootDirPath + "datasets/")
  fileDownload(fileDownloadUrl['dayModel'], rootDirPath + "models/soup_encoder_day_28_44_4.h5")
  fileDownload(fileDownloadUrl['weekModel'], rootDirPath + "models/soup_encoder_week_28_44_4.h5")
  fileDownload(fileDownloadUrl['monthModel'], rootDirPath + "models/soup_encoder_month_28_44_4.h5")
  fileDownload(fileDownloadUrl['predictModel'], rootDirPath + "models/soup_stockPredict_model.h5")
  fileDownload(fileDownloadUrl['tickerList'], rootDirPath + "datasets/kospi_ticker_without_etn.csv")

  dayModel = load_model(rootDirPath + 'models/soup_encoder_day_28_44_4.h5')
  weekModel = load_model(rootDirPath + 'models/soup_encoder_week_28_44_4.h5')
  monthModel = load_model(rootDirPath + 'models/soup_encoder_month_28_44_4.h5')
  stockPredictModel = load_model(rootDirPath + 'models/soup_stockPredict_model.h5')


  stockListWithoutEtn = pd.read_csv(rootDirPath + "datasets/kospi_ticker_without_etn.csv")['종목코드']
  for ticker in stockListWithoutEtn:
      newTicker = str(ticker)
      if len(newTicker) < 6:
          newTicker = ('0' * (6 - len(newTicker))) + newTicker

      index = stockListWithoutEtn.index[stockListWithoutEtn == ticker].tolist()[0]

      stockListWithoutEtn.iloc[index] = newTicker

  for ticker in stockListWithoutEtn:
      hourDf = getStockPriceData(ticker, "hour")
      dayDf = getStockPriceData(ticker, "day")
      weekDf = getStockPriceData(ticker, "week")

      hourArray = dayModel.predict(np.array(getChartPictureArray(hourDf)))
      dayArray = weekModel.predict(getChartPictureArray(dayDf))
      weekArray = monthModel.predict(getChartPictureArray(weekDf))

      percentage = (stockPredictModel.predict([hourArray, dayArray, weekArray]))[0][0]
  
  return {
      'statusCode': 200,
      'body': json.dumps('Hello from Lambda!')
  }
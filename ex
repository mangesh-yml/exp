LED Rpi
import RPi.GPIO as GPIO
import time

LED = 18

GPIO.setmode(GPIO.BCM)
GPIO.setup(LED, GPIO.OUT)

try:
    while True:
        GPIO.output(LED, GPIO.HIGH)
        time.GPIO.output(LED, GPIO.LOW)
        time.sleep(1)

except KeyboardInterrupt:
    print("Stopped")

finally:
    GPIO.cleanup()











DHT 11 RPI


 











ULTRASONIC WITH ESP32


#define TRIG 5
#define ECHO 18

long duration;
int distance;

void setup()
{
  pinMode(TRIG, OUTPUT);
  pinMode(ECHO, INPUT);

  Serial.begin(115200);
}

void loop()
{
  digitalWrite(TRIG, LOW);
  delayMicroseconds(2);

  digitalWrite(TRIG, HIGH);
  delayMicroseconds(10);

  digitalWrite(TRIG, LOW);

  duration = pulseIn(ECHO, HIGH);

  distance = duration * 0.034 / 2;

  Serial.println(String(distance) + " cm"  );
  //
  delay(1000);
}




LDR WITH  ESP32


#define LDR 34
#define LED 2   //  INBUILT LED PIN OF ESP32

int value;

void setup()
{
  pinMode(LED, OUTPUT);
  Serial.begin(115200);
}

void loop()
{
  value = analogRead(LDR);
  Serial.println(value);
  if(value < 100)
  {
    digitalWrite(LED, HIGH);
  }
  else
  {
    digitalWrite(LED, LOW);
  }                  

  delay(500);
}








DHT11 WITH ESP32 THINGSPEAK


#include <WiFi.h>
#include "ThingSpeak.h"
#include "DHT.h"

#define DHTPIN 4
#define DHTTYPE DHT11

DHT dht(DHTPIN, DHTTYPE);

const char* ssid = "SSID";
const char* password = "PASS";

WiFiClient client;

unsigned long channelNumber = CHANNEL ID ;
const char* writeAPIKey = "WRITE_API_KEY";

void setup()
{
  Serial.begin(115200);

  WiFi.mode(WIFI_STA);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }

  Serial.println("WiFi Connected");

  ThingSpeak.begin(client);

  dht.begin();
}

void loop()
{
  float t = dht.readTemperature();
  float h = dht.readHumidity();

  ThingSpeak.setField(1, t);
  ThingSpeak.setField(2, h);

  Serial.println(t);
  Serial.println(h);

  ThingSpeak.writeFields(channelNumber, writeAPIKey);

  delay(15000);
}


















DC MOTOR WITH PWM 

#define ENA 14
#define IN1 27
#define IN2 26

void setup()
{
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);

  ledcAttach(ENA, 5000, 8);

}

void loop()
{
  
   digitalWrite(IN1, HIGH);
  digitalWrite(IN2, LOW);

  analogWrite(ENA, 80);
  delay(2000);
analogWrite(ENA,150);
  delay(2000);

  analogWrite(ENA, 255);
  delay(2000);
  
}










import RPi.GPIO as GPIO
import dht11
import time
import requests

GPIO.setwarnings(False)
GPIO.setmode(GPIO.BCM)

sensor = dht11.DHT11(pin=4)

api_key = "KRMK1Q4V2E20IZWZ"

while True:

    data = sensor.read()

    if data.is_valid():

        temp = data.temperature
        hum = data.humidity

        print("Temp:", temp)
        print("Humidity:", hum)

        url = "https://api.thingspeak.com/update?api_key={}&field1={}&field2={}".format(
            api_key,
            temp,
            hum
        )

        requests.get(url)

    else:
        print("Sensor ok")

    time.sleep(15)

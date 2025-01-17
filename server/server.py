import websockets
import asyncio

import cv2, base64

port = 8000

print("Started server on port : ", port)

async def transmit(websocket, path):
    print("Client Connected !")
    await websocket.send("Connection Established")
    try :
        cap = cv2.VideoCapture(0)

        while cap.isOpened():
            _, frame = cap.read()
            
            encoded = cv2.imencode('.jpg', frame)[1].tobytes()
            data = bytes(encoded)
            
            await websocket.send(data)
            
            # cv2.imshow("Transimission", frame)
            
            # if cv2.waitKey(1) & 0xFF == ord('q'):
            #     break
        cap.release()
    except websockets.connection.ConnectionClosed as e:
        print("Client Disconnected !")
        cap.release()
    # except:
    #     print("Someting went Wrong !")

start_server = websockets.serve(transmit, host="192.168.0.170", port=port)

asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
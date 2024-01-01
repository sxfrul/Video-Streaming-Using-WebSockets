from multiprocessing import Process
import numpy as np
import cv2 as cv

def grayscale(cap):

    while cap.isOpened():
        ret, frame = cap.read()

        gray = cv.cvtColor(frame, cv.COLOR_BGR2GRAY)

        cv.imshow('grayscale', gray)
        if cv.waitKey(1) == ord('q'):
            break
    return gray

def normalcam(cap):

    while cap.isOpened():
        ret, frame = cap.read()

        grayfunction = grayscale(frame)

        cv.imshow('no grayscale', frame)
        if cv.waitKey(1) == ord('q'):
            break
# When everything done, release the capture
    cap.release()
    cv.destroyAllWindows()


if __name__ == '__main__':
    p = Process(target=normalcam(cv.VideoCapture(0)))
    p.start()
    p2 = Process(target=grayscale(cv.VideoCapture(0)))
    p2.start()
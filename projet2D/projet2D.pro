#-------------------------------------------------
#
# Project created by QtCreator 2015-04-21T10:32:08
#
#-------------------------------------------------

QT       += core gui opengl

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = projet2D
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    suivi2DFunctions.cpp

HEADERS  += mainwindow.h \
    suivi2DFunctions.h

FORMS    += mainwindow.ui

INCLUDEPATH += /opt/local/include \

CONFIG += c++11
QMAKE_MACOSX_DEPLOYMENT_TARGET = 10.9

LIBS += -L/opt/local/lib -lopencv_core -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_imgproc


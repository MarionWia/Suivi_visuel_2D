#-------------------------------------------------
#
# Project created by QtCreator 2015-04-20T10:29:23
#
#-------------------------------------------------

QT       += core gui opengl


greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = 2DVisuel
TEMPLATE = app


SOURCES += main.cpp\
        mainwindow.cpp \
    glwidget.cpp

HEADERS  += mainwindow.h \
    glwidget.h

FORMS    += mainwindow.ui

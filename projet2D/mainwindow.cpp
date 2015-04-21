#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QPixmap>
#include <QImage>
#include <QDebug>
#include <iostream>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QPixmap pix("/Users/benedictefahrer/Documents/TPS/2A/Suivi_visuel_2D/projet2D/imageOriginale_respiration.jpg");
    ui->imageLabel->setPixmap(pix);
    ui->imageLabel->setScaledContents(true);
    ui->imageLabel->adjustSize();


    // mettre l'image en niveau de gris
    QImage image = pix.toImage();
            for(int x = 0; x < image.width(); x++)
            {
                for(int y = 0; y < image.height(); y++)
                {
                    int gray =  qGray(image.pixel(x,y));
                    image.setPixel(x,y,qRgb(gray,gray,gray));
                }
            }
        ui->labelImage2->setPixmap( QPixmap::fromImage(image) );
        ui->labelImage2->setScaledContents(true);
        ui->labelImage2->adjustSize();

}

MainWindow::~MainWindow()
{
    delete ui;
}

int compteur = 0;
void MainWindow::mousePressEvent( QMouseEvent * event)
{
    compteur ++;
    if(compteur == 1)
    {
        x1 = event->x();
        y1 = event->y();
        std::cout << "coordonnée du premier point"<<x1 << " "<< y1<<std::endl;

    }
    else if(compteur == 2)
    {
        x2 = event->x();
        y2 = event->y();
        std::cout << "coordonnée du deuxième point"<<x2 << " "<< y2<<std::endl;
    }
    else
    {

    }


}

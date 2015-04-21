#include "mainwindow.h"
#include "suivi2DFunctions.h"
#include "ui_mainwindow.h"
#include <QPixmap>
#include <QImage>
#include <QDebug>
#include <QRect>
#include <iostream>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // Affichage de l'image initiale en niveau de gris
    QPixmap pix("/Users/benedictefahrer/Documents/TPS/2A/Suivi_visuel_2D/projet2D/imageOriginale_respiration.jpg");
    m_pix = pix;
    m_image = intensity(m_pix);
    ui->imageLabel->setPixmap( QPixmap::fromImage(m_image) );
    ui->imageLabel->setScaledContents(true);
    ui->imageLabel->adjustSize();



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
        int x = event->x();
        int y = event->y();
        m_pointGauche.setX(x);
        m_pointGauche.setY(y);
        std::cout << "coordonnée du premier point"<< m_pointGauche.x()  << " "<< m_pointGauche.y() <<std::endl;

    }
    else if(compteur == 2)
    {
        int x = event->x();
        int y = event->y();
        m_pointDroit.setX(x);
        m_pointDroit.setY(y);
        std::cout << "coordonnée du deuxième point"<<m_pointDroit.x()  << " "<< m_pointDroit.y() <<std::endl;

        // crop image
        QPixmap imageCrop = cropImage(QPixmap::fromImage(m_image),m_pointGauche,m_pointDroit);
        // affichage de l'image crop
        ui->labelImage2->setPixmap(imageCrop);
        ui->labelImage2->setScaledContents(true);
        ui->labelImage2->adjustSize();
    }
    else
    {

    }


}

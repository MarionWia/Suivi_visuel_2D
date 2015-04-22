#include "mainwindow.h"
#include "suivi2DFunctions.h"
#include "ui_mainwindow.h"
#include <QPixmap>
#include <QImage>
#include <QDebug>
#include <QRect>
#include <QPainter>
#include <iostream>
#include <opencv/cv.h>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // Affichage de l'image initiale en niveau de gris
    QPixmap pix("/Users/benedictefahrer/Documents/TPS/2A/Suivi_visuel_2D/projet2D/imageOriginale_respiration.jpg");

    // chargement de l'image au format opencv
    cv::Mat srcImage;
    srcImage = cv::imread("/Users/benedictefahrer/Documents/TPS/2A/Suivi_visuel_2D/projet2D/imageOriginale_respiration.jpg", CV_LOAD_IMAGE_COLOR);

    cv::Mat desti;
    cv::cvtColor(srcImage,srcImage,CV_BGR2RGB);

    // conversion de Mat en QImage: NE FONCTIONNE PAS
    QImage  imageInit((uchar*)desti.data, desti.cols, desti.rows,QImage::Format_RGB888);
    memcpy(imageInit.scanLine(0), (unsigned char*)srcImage.data, imageInit.width()* imageInit.height() * srcImage.channels());

    // Affichage de l'image opencv en niveau de gris
    cv::Mat imageGrey;
    cvtColor(srcImage, imageGrey, CV_RGB2GRAY);
    cv::imshow("Test image gris ",imageGrey);

    // Affichage de l'image QIMage en niveau de gris
    m_pix = pix;
    m_image = intensity(m_pix);
    ui->imageLabel->setPixmap( QPixmap::fromImage(m_image) );
    //ui->imageLabel->setPixmap( QPixmap::fromImage( imageInit) );
    ui->imageLabel->setScaledContents(true);
    ui->imageLabel->adjustSize();

    // Calcul du gradient
    cv::Mat gradIm = calculGradient(imageGrey);
    cv::Mat temp(gradIm.cols,gradIm.rows,gradIm.type());
    imshow("gradient",gradIm);

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
        QImage imageCrop = cropImage(m_image,m_pointGauche,m_pointDroit);
        // affichage de l'image crop
        ui->labelImage2->setPixmap(QPixmap::fromImage(imageCrop));
        ui->labelImage2->setScaledContents(true);
        ui->labelImage2->adjustSize();
    }
    else
    {

    }


}

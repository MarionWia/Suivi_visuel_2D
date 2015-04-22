#ifndef SUIVI2DFUNCTIONS_H
#define SUIVI2DFUNCTIONS_H
#include <QImage>
#include <QPixmap>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>

cv::Mat calculGradient(cv::Mat imgSource);


// Création de l'image en niveau gris
QImage intensity(QPixmap pixImage);

// Crop de l'image en fonction des points cliqués dans l'image
QImage cropImage(QImage image, QPoint pointGauche, QPoint pointDroit);
#endif // SUIVI2DFUNCTIONS_H

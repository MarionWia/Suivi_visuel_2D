#ifndef SUIVI2DFUNCTIONS_H
#define SUIVI2DFUNCTIONS_H
#include <QImage>
#include <QPixmap>

void calculGradient();

// Création de l'image en niveau gris
QImage intensity(QPixmap pixImage);

// Crop de l'image en fonction des points cliqués dans l'image
QPixmap cropImage(QPixmap image, QPoint pointGauche, QPoint pointDroit);
#endif // SUIVI2DFUNCTIONS_H

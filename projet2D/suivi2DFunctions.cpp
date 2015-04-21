#include "suivi2DFunctions.h"
#include <QRect>

QImage intensity(QPixmap pixImage)
{

    QImage image = pixImage.toImage();
            for(int x = 0; x < image.width(); x++)
            {
                for(int y = 0; y < image.height(); y++)
                {
                    int gray =  qGray(image.pixel(x,y));
                    image.setPixel(x,y,qRgb(gray,gray,gray));
                }
            }
            return image;
}

QPixmap cropImage(QPixmap image, QPoint pointGauche, QPoint pointDroit)
{
    QRect rect(pointGauche,pointDroit);
    QPixmap imgCroped = image.copy(rect);
    return imgCroped;
}

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

QImage cropImage(QImage image, QPoint pointGauche, QPoint pointDroit)
{
    QImage imCrop = image.copy(QRect(pointGauche,pointDroit));
    return imCrop;

}


cv::Mat calculGradient(cv::Mat imgSource)
{
    cv::Mat imgGrad;
    cv::Sobel(imgSource, imgGrad, -1, 1, 1, 3, 1, 0, cv::BORDER_DEFAULT );
    return imgGrad;
}

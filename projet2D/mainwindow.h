#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QKeyEvent>
#include <QPoint>

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();

protected:
   void mousePressEvent( QMouseEvent * event);

private:
    Ui::MainWindow *ui;
    QPoint m_pointGauche;
    QPoint m_pointDroit;
    QPixmap m_pix;
    QImage m_image;
};

#endif // MAINWINDOW_H

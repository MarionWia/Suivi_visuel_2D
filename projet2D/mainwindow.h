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
   void paintEvent(QPaintEvent *);

private slots:
   void on_pushButton_clicked();

private:
    Ui::MainWindow *ui;
    QPoint m_pointGauche;
    QPoint m_pointDroit;
    QPixmap m_pix;
    QImage m_image;

    int m_s;
    int m_u;
    int m_v;
    int m_teta;

};

#endif // MAINWINDOW_H

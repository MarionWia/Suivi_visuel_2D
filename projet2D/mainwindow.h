#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QKeyEvent>

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
    int x1;
    int y1;
    int x2;
    int y2;
};

#endif // MAINWINDOW_H

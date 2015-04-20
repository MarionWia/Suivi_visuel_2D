#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QFileDialog>
#include <QMessageBox>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    ui->imageInit;

}

MainWindow::~MainWindow()
{
    delete ui;
}




void MainWindow::on_pushButton_clicked()
{
    //QString dossier = QFileDialog::getExistingDirectory(this);

    QString fichier = QFileDialog::getOpenFileName(this, "Ouvrir un fichier", QString(), "Video (*.mp4 *.wmv)");
    QMessageBox::information(this, "Fichier", "Vous avez sélectionné :\n" + fichier);


}

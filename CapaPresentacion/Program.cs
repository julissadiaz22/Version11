﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CapaPresentacion
{
    internal static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("ES-SV");
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //Inicia directamente en el formulario de login
           Application.Run(new Login());
        }
    }
}

using System;
using System.Diagnostics;
using System.Windows;

namespace Witty.Controls
{
    internal static class UrlExtensions
    {
        public static void TryOpeningUrl(this Uri uri)
        {
            try
            {
                Process.Start(uri.ToString());
            }
            catch
            {
                //TODO: Log specific URL that caused error
                MessageBox.Show("There was a problem launching the specified URL.", "Error", MessageBoxButton.OK,
                                MessageBoxImage.Exclamation);
            }
        }
    }
}
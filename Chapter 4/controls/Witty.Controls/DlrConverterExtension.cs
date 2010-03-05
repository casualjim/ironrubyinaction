using System;
using System.Windows.Markup;

namespace Witty.Controls
{
    public class DlrConverterExtension : MarkupExtension
    {
        public string ConverterName { get; set; }

        public override object ProvideValue(IServiceProvider serviceProvider)
        {
            return new DlrConverter { ConverterName = ConverterName };
        }
    }
}
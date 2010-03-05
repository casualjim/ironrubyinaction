using System.Windows;
using System.Windows.Controls;

namespace Witty.Controls
{
    /// <summary>
    /// Interaction logic for FilterText.xaml
    /// </summary>
    public partial class FilterText : UserControl
    {
        public static readonly RoutedEvent ResetFilterEvent = EventManager.RegisterRoutedEvent(
            "ResetFilter", RoutingStrategy.Bubble, typeof(RoutedEventHandler), typeof(FilterText));

        // Raise an event when the filter is reset

        public FilterText()
        {
            InitializeComponent();
            ShowResetButton();
        }

        /// <summary>
        /// Gets or sets the text content of the filter control.
        /// </summary>
        public string Text
        {
            get { return FilterTextBox.Text; }
            set { FilterTextBox.Text = value; }
        }

        public event RoutedEventHandler ResetFilter
        {
            add { AddHandler(ResetFilterEvent, value); }
            remove { RemoveHandler(ResetFilterEvent, value); }
        }

        /// <summary>
        /// Set the focus to the filter control.
        /// </summary>
        public new void Focus()
        {
            FilterTextBox.Focus();
        }

        /// <summary>
        /// The reset button was clicked, clear the filter control.
        /// </summary>
        private void FilterButton_Click(object sender, RoutedEventArgs e)
        {
            Text = string.Empty;
            RaiseEvent(new RoutedEventArgs(ResetFilterEvent));
        }

        /// <summary>
        /// The filter text changed, show or hide the reset button.
        /// </summary>
        private void FilterTextBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            ShowResetButton();
        }

        /// <summary>
        /// Show the reset button if there is any text in the filter,
        /// otherwise hide the reset button.
        /// </summary>
        private void ShowResetButton()
        {
            FilterButton.Visibility = (FilterTextBox.Text.Trim().Length > 0)
                                          ?
                                              Visibility.Visible
                                          : Visibility.Collapsed;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;

namespace Witty.Controls
{
    internal static class StringExtensions
    {
        public static bool IsEmpty(this string text)
        {
            return string.IsNullOrEmpty(text) || text.Trim().Length == 0;
        }

        public static bool IsUrl(this string text)
        {
            return Uri.IsWellFormedUriString(text, UriKind.Absolute) &&
                   new List<string> {"http", "https", "ftp"}.Contains(new Uri(text).Scheme);
        }

        public static bool IsAtName(this string text)
        {
            return text.StartsWith("@");
        }

        public static string CaptureUrlIfAny(this string text)
        {
            if (text.IsEmpty()) return string.Empty;

            Match match = Regex.Match(text, "href=\"((f|h)ttps?://.+)\"", RegexOptions.IgnoreCase);
            return match.Success ? match.Groups[1].Value : string.Empty;
        }
    }
}
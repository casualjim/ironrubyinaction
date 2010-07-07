using System;
using System.Collections.Generic;

namespace DLRHost
{
    public class StringAdder
    {
        private readonly List<string> _stringList;

        public delegate void OnStringAddedDelegate(string addedValue);
        public event OnStringAddedDelegate OnStringAdded;

        public StringAdder()
        {
            _stringList = new List<string>();
        }

        public void Add(string value)
        {
            _stringList.Add(value);
            OnStringAdded(value);
        }

        public override string ToString()
        {
            return string.Join(", ", _stringList.ToArray());
        }
    }
}

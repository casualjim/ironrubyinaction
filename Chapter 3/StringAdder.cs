using System;
using System.Collections.Generic;

namespace DLRHost
{
    public class StringAdder
    {
        private readonly List<string> _stringList;

        public delegate void StringAddedDelegate(string addedValue);
        public event StringAddedDelegate StringAdded;

        public StringAdder()
        {
            _stringList = new List<string>();
        }

        public void Add(string value)
        {
            _stringList.Add(value);
            if (StringAdded != null)
                StringAdded(value);
        }

        public override string ToString()
        {
            return string.Join(", ", _stringList.ToArray());
        }
    }
}

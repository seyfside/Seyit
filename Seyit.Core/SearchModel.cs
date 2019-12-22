using System;
using System.Linq.Expressions;

namespace Seyit.Core
{
    public class SearchModel<T>
    {
        public int CurrentPage { get; set; }
        public int PageSize { get; set; }
        public Expression<Func<T,bool>> Where { get; set; }
        public Expression<Func<T,object>> OrderBy { get; set; }
        public bool IsDescending { get; set; }
    }
}
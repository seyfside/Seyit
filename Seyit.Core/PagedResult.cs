using System.Collections.Generic;

namespace Seyit.Core
{
    public class PagedResult<TDto> where TDto : class
    {
        public int PageCount { get; set; } 
        public int RowCount { get; set; }
        public IList<TDto> Result { get; set; }

        public PagedResult()
        {
            Result=new List<TDto>();
        }
    }
}
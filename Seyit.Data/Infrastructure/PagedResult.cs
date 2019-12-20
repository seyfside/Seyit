using System.Collections.Generic;

namespace Seyit.Data.Infrastructure
{
    public class PagedResult<TDto> where TDto : class
    {
        public int CurrentPage { get; set; } 
        public int PageCount { get; set; } 
        public int PageSize { get; set; } 
        public int RowCount { get; set; }
        public IList<TDto> Result { get; set; }

        public PagedResult()
        {
            Result=new List<TDto>();
        }
        
    }
}
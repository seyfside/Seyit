using System;
using System.Linq;
using Microsoft.EntityFrameworkCore;
using Seyit.Data.Infrastructure;

namespace Seyit.Data.Airways
{
    public class AirwayRepository : GenericRepository<Airway>, IAirwayRepository
    {
        public AirwayRepository(SeyitDbContext context) : base(context)
        {
        }

        public PagedResult<AirwayDto> Search(SearchModel<Airway> searchModel)
        {
            var query = searchModel.Where != null ? Table.Where(searchModel.Where) : Table;

            if (searchModel.OrderBy != null)
                query = searchModel.IsDescending
                    ? query.OrderByDescending(searchModel.OrderBy)
                    : query.OrderBy(searchModel.OrderBy);

            var pagedResult = new PagedResult<AirwayDto>
            {
                CurrentPage = searchModel.CurrentPage, PageSize = searchModel.PageSize, RowCount = query.Count()
            };

            var pageCount = (double) pagedResult.RowCount / searchModel.PageSize;
            pagedResult.PageCount = (int) Math.Ceiling(pageCount);

            var skip = (searchModel.CurrentPage - 1) * searchModel.PageSize;
            pagedResult.Result = query.Skip(skip).Take(searchModel.PageSize).Select(AirwayDto.Projection).ToList();

            return pagedResult;
        }
    }
}
using System;

namespace Seyit.Business.Infrastructure
{
    public interface IDateTimeProvider
    {
        DateTime Now { get; }
    }
}
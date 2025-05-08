using HotelManagement.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelManagement.Repositories
{
    public interface IRoomTypeRepository
    {
        Task<IEnumerable<RoomType>> GetAllAsync();
        Task<RoomType> GetByIdAsync(int id);
        Task<IEnumerable<RoomType>> GetByHotelIdAsync(int hotelId);
        Task<int> CreateAsync(RoomType roomType);
        Task<bool> UpdateAsync(RoomType roomType);
        Task<bool> DeleteAsync(int id);
    }
} 
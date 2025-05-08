using HotelManagement.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace HotelManagement.Repositories
{
    public interface IHotelRepository
    {
        Task<IEnumerable<Hotel>> GetAllAsync();
        Task<Hotel> GetByIdAsync(int id);
        Task<int> CreateAsync(Hotel hotel);
        Task<bool> UpdateAsync(Hotel hotel);
        Task<bool> DeleteAsync(int id);
    }
}

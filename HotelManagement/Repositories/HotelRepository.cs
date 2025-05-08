using Dapper;
using HotelManagement.Models;
using System.Collections.Generic;
using System.Data;
using System.Threading.Tasks;

namespace HotelManagement.Repositories
{
    public class HotelRepository : IHotelRepository
    {
        private readonly DapperContext _context;

        public HotelRepository(DapperContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Hotel>> GetAllAsync()
        {
            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryAsync<Hotel>("spGetAllHotels", 
                    commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<Hotel> GetByIdAsync(int id)
        {
            using (var connection = _context.CreateConnection())
            {
                return await connection.QueryFirstOrDefaultAsync<Hotel>(
                    "spGetHotelById",
                    new { Id = id },
                    commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<int> CreateAsync(Hotel hotel)
        {
            using (var connection = _context.CreateConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("Name", hotel.Name);
                parameters.Add("Address", hotel.Address);

                return await connection.QuerySingleAsync<int>(
                    "spAddHotel",
                    parameters,
                    commandType: CommandType.StoredProcedure);
            }
        }

        public async Task<bool> UpdateAsync(Hotel hotel)
        {
            using (var connection = _context.CreateConnection())
            {
                var parameters = new DynamicParameters();
                parameters.Add("Id", hotel.Id);
                parameters.Add("Name", hotel.Name);
                parameters.Add("Address", hotel.Address);

                var affected = await connection.ExecuteAsync(
                    "spUpdateHotel",
                    parameters,
                    commandType: CommandType.StoredProcedure);

                return affected > 0;
            }
        }

        public async Task<bool> DeleteAsync(int id)
        {
            using (var connection = _context.CreateConnection())
            {
                var affected = await connection.ExecuteAsync(
                    "spDeleteHotel",
                    new { Id = id },
                    commandType: CommandType.StoredProcedure);

                return affected > 0;
            }
        }
    }
} 
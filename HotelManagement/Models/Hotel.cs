using System;
using System.Collections.Generic;

namespace HotelManagement.Models
{
    public class Hotel
    {
        public int Id { get; set; }
        public required string Name { get; set; }
        public required string Address { get; set; }
    }
}

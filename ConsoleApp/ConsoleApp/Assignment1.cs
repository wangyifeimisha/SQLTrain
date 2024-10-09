using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ConsoleApp
{
    internal class Assignment1
    {
        public static void DisplayNumberInfo()
        {
            Type[] types = { typeof(sbyte), typeof(byte), typeof(short), typeof(ushort),
                         typeof(int), typeof(uint), typeof(long), typeof(ulong),
                         typeof(float), typeof(double), typeof(decimal) };

            Console.WriteLine("{0,-10} {1,-10} {2,-30} {3,-30}", "Type", "Bytes", "Min Value", "Max Value");
            Console.WriteLine(new string('-', 80));

            foreach (Type t in types)
            {
                Console.WriteLine("{0,-10} {1,-10} {2,-30} {3,-30}",
                    t.Name,
                    System.Runtime.InteropServices.Marshal.SizeOf(t),
                    GetMinValue(t),
                    GetMaxValue(t));
            }
        }

        public static object GetMinValue(Type type)
        {
            return type.IsValueType && type.IsPrimitive ? Activator.CreateInstance(type).GetType().GetField("MinValue").GetValue(null) : null;
        }

        public static object GetMaxValue(Type type)
        {
            return type.IsValueType && type.IsPrimitive ? Activator.CreateInstance(type).GetType().GetField("MaxValue").GetValue(null) : null;
        }


        public static void ConvertCenturies(int centuries)
        {
            int years = centuries * 100;
            int days = (int)(years * 365.24); // Accounting for leap years
            long hours = days * 24;
            long minutes = hours * 60;
            long seconds = minutes * 60;
            long milliseconds = seconds * 1000;
            long microseconds = milliseconds * 1000;
            decimal nanoseconds = microseconds * 1000m;

            Console.WriteLine($"{centuries} centuries = {years} years = {days} days = {hours} hours = {minutes} minutes");
            Console.WriteLine($"= {seconds} seconds = {milliseconds} milliseconds = {microseconds} microseconds = {nanoseconds} nanoseconds");
        }
    }
}

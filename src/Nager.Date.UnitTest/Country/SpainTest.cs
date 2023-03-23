using Microsoft.VisualStudio.TestTools.UnitTesting;
using Nager.Date.Extensions;
using System;
using System.Linq;

namespace Nager.Date.UnitTest.Country
{
    [TestClass]
    public class SpainTest
    {
        [TestMethod]
        public void CheckDayOfMadridIsThirdMayIn2021()
        {
            var yearToTest = 2021;
            var expectedDate = new DateTime(yearToTest, 5, 3);

            var publicHolidays = DateSystem.GetPublicHolidays(yearToTest, CountryCode.ES);
            var publicHoliday = publicHolidays.Where(publicHoliday => publicHoliday.Name == "Day of Madrid").FirstOrDefault();
            Assert.AreEqual(expectedDate, publicHoliday.Date);
        }

        [DataTestMethod]
        [DataRow(2018, 10, 8, false)]
        [DataRow(2018, 10, 9, false)]
        [DataRow(2018, 10, 10, false)]
        [DataRow(2018, 10, 11, false)]
        [DataRow(2018, 10, 12, false)]
        [DataRow(2018, 10, 13, true)]
        [DataRow(2018, 10, 14, true)]
        public void ChecksThatUniversalWeekendIsUsed(int year, int month, int day, bool expectedIsWeekend)
        {
            var date = new DateTime(year, month, day);
            var isWeekend = date.IsWeekend(CountryCode.ES);
            Assert.AreEqual(expectedIsWeekend, isWeekend);
        }
    }
}

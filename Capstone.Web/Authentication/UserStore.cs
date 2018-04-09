using Dapper;
using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Transactions;
using System.Web;

namespace Capstone.Web.Authentication
{
    public class UserStore : IUserStore<User>, IUserPasswordStore<User>, IUserSecurityStampStore<User>, IUserEmailStore<User>
    {
        private readonly string connectionString;

        /// <summary>
        /// Creates a new UserStore.
        /// </summary>
        /// <param name="connectionString">the connection string where the user data resides</param>
        public UserStore(string connectionString)
        {
            if (string.IsNullOrWhiteSpace(connectionString))
                throw new ArgumentNullException("connectionString");

            this.connectionString = connectionString;
        }

        /// <summary>
        /// Creates a new UserStore by using the DefaultConnection from the web.config
        /// </summary>
        public UserStore()
        {
            this.connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
        }

        public void Dispose()
        {

        }


        /// <summary>
        /// Creates a new user.
        /// </summary>
        /// <param name="user">The user object to add to the system.</param>
        /// <returns></returns>
        public Task CreateAsync(User user)
        {

            if (user == null)
                throw new ArgumentNullException("user");

            return Task.Factory.StartNew(() =>
            {
                user.UserId = Guid.NewGuid();

                var userRoles = user.Roles.Select(r => new { UserId = user.Id, Name = r }).ToList();

                using (TransactionScope tran = new TransactionScope())
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Execute("insert into Users(UserId, UserName, PasswordHash, SecurityStamp) values(@userId, @userName, @passwordHash, @securityStamp)", user);
                        connection.Execute("insert into UserRoles(UserId, Role) values (@userId, @name)", userRoles);
                    }
                    tran.Complete();
                }
            });
        }

        /// <summary>
        /// Deletes a user
        /// </summary>
        /// <param name="user">The user with an existing user id.</param>
        /// <returns></returns>
        public Task DeleteAsync(User user)
        {

            if (user == null)
                throw new ArgumentNullException("user");

            return Task.Factory.StartNew(() =>
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Execute("delete from UserRoles where UserId = @userId", new { user.UserId });
                        connection.Execute("delete from Users where UserId = @userId", new { user.UserId });
                    }

                    scope.Complete();
                }
            });
        }


        /// <summary>
        /// Retrieves a user by id.
        /// </summary>
        /// <param name="userId">The (guid formatted) user id</param>
        /// <returns>null if the user is not found</returns>
        public Task<User> FindByIdAsync(string userId)
        {
            if (string.IsNullOrWhiteSpace(userId))
            {
                throw new ArgumentNullException("userId");
            }

            Guid parsedUserId;
            if (!Guid.TryParse(userId, out parsedUserId))
            {
                throw new ArgumentOutOfRangeException("userId", string.Format("'{0}' is not a valid GUID.", new { userId }));
            }

            return Task.Factory.StartNew(() =>
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string sql = @"select users.*, userroles.Role from users
                                    join userroles on UserRoles.UserId = users.UserId
                                    where users.UserId = @userId";

                    var userDictionary = new Dictionary<Guid, User>();

                    return connection.Query<User, string, User>(sql, (user, role) =>
                    {
                        User userentry;

                        if (!userDictionary.TryGetValue(user.UserId, out userentry))
                        {
                            userentry = user;
                            userDictionary.Add(userentry.UserId, userentry);
                        }

                        userentry.Roles.Add(role);
                        return userentry;

                    }, new { userId = parsedUserId }, splitOn: "Role").FirstOrDefault();
                }
            });
        }

        /// <summary>
        /// Retrieves a user by their username
        /// </summary>
        /// <param name="userName"></param>
        /// <returns>null if the user is not found</returns>
        public Task<User> FindByNameAsync(string userName)
        {
            if (string.IsNullOrWhiteSpace(userName))
            {
                throw new ArgumentNullException("userName");
            }

            return Task.Factory.StartNew(() =>
            {
                var userDictionary = new Dictionary<Guid, User>();

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    string sql = @"select users.*, userroles.Role from users
                                    join userroles on UserRoles.UserId = users.UserId
                                    where lower(UserName) = lower(@userName)";

                    return connection.Query<User, string, User>(sql, (user, role) =>
                    {
                        User userentry;

                        if (!userDictionary.TryGetValue(user.UserId, out userentry))
                        {
                            userentry = user;
                            userDictionary.Add(userentry.UserId, userentry);
                        }

                        userentry.Roles.Add(role);
                        return userentry;
                    }, new { userName = userName }, splitOn: "Role").FirstOrDefault();

                    //return connection.QuerySingleOrDefault<User>("select * from Users where lower(UserName) = lower(@userName)", new { userName });
                }
            });
        }

        /// <summary>
        /// Updates a user.
        /// </summary>
        /// <param name="user">The fully updated user object</param>
        /// <returns></returns>
        public Task UpdateAsync(User user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            return Task.Factory.StartNew(() =>
            {
                var userRoles = user.Roles.Select(r => new { UserId = user.Id, Name = r }).ToList();

                using (TransactionScope scope = new TransactionScope())
                {
                    using (SqlConnection connection = new SqlConnection(connectionString))
                    {
                        connection.Execute("delete from UserRoles where UserId = @userId", new { user.UserId });
                        connection.Execute("update Users set UserName = @userName, PasswordHash = @passwordHash, SecurityStamp = @securityStamp where UserId = @userId", user);
                        connection.Execute("insert into UserRoles(UserId, Role) values (@userId, @name)", userRoles);
                    }

                    scope.Complete();
                }
            });
        }

        /// <summary>
        /// Sets the user's password hash.
        /// </summary>
        /// <param name="user"></param>
        /// <param name="passwordHash"></param>
        /// <returns></returns>
        public Task SetPasswordHashAsync(User user, string passwordHash)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            user.PasswordHash = passwordHash;

            return Task.FromResult(0);
        }

        /// <summary>
        /// Returns a password hash.
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public Task<string> GetPasswordHashAsync(User user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            return Task.FromResult(user.PasswordHash);
        }

        /// <summary>
        /// Returns if the user has a password provided.
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public Task<bool> HasPasswordAsync(User user)
        {
            return Task.FromResult(!string.IsNullOrEmpty(user.PasswordHash));
        }

        /// <summary>
        /// Sets the security stamp associated with a user.
        /// </summary>
        /// <param name="user"></param>
        /// <param name="stamp"></param>
        /// <returns></returns>
        public Task SetSecurityStampAsync(User user, string stamp)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            user.SecurityStamp = stamp;

            return Task.FromResult(0);
        }

        /// <summary>
        /// Gets the security stamp for a user.
        /// </summary>
        /// <param name="user"></param>
        /// <returns></returns>
        public Task<string> GetSecurityStampAsync(User user)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            return Task.FromResult(user.SecurityStamp);
        }


        public Task SetEmailAsync(User user, string email)
        {
            throw new NotImplementedException();
        }

        public Task<string> GetEmailAsync(User user)
        {
            throw new NotImplementedException();
        }

        public Task<bool> GetEmailConfirmedAsync(User user)
        {
            throw new NotImplementedException();
        }

        public Task SetEmailConfirmedAsync(User user, bool confirmed)
        {
            throw new NotImplementedException();
        }

        public Task<User> FindByEmailAsync(string email)
        {
            throw new NotImplementedException();
        }
    }
}
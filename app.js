const mysql = require("mysql2");
const express = require("express");
const bcrypt = require("bcryptjs")

 
const app = express();
const urlencodedParser = express.urlencoded({extended: false});
 
const pool = mysql.createPool({
  host: "localhost",
  user: "root",
  database: "workshop",
  password: "LlLlLl5_"
});
 
app.set("view engine", "hbs");
app.use('/views', express.static('views'));
app.use(express.static('public'));

let isAdmin = null;

app.get('/registration', function (req, res){
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
  if(isAdmin === true){
    res.render("auth/registration.hbs");
  } else {
    res.redirect('/');
  }
}
})

app.post('/registration', urlencodedParser, function (req, res) {
  if(!req.body) return res.sendStatus(400);
  const loginHTML = req.body.login;
  const passwordHTML = req.body.password;
  const roleHTML = req.body.role;
  const hashPassword = bcrypt.hashSync(passwordHTML, 7);
  if(loginHTML === "" || passwordHTML === "") {
    res.redirect('/registration');
    return;
  }
  pool.query('INSERT INTO users (login, password, role) VALUES (?,?,?)', [loginHTML, hashPassword, roleHTML], function(err, result){
    if(err){
      res.redirect('/registration');
      return;
    } else {
      res.redirect('/auth');
    };
  });
});

app.get('/auth', function (req, res){
  isAdmin = null;
  res.render("auth/auth.hbs");
})

app.post('/auth', urlencodedParser, function (req, res){
  if(!req.body) return res.sendStatus(400);
  const loginHTML = req.body.login;
  const passwordHTML = req.body.password;
  if(loginHTML === "" || passwordHTML === "") {
    res.redirect('/auth');
    return;
  }
  pool.query(`SELECT * FROM users where login = '${loginHTML}' `, (err, result) => {
    if(result[0].login === undefined || result[0].password === undefined) {
      res.redirect('/auth');
      return;
    }
    if(result[0].login === loginHTML && bcrypt.compareSync(passwordHTML, result[0].password)){
      res.redirect('/');
      if(result[0].role === 'admin'){
        isAdmin = true;
      } else isAdmin = false;
    } else {
      res.redirect('/auth');
    }
  }) 
});

app.get("/", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
      res.render("../main.hbs", {
    });
  };
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/orders", urlencodedParser, function(req, res){
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
    pool.query("select orders.*, clients.fullname as fullnameClients, shoes.id_Brands, workers.fullname as fullnameWorker, deliverymans.fullname as fullnameDeliveryman, brandInfo.brandName from orders inner join clients on orders.id_Clients = clients.id_Client inner join workers on orders.id_Workers = workers.id_Worker inner join deliverymans on orders.id_Deliverymans = deliverymans.id_Deliverysmans inner join shoes on orders.id_Shoes = shoes.id_Shoe inner join brandInfo on shoes.id_Brands = brandInfo.id_Brand", function(err, data) {
      if(err) return console.log(err);
      res.render("orders/orders.hbs", {
          orders: data
      });
    });
  };
});

app.get("/createOrder", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth');
  } else res.render("orders/createOrder.hbs");
});

app.post("/createOrder", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
    if(!req.body) return res.sendStatus(400);
    const id_Clients = req.body.id_Clients;
    const id_Shoes = req.body.id_Shoes;
    const id_Workers = req.body.id_Workers;
    const id_Deliverymans = req.body.id_Deliverymans || null;
    const date_Order = req.body.date_Order;
    const date_Return = req.body.date_Return;    
    const Price = req.body.Price;
    pool.query("INSERT INTO orders (id_Clients, id_Shoes, id_Workers, id_Deliverymans, date_Order, date_Return, Price) VALUES (?,?,?,?,?,?,?)", [id_Clients, id_Shoes, id_Workers, id_Deliverymans, date_Order, date_Return, Price], function(err, data) {
      if(err) return console.log(err);
      res.redirect("orders");
    });
  }
});


app.get("/editOrder/:id_Orders", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
    const id_Orders = req.params.id_Orders;
    pool.query("SELECT * FROM orders WHERE id_Orders=?", [id_Orders], function(err, data) {
      if(err) return console.log(err);
      res.render("orders/editOrder.hbs", {
        orders: data[0]
      });
    });
  } else res.redirect('/orders');
}
});
 

app.post("/editOrder", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
  if(!req.body) return res.sendStatus(400);
  const id_Orders = req.body.id_Orders;
  const id_Clients = req.body.id_Clients;
  const id_Shoes = req.body.id_Shoes;
  const id_Workers = req.body.id_Workers;
  const id_Deliverymans = req.body.id_Deliverymans || null;
  const date_Order = req.body.date_Order.replace('-','').replace('-','');
  const date_Return = req.body.date_Return.replace('-','').replace('-','');    
  const Price = req.body.Price;
  pool.query(`UPDATE orders SET id_Clients=${id_Clients}, id_Shoes=${id_Shoes}, id_Workers=${id_Workers}, id_Deliverymans=${id_Deliverymans}, date_Order=${date_Order}, date_Return=${date_Return}, Price=${Price} WHERE id_Orders=${id_Orders}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/orders");
  });
}
});

app.post("/deleteOrder/:id_Orders", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
    if(isAdmin === true){
      const id_Orders = req.params.id_Orders;
      pool.query("DELETE FROM orders WHERE id_Orders=?", [id_Orders], function(err, data) {
          if(err) return console.log(err);
          res.redirect("/orders");
      });
    }
    else {
      res.redirect('/orders');
    }
}
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/clients", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
  pool.query(" select clients.*, clientsRelatives.fullnameRelative, clientsRating.rating from clients inner join clientsRelatives on clients.id_Relative = clientsRelatives.id_ClientsRelatives inner join clientsRating on clients.id_Rating = clientsRating.id_ClientsRating", function(err, data) {
    if(err) return console.log(err);
    res.render("clients/clients.hbs", {
        clients: data
    });
  });
}
});

app.get("/createClient", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth');
  } else res.render("clients/createClient.hbs");
});

app.post("/createClient", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
    if(!req.body) return res.sendStatus(400);

    const fullname = req.body.fullname;
    const phoneNumber = req.body.phoneNumber;
    const address = req.body.address;
    const email = req.body.email;
    const birthday = req.body.birthday;
    const id_Relative = req.body.id_Relative || null;
    const id_Rating = req.body.id_Rating || null;

    pool.query(`INSERT INTO clients (fullname, phoneNumber, address, email, birthday, id_Relative, id_Rating) VALUES (?,?,?,?,?,?,?)`, 
      [fullname, phoneNumber, address, email, birthday, id_Relative, id_Rating], function(err, data) {
      if(err) return console.log(err);
      res.redirect("clients");
    });
  };
});

app.get("/editClient/:id_Client", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
    if(isAdmin === true){
      const id_Client = req.params.id_Client;
      pool.query("SELECT * FROM clients WHERE id_Client=?", [id_Client], function(err, data) {
        if(err) return console.log(err);
        res.render("clients/editClient.hbs", {
            clients: data[0]
        });
      });
    } else {res.redirect('/clients')}
}
});

app.post("/editClient", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth');
  } else {
  if(!req.body) return res.sendStatus(400);
  const id_Client = req.body.id_Client;
  const fullname = req.body.fullname;
  const phoneNumber = req.body.phoneNumber;
  const address = req.body.address;
  const email = req.body.email;
  const birthday = req.body.birthday.replace('-','').replace('-','');    
  const id_Relative = req.body.id_Relative || null;
  const id_Rating = req.body.id_Rating || null;
  pool.query(`UPDATE clients SET fullname='${fullname}', phoneNumber='${phoneNumber}', address='${address}', email='${email}', birthday=${birthday}, id_Relative=${id_Relative}, id_Rating=${id_Rating} WHERE id_Client=${id_Client}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/clients");
  });
}
});

app.post("/deleteClients/:id_Client", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_Client = req.params.id_Client;
  pool.query("DELETE FROM clients WHERE id_Client=?", [id_Client], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/clients");
  });
} else {
  res.redirect('/clients')
}
}
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/workers", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  pool.query("SELECT * FROM workers", function(err, data) {
    if(err) return console.log(err);
    res.render("workers/workers.hbs", {
        workers: data
    });
  })
}
});

app.get("/createWorker", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  res.render("workers/createWorker.hbs");
  }
});

app.post("/createWorker", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const fullname = req.body.fullname;
  const phoneNumber = req.body.phoneNumber;
  const address = req.body.address;
  const email = req.body.email;
  const date_start = req.body.date_start;    
  const children = req.body.children || null;
  pool.query(`INSERT INTO workers (fullname, phoneNumber, address, email, date_start, children) VALUES (?,?,?,?,?,?)`, [fullname, phoneNumber, address, email, date_start, children], function(err, data) {
    if(err) return console.log(err);
    res.redirect("workers");
  });
}
});

app.get("/editWorker/:id_Worker", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_Worker = req.params.id_Worker;
  pool.query("SELECT * FROM workers WHERE id_Worker=?", [id_Worker], function(err, data) {
    if(err) return console.log(err);
     res.render("workers/editWorker.hbs", {
        workers: data[0]
    });
  });
} else {
  res.redirect('/workers')
}
}
});

app.post("/editWorker", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  if(!req.body) return res.sendStatus(400);
  const id_Worker = req.body.id_Worker;
  const fullname = req.body.fullname;
  const phoneNumber = req.body.phoneNumber;
  const address = req.body.address;
  const email = req.body.email;
  const date_start = req.body.date_start.replace('-','').replace('-','');  
  const children = req.body.children || null;
  pool.query(`UPDATE workers SET fullname='${fullname}', phoneNumber='${phoneNumber}', address='${address}', email='${email}', date_start=${date_start}, children=${children} WHERE id_Worker=${id_Worker}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/workers");
  });
} else {
  res.redirect('/workers')
}
}
});

app.post("/deleteWorkers/:id_Worker", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_Worker = req.params.id_Worker;
  pool.query("DELETE FROM workers WHERE id_Worker=?", [id_Worker], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/workers");
  });
} else {
  res.redirect('/workers')
}
}
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/shoes", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  pool.query("select shoes.*, brandInfo.brandName from shoes inner join brandInfo on shoes.id_Brands = brandInfo.id_Brand", function(err, data) {
    if(err) return console.log(err);
    res.render("shoes/shoes.hbs", {
        shoes: data
    });
  });
}
});

app.get("/createShoe", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  res.render("shoes/createShoe.hbs");
  }
});

app.post("/createShoe", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const id_Brands = req.body.id_Brands;
  const material = req.body.material;
  const season = req.body.season;
  const type = req.body.type;
  const gender = req.body.gender;    
  const shoes_condition = req.body.shoes_condition;
  pool.query(`INSERT INTO shoes (id_Brands, material, season, type, gender, shoes_condition) VALUES (?,?,?,?,?,?)`, [id_Brands, material, season, type, gender, shoes_condition], function(err, data) {
    if(err) return console.log(err);
    res.redirect("shoes");
  });
}
});

app.get("/editShoe/:id_Shoe", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_Shoe = req.params.id_Shoe;
  pool.query("SELECT * FROM shoes WHERE id_Shoe=?", [id_Shoe], function(err, data) {
    if(err) return console.log(err);
     res.render("shoes/editShoe.hbs", {
        shoes: data[0]
    });
  });
} else {
  res.redirect('/shoes')
}
}
});

app.post("/editShoe", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const id_Shoe = req.body.id_Shoe;
  const id_Brands = req.body.id_Brands;
  const material = req.body.material;
  const season = req.body.season;
  const type = req.body.type;
  const gender = req.body.gender;    
  const shoes_condition = req.body.shoes_condition;
  pool.query(`UPDATE shoes SET id_Brands='${id_Brands}', material='${material}', season='${season}', type='${type}', gender='${gender}', shoes_condition='${shoes_condition}' WHERE id_Shoe=${id_Shoe}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/shoes");
  });
}
});

app.post("/deleteShoe/:id_Shoe", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_Shoe = req.params.id_Shoe;
  pool.query("DELETE FROM shoes WHERE id_Shoe=?", [id_Shoe], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/shoes");
  });
}
  else {
    res.redirect('/shoes')
  }
}
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/deliverymans", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  pool.query("SELECT * FROM deliverymans", function(err, data) {
    if(err) return console.log(err);
    res.render("deliverymans/deliverymans.hbs", {
      deliverymans: data
    });
  });
}
});

app.get("/createDeliveryman", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  res.render("deliverymans/createDeliveryman.hbs");
  }
});

app.post("/createDeliveryman", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const fullname = req.body.fullname;
  const phoneNumber = req.body.phoneNumber;
  const email = req.body.email;
  pool.query(`INSERT INTO deliverymans (fullname, phoneNumber, email) VALUES (?,?,?)`, [fullname, phoneNumber, email], function(err, data) {
    if(err) return console.log(err);
    res.redirect("deliverymans");
  });
}
});

app.get("/editDeliveryman/:id_Deliverysmans", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_Deliverysmans = req.params.id_Deliverysmans;
  pool.query("SELECT * FROM deliverymans WHERE id_Deliverysmans=?", [id_Deliverysmans], function(err, data) {
    if(err) return console.log(err);
     res.render("deliverymans/editDeliveryman.hbs", {
      deliverymans: data[0]
    });
  });
} else {
  res.redirect('/deliverymans')
}
}
});

app.post("/editDeliveryman", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  if(!req.body) return res.sendStatus(400);
  const id_Deliverysmans = req.body.id_Deliverysmans;
  const fullname = req.body.fullname;
  const phoneNumber = req.body.phoneNumber;
  const email = req.body.email;
  pool.query(`UPDATE deliverymans SET fullname='${fullname}', phoneNumber='${phoneNumber}', email='${email}' WHERE id_Deliverysmans=${id_Deliverysmans}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/deliverymans");
  });
} else {
  res.redirect('/deliverymans')
}
}
});

app.post("/deleteDeliveryman/:id_Deliverysmans", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_Deliverysmans = req.params.id_Deliverysmans;
  pool.query("DELETE FROM deliverymans WHERE id_Deliverysmans=?", [id_Deliverysmans], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/deliverymans");
  });
} else {
  res.redirect('/deliverymans')
}
}
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/brandInfo", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  pool.query("SELECT * FROM brandInfo", function(err, data) {
    if(err) return console.log(err);
    res.render("brandInfo/brandInfo.hbs", {
        brandInfo: data
    });
  });
}
});

app.get("/createBrand", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  res.render("brandInfo/createBrandInfo.hbs");
  }
});

app.post("/createBrand", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const brandName = req.body.brandName;
  const website = req.body.website;
  pool.query(`INSERT INTO brandInfo (brandName, website) VALUES (?,?)`, [brandName, website], function(err, data) {
    if(err) return console.log(err);
    res.redirect("brandInfo");
  });
}
});

app.get("/editBrand/:id_Brand", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_Brand = req.params.id_Brand;
  pool.query("SELECT * FROM brandInfo WHERE id_Brand=?", [id_Brand], function(err, data) {
    if(err) return console.log(err);
     res.render("brandInfo/editBrandInfo.hbs", {
        brandInfo: data[0]
    });
  });
} else {
  res.redirect('/brandInfo')
}
}
});

app.post("/editBrand", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const id_Brand = req.body.id_Brand;
  const brandName = req.body.brandName;
  const website = req.body.website;
  pool.query(`UPDATE brandInfo SET brandName='${brandName}', website='${website}' WHERE id_Brand=${id_Brand}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/brandInfo");
  });
}
});

app.post("/deleteBrand/:id_Brand", function(req, res){  
  if(isAdmin === null){
    res.redirect('/auth')
  }    else {
    if(isAdmin === true){
  const id_Brand = req.params.id_Brand;
  pool.query("DELETE FROM brandInfo WHERE id_Brand=?", [id_Brand], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/brandInfo");
  });
} else {
  res.redirect('/brandInfo')
}
}
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/clientsRating", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  pool.query("SELECT * FROM clientsRating", function(err, data) {
    if(err) return console.log(err);
    res.render("clientsRating/clientsRating.hbs", {
        clientsRating: data
    });
  });
}
});

app.get("/createClientRating", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  res.render("clientsRating/createClientRating.hbs");
  }
});

app.post("/createClientRating", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const quantityOrders = req.body.quantityOrders;
  const rating = req.body.rating;
  pool.query(`INSERT INTO clientsRating (quantityOrders, rating) VALUES (?,?)`, [quantityOrders, rating], function(err, data) {
    if(err) return console.log(err);
    res.redirect("clientsRating");
  });
}
});

app.get("/editClientRating/:id_ClientsRating", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_ClientsRating = req.params.id_ClientsRating;
  pool.query("SELECT * FROM clientsRating WHERE id_ClientsRating=?", [id_ClientsRating], function(err, data) {
    if(err) return console.log(err);
     res.render("clientsRating/editClientRating.hbs", {
        clientsRating: data[0]
    });
  });
} else {
  res.redirect('/clientsRating')
}
}
});

app.post("/editClientRating", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const id_ClientsRating = req.body.id_ClientsRating;
  const quantityOrders = req.body.quantityOrders;
  const rating = req.body.rating;
  pool.query(`UPDATE clientsRating SET quantityOrders='${quantityOrders}', rating='${rating}' WHERE id_ClientsRating=${id_ClientsRating}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/clientsRating");
  });
}
});

app.post("/deleteClientRating/:id_ClientsRating", function(req, res){  
  if(isAdmin === null){
    res.redirect('/auth')
  }    else { 
    if(isAdmin === true){
  const id_ClientsRating = req.params.id_ClientsRating;
  pool.query("DELETE FROM clientsRating WHERE id_ClientsRating=?", [id_ClientsRating], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/clientsRating");
  });
} else {
  res.redirect('/clientsRating')
}
}
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/clientsRelatives", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  pool.query("SELECT * FROM clientsRelatives", function(err, data) {
    if(err) return console.log(err);
    res.render("clientsRelatives/clientsRelatives.hbs", {
      clientsRelatives: data
    });
  });
}
});

app.get("/createClientsRelative", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  res.render("clientsRelatives/createClientsRelative.hbs");
  }
});

app.post("/createClientsRelative", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const fullname = req.body.fullname;
  const phoneNumber = req.body.phoneNumber;
  const type = req.body.type;
  pool.query(`INSERT INTO clientsRelatives (fullnameRelative, phoneNumber, type) VALUES (?,?,?)`, [fullname, phoneNumber, type], function(err, data) {
    if(err) return console.log(err);
    res.redirect("clientsRelatives");
  });
}
});

app.get("/editClientsRelative/:id_ClientsRelatives", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_ClientsRelatives = req.params.id_ClientsRelatives;
  pool.query("SELECT * FROM clientsRelatives WHERE id_ClientsRelatives=?", [id_ClientsRelatives], function(err, data) {
    if(err) return console.log(err);
     res.render("clientsRelatives/editClientsRelative.hbs", {
      clientsRelatives: data[0]
    });
  });
} else {
  res.redirect('/clientsRelatives')
}
}
});

app.post("/editClientsRelative", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const id_ClientsRelatives = req.body.id_ClientsRelatives;
  const fullnameRelative = req.body.fullnameRelative;
  const phoneNumber = req.body.phoneNumber;
  const type = req.body.type;
  pool.query(`UPDATE clientsRelatives SET fullnameRelative='${fullnameRelative}', phoneNumber='${phoneNumber}', type='${type}' WHERE id_ClientsRelatives=${id_ClientsRelatives}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/clientsRelatives");
  });
}
});

app.post("/deleteClientsRelative/:id_ClientsRelatives", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  }      else {
    if(isAdmin === true){
  const id_ClientsRelatives = req.params.id_ClientsRelatives;
  pool.query("DELETE FROM ClientsRelatives WHERE id_ClientsRelatives=?", [id_ClientsRelatives], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/clientsRelatives");
  });
} else {
  res.redirect('/clientsRelatives')
}
}
}); 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.get("/workersChildren", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  pool.query("SELECT * FROM workersChildren", function(err, data) {
    if(err) return console.log(err);
    res.render("workersChildren/workersChildren.hbs", {
        workersChildren: data
    });
  });
}
});

app.get("/createWorkersChild", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  res.render("workersChildren/createWorkersChild.hbs");
  }
});

app.post("/createWorkersChild", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const fullname = req.body.fullname;
  const school = req.body.school;
  const birthday = req.body.birthday;
  const id_Worker = req.body.id_Worker;
  pool.query(`INSERT INTO workersChildren (fullname, school, birthday, id_Worker) VALUES (?,?,?,?)`, [fullname, school, birthday, id_Worker], function(err, data) {
    if(err) return console.log(err);
    res.redirect("workersChildren");
  });
}
});

app.get("/editWorkersChild/:id_WorkersChildren", function(req, res){
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
    if(isAdmin === true){
  const id_WorkersChildren = req.params.id_WorkersChildren;
  pool.query("SELECT * FROM workersChildren WHERE id_WorkersChildren=?", [id_WorkersChildren], function(err, data) {
    if(err) return console.log(err);
     res.render("workersChildren/editWorkersChild.hbs", {
        workersChildren: data[0]
    });
  });
} else {
  res.redirect('/workersChildren')
}
}
});

app.post("/editWorkersChild", urlencodedParser, function (req, res) {
  if(isAdmin === null){
    res.redirect('/auth')
  } else {
  if(!req.body) return res.sendStatus(400);
  const id_WorkersChildren = req.body.id_WorkersChildren;
  const fullname = req.body.fullname;
  const school = req.body.school;
  const birthday = req.body.birthday;
  const id_Worker = req.body.id_Worker;
  pool.query(`UPDATE workersChildren SET fullname='${fullname}', school='${school}', birthday='${birthday}', id_Worker='${id_Worker}' WHERE id_WorkersChildren=${id_WorkersChildren}`, function(err, data) {
    if(err) return console.log(err);
    res.redirect("/workersChildren");
  });
}
});

app.post("/deleteWorkersChild/:id_WorkersChildren", function(req, res){    
  if(isAdmin === null){
    res.redirect('/auth')
  }  else {
    if(isAdmin === true){
  const id_WorkersChildren = req.params.id_WorkersChildren;
  pool.query("DELETE FROM workersChildren WHERE id_WorkersChildren=?", [id_WorkersChildren], function(err, data) {
      if(err) return console.log(err);
      res.redirect("/workersChildren");
  });
} else {
  res.redirect('/workersChildren')
}
}
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
app.listen(3000, function(){
  console.log("Сервер ожидает подключения...");
});
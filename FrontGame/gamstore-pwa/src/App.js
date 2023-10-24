import React from 'react';
import './App.css';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Izbornik from './components/izbornik.component';
import Pocetna from './components/pocetna.component';
import NadzornaPloca from './components/nadzornaploca.component';
import Izdavaci from './components/izdavac/izdavaci.component';
import DodajIzdavac from './components/izdavac/dodajIzdavac.component';
import PromjeniIzdavac from './components/izdavac/promjeniIzdavac.component';
import Korisnici from './components/korisnik/korisnici.component';  
import DodajKorisnik from './components/korisnik/dodajKorisnik.component';
import PromjeniKorisnik from './components/korisnik/promjeniKorisnik.component';
import Igre from './components/igra/igre.component';
import Narudzbe from './components/narudzba/narudzba.component';
import DodajIgra from './components/igra/dodajIgra.component';
import DodajNarudzba from './components/narudzba/dodajNarudzba.component';

function App() {
  return (
    <Router>
      <Izbornik />
      <Routes>
        <Route path='/' element={<Pocetna />} />
        <Route path='/nadzornaploca' element={<NadzornaPloca />} />
        <Route path='/izdavaci' element={<Izdavaci />} />
        <Route path="/izdavaci/dodaj" element={<DodajIzdavac />} />
        <Route path="/izdavaci/:sifra" element={<PromjeniIzdavac />} />
        <Route path="/korisnici" element={<Korisnici />} />
        <Route path="/korisnici/dodaj" element={<DodajKorisnik />} />
        <Route path="/korisnici/:sifra" element={<PromjeniKorisnik />} />
        <Route path="/igre" element={<Igre />} />
        <Route path="/igre/dodaj" element={<DodajIgra />} />
        <Route path="/narudzbe" element={<Narudzbe />} />
        <Route path="/narudzbe/dodaj" element={<DodajNarudzba />} />
        
      </Routes>
      
    </Router>
  );
}

export default App;

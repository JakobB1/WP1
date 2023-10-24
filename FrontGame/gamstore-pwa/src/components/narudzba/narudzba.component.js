import React, { Component } from "react";
import NarudzbaDataService from "../../services/narudzba.service";
import Container from 'react-bootstrap/Container';
import Table from 'react-bootstrap/Table';
import Button from 'react-bootstrap/Button';
import { Link } from "react-router-dom";
import { FaEdit } from 'react-icons/fa';
import { FaTrash } from 'react-icons/fa';
import { Modal } from 'react-bootstrap';
import moment from "moment/moment";



export default class Narudzbe extends Component{
    constructor(props) {
        super(props);
        this.dohvatiNarudzbe = this.dohvatiNarudzbe.bind(this);
    
        this.state = {
          narudzbe: [],
          prikaziModal: false
        };
      }
    
      otvoriModal = () => this.setState({ prikaziModal: true });
      zatvoriModal = () => this.setState({ prikaziModal: false });
    
    
      componentDidMount() {
        this.dohvatiNarudzbe();
      }
      dohvatiNarudzbe() {
        NarudzbaDataService.getAll()
          .then(response => {
            this.setState({
              narudzbe: response.data
            });
            console.log(response);
          })
          .catch(e => {
            console.log(e);
          });
      }
    
      async obrisiNarudzba(sifra){
        
        const odgovor = await NarudzbaDataService.delete(sifra);
        if(odgovor.ok){
         this.dohvatiNarudzbe();
        }else{
         this.otvoriModal();
        }
        
       }
    
      render() {
        const { narudzbe} = this.state;
        return (
    
        <Container>
          <a href="/narudzbe/dodaj" className="btn btn-success gumb">Dodaj novu narudzbu</a>
          <Table striped bordered hover responsive>
                  <thead>
                    <tr>
                      <th>Broj narudzbe</th>
                      <th>Korisnik</th>
                      <th>Plaćanje</th>
                      <th>Datum obracuna</th>
                      <th>Akcija</th>
                    </tr>
                  </thead>
                  <tbody>
                  {narudzbe && narudzbe.map((n,index) => (
                    
                    <tr key={index}>
                      <td className="sifra">{n.sifra} </td>
                      <td className="korisnik">{n.korisnik} </td>
                      <td className="placanje">{n.placanje} </td>
                      <td className="datumObracuna">
                        {n.datumObracuna==null ? "Nije definirano" :
                         moment.utc(n.datumObracuna).format("DD. MM. YYYY. HH:mm")}
                     </td>
                      <td>
                                        <Link className="btn btn-primary gumb"
                                        to={`/narudzbe/${n.sifra}`}>
                                            <FaEdit />
                                        </Link>
    
                                        <Button variant="danger" className="gumb"
                                        onClick={()=>this.obrisiNarudzba(n.sifra)}>
                                            <FaTrash />
                                        </Button>
                                    </td>
                    </tr>
                    ))
                  }
                  </tbody>
                 
                </Table>     
    
                 <Modal show={this.state.prikaziModal} onHide={this.zatvoriModal}>
                  <Modal.Header closeButton>
                    <Modal.Title>Greška prilikom brisanja</Modal.Title>
                  </Modal.Header>
                  <Modal.Body>Naudzba ima korisnike.</Modal.Body>
                  <Modal.Footer>
                    <Button variant="secondary" onClick={this.zatvoriModal}>
                      Zatvori
                    </Button>
                  </Modal.Footer>
                </Modal>
    
        </Container>
            

        );
    }
}
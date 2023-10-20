import React, { Component } from "react";
import { Button, Container, Table } from "react-bootstrap";
import IzdavacDataService from "../..//services/izdavac.service";
import { Link } from "react-router-dom";
import {FaEdit, FaTrash} from "react-icons/fa";


export default class Izdavaci extends Component{

    constructor(props){
        super(props);
        this.dohvatiIzdavaci = this.dohvatiIzdavaci.bind(this);
        this.obrisiIzdavac = this.obrisiIzdavac.bind(this);

        this.state = {
            izdavaci: []
        };

    }

    componentDidMount(){
        this.dohvatiIzdavaci();
    }

    async dohvatiIzdavaci(){

        await IzdavacDataService.get()
        .then(response => {
            this.setState({
                izdavaci: response.data
            });
            console.log(response.data);
        })
        .catch(e =>{
            console.log(e);
        });
    }

    async obrisiIzdavac(sifra){
        const odgovor = await IzdavacDataService.delete(sifra);
        if(odgovor.ok){
            this.dohvatiIzdavaci();
        }else{
            alert(odgovor.poruka);
        }
    }


    render(){

        const { izdavaci } = this.state;

        return (
            <Container>
                <a href="/izdavaci/dodaj" className="btn btn-success gumb">
                    Dodaj novog izdavaca
                </a>

                <Table strict bordered hover responsive>
                    <thead>
                        <tr>
                            <th>Naziv</th>
                            <th>Drzava</th>
                            <th>Web Stranica</th>
                            <th>Akcija</th>
                        </tr>
                    </thead>
                    <tbody>
                        { izdavaci && izdavaci.map((izdavac,index) => (

                            <tr key={index}>
                                <td>{izdavac.naziv}</td>
                                <td>{izdavac.drzava}</td>
                                <td>{izdavac.webStranica}</td>
                                <td>
                                    <Link className="btn btn-primary gumb"
                                    to={`/izdavaci/${izdavac.sifra}`}>
                                        <FaEdit />
                                    </Link>

                                    <Button variant="danger" className="gumb"
                                    onClick={()=>this.obrisiIzdavac(izdavac.sifra)}>
                                        <FaTrash />
                                    </Button>
                                </td>
                            </tr>

                        ))}
                    </tbody>
                </Table>





            </Container>
            

        );
    }
}
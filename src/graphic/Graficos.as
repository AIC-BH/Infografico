package graphic 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class Graficos 
	{
		
		[Embed(source="AreaVazia.png")] 
		public var GRAreaVazia:Class;
		
		[Embed(source="AreaCheia1.png")] 
		public var GRAreaCheia1:Class;
		
		[Embed(source="AreaCheiaInicio.png")] 
		public var GRAreaCheiaInicio:Class;
		
		[Embed(source="AreaCheiaMeio.png")] 
		public var GRAreaCheiaMeio:Class;
		
		[Embed(source="AreaCheiaFim.png")] 
		public var GRAreaCheiaFim:Class;
		
		[Embed(source="FundoTrilhas.png")] 
		public var GRFundoTrilhas:Class;
		
		[Embed(source="BTAvancar.png")] 
		public var GRBTAvancar:Class;
		
		[Embed(source="BTAvancar10.png")] 
		public var GRBTAvancar10:Class;
		
		[Embed(source="BTVoltar.png")] 
		public var GRBTVoltar:Class;
		
		[Embed(source="BTVoltar10.png")] 
		public var GRBTVoltar10:Class;
		
		[Embed(source="BTInicio.png")] 
		public var GRBTInicio:Class;
		
		[Embed(source="BTPlay.png")] 
		public var GRBTPlay:Class;
		
		[Embed(source="BTPause.png")] 
		public var GRBTPause:Class;
		
		[Embed(source="BTStop.png")] 
		public var GRBTStop:Class;
		
		[Embed(source="BTCompAjuda.png")] 
		public var GRBTCompAjuda:Class;
		
		[Embed(source="BTCompFechar.png")] 
		public var GRBTCompFechar:Class;
		
		[Embed(source="BTCompScan.png")] 
		public var GRBTCompScan:Class;
		
		[Embed(source="BTCompVoltar.png")] 
		public var GRBTCompVoltar:Class;
		
		[Embed(source="MensagemErroDownload.png")] 
		public var GRMensagemErroDownload:Class;
		
		[Embed(source="MensagemSucessoDownload.png")] 
		public var GRMensagemSucessoDownload:Class;
		
		[Embed(source="MensagemAguardeDownload.png")] 
		public var GRMensagemAguardeDownload:Class;
		
		[Embed(source="BTAbrir.png")] 
		public var GRBTAbrir:Class;
		
		[Embed(source="BTAjuda.png")] 
		public var GRBTAjuda:Class;
		
		[Embed(source="BTMais.png")] 
		public var GRBTMais:Class;
		
		[Embed(source="BTArquivos.png")] 
		public var GRBTArquivos:Class;
		
		[Embed(source="BTCompartilhar.png")] 
		public var GRBTCompartilhar:Class;
		
		[Embed(source="BTInfo.png")] 
		public var GRBTInfo:Class;
		
		[Embed(source="BTMixer.png")] 
		public var GRBTMixer:Class;
		
		[Embed(source="BTNovo.png")] 
		public var GRBTNovo:Class;
		
		[Embed(source="BTSalvar.png")] 
		public var GRBTSalvar:Class;
		
		[Embed(source="BTReceber.png")] 
		public var GRBTReceber:Class;
		
		[Embed(source="BTOk.png")] 
		public var GRBTOk:Class;
		
		[Embed(source="BTCancel.png")] 
		public var GRBTCancel:Class;
		
		[Embed(source="FundoJanela.png")] 
		public var GRFundoJanela:Class;
		
		[Embed(source="BTBiblioteca.png")] 
		public var GRBTBiblioteca:Class;
		
		[Embed(source="BTLixeira.png")] 
		public var GRBTLixeira:Class;
		
		[Embed(source="BTMeusAudios.png")] 
		public var GRBTMeusAudios:Class;
		
		[Embed(source="BTBibliotecaIm.png")] 
		public var GRBTBibliotecaIm:Class;
		
		[Embed(source="BTMinhasImagens.png")] 
		public var GRBTMinhasImagens:Class;
		
		[Embed(source="BTTexto.png")] 
		public var GRBTTexto:Class;
		
		[Embed(source="BTAbrirMp3.png")] 
		public var GRBTAbrirMp3:Class;
		
		[Embed(source="BTGravarMp3.png")] 
		public var GRBTGravarMp3:Class;
		
		[Embed(source="AreaTextoNome.png")] 
		public var GRAreaTextoNome:Class;
		
		[Embed(source="AreaTextoId.png")] 
		public var GRAreaTextoId:Class;
		
		[Embed(source="AreaTextoSobre.png")] 
		public var GRAreaTextoSobre:Class;
		
		[Embed(source="AreaTextoTexto.png")] 
		public var GRAreaTextoTexto:Class;
		
		[Embed(source="AreaTextoLink.png")] 
		public var GRAreaTextoLink:Class;
		
		[Embed(source="AreaVolume.png")] 
		public var GRAreaVolume:Class;
		
		[Embed(source="BTVolume.png")] 
		public var GRBTVolume:Class;
		
		[Embed(source="BTMicrofoneGrande.png")] 
		public var GRBTMicrofoneGrande:Class;
		
		[Embed(source="MensagemGravandoAudio.png")] 
		public var GRMensagemGravandoAudio:Class;
		
		[Embed(source="MensagemProcessandoAudio.png")] 
		public var GRMensagemProcessandoAudio:Class;
		
		[Embed(source="SobreID.png")] 
		public var GRSobreID:Class;
		
		[Embed(source="BTFontePfennig.png")] 
		public var GRBTFontePfennig:Class;
		
		[Embed(source="BTFonteAveria.png")] 
		public var GRBTFonteAveria:Class;
		
		[Embed(source="BTFonteGamaliel.png")] 
		public var GRBTFonteGamaliel:Class;
		
		[Embed(source="BTFonteCodeRoman.png")] 
		public var GRBTFonteCodeRoman:Class;
		
		[Embed(source="BTPropMais.png")] 
		public var GRBTPropMais:Class;
		
		[Embed(source="BTPropMenos.png")] 
		public var GRBTPropMenos:Class;
		
		[Embed(source="BTLink.png")] 
		public var GRBTLink:Class;
		
		[Embed(source="PropTamanho.png")] 
		public var GRPropTamanho:Class;
		
		[Embed(source="PropRotacao.png")] 
		public var GRPropRotacao:Class;
		
		[Embed(source="PropVermelho.png")] 
		public var GRPropVermelho:Class;
		
		[Embed(source="PropVerde.png")] 
		public var GRPropVerde:Class;
		
		[Embed(source="PropAzul.png")] 
		public var GRPropAzul:Class;
		
		[Embed(source="PropOrdem.png")] 
		public var GRPropOrdem:Class;
		
		[Embed(source="BTMaisPagina.png")] 
		public var GRBTMaisPagina:Class;
		
		[Embed(source="BTMenosPagina.png")] 
		public var GRBTMenosPagina:Class;
		
		[Embed(source="BTPaginaAnterior.png")] 
		public var GRBTPaginaAnterior:Class;
		
		[Embed(source="BTPaginaProxima.png")] 
		public var GRBTPaginaProxima:Class;
		
		[Embed(source="BTResetImagem.png")] 
		public var GRBTResetImagem:Class;
		
		[Embed(source="BTEditaTexto.png")] 
		public var GRBTEditaTexto:Class;
		
		[Embed(source="BTApresentar.png")] 
		public var GRBTApresentar:Class;
		
		[Embed(source="BTExportarImagem.png")] 
		public var GRBTExportarImagem:Class;
		
		[Embed(source="BTTelaCheia.png")] 
		public var GRBTTelaCheia:Class;
		
		[Embed(source="BTManagana.png")] 
		public var GRBTManagana:Class;
		
		[Embed(source="BTEsquerda.png")] 
		public var GRBTEsquerda:Class;
		
		[Embed(source="BTDireita.png")] 
		public var GRBTDireita:Class;
		
		[Embed(source="BTFechar.png")] 
		public var GRBTFechar:Class;
		
		// HELP
		
		[Embed(source="help/ajuda00.png", compression="true", quality="70")] 
		public var AJUDA00:Class;
		[Embed(source="help/ajuda01.png", compression="true", quality="70")] 
		public var AJUDA01:Class;
		[Embed(source="help/ajuda02.png", compression="true", quality="70")] 
		public var AJUDA02:Class;
		[Embed(source="help/ajuda03.png", compression="true", quality="70")] 
		public var AJUDA03:Class;
		[Embed(source="help/ajuda04.png", compression="true", quality="70")] 
		public var AJUDA04:Class;
		[Embed(source="help/ajuda05.png", compression="true", quality="70")] 
		public var AJUDA05:Class;
		[Embed(source="help/ajuda06.png", compression="true", quality="70")] 
		public var AJUDA06:Class;
		[Embed(source="help/ajuda07.png", compression="true", quality="70")] 
		public var AJUDA07:Class;
		[Embed(source="help/ajuda08.png", compression="true", quality="70")] 
		public var AJUDA08:Class;
		[Embed(source="help/ajuda09.png", compression="true", quality="70")] 
		public var AJUDA09:Class;
		[Embed(source="help/ajuda10.png", compression="true", quality="70")] 
		public var AJUDA10:Class;
		[Embed(source="help/ajuda11.png", compression="true", quality="70")] 
		public var AJUDA11:Class;
		[Embed(source="help/ajuda12.png", compression="true", quality="70")] 
		public var AJUDA12:Class;
		[Embed(source="help/ajuda13.png", compression="true", quality="70")] 
		public var AJUDA13:Class;
		[Embed(source="help/ajuda14.png", compression="true", quality="70")] 
		public var AJUDA14:Class;
		[Embed(source="help/ajuda15.png", compression="true", quality="70")] 
		public var AJUDA15:Class;
		[Embed(source="help/ajuda16.png", compression="true", quality="70")] 
		public var AJUDA16:Class;
		[Embed(source="help/ajuda17.png", compression="true", quality="70")] 
		public var AJUDA17:Class;
		[Embed(source="help/ajuda18.png", compression="true", quality="70")] 
		public var AJUDA18:Class;
		[Embed(source="help/ajuda19.png", compression="true", quality="70")] 
		public var AJUDA19:Class;
		[Embed(source="help/ajuda20.png", compression="true", quality="70")] 
		public var AJUDA20:Class;
		[Embed(source="help/ajuda21.png", compression="true", quality="70")] 
		public var AJUDA21:Class;
		[Embed(source="help/ajuda22.png", compression="true", quality="80")] 
		public var AJUDA22:Class;
		
		
		[Embed(source="BTHelp1.png")] 
		public var GRBTHelp1:Class;
		[Embed(source="BTHelp2.png")] 
		public var GRBTHelp2:Class;
		[Embed(source="BTHelp3.png")] 
		public var GRBTHelp3:Class;
		
		// SPLASH
		
		[Embed(source="TelaSplash.png", compression="true", quality="90")] 
		public var GRSplash:Class;
		
		public function Graficos() 
		{
			
		}
		
		/**
		 * Recupera um bitmap com o gráfico indicado.
		 * @param	nome	o nome do gráfico a ser usado
		 * @return	objeto Bitmap com o gráfico ou null caso o nome não seja encontrado
		 */
		public function getGR(nome:String):Bitmap
		{
			var bmp:Bitmap;
			switch (nome) {
				case 'AreaVazia': bmp = new GRAreaVazia() as Bitmap; break;
				case 'AreaCheia1': bmp = new GRAreaCheia1() as Bitmap; break;
				case 'AreaCheiaInicio': bmp = new GRAreaCheiaInicio() as Bitmap; break;
				case 'AreaCheiaMeio': bmp = new GRAreaCheiaMeio() as Bitmap; break;
				case 'AreaCheiaFim': bmp = new GRAreaCheiaFim() as Bitmap; break;
				case 'FundoTrilhas': bmp = new GRFundoTrilhas() as Bitmap; break;
				case 'BTAvancar': bmp = new GRBTAvancar() as Bitmap; break;
				case 'BTAvancar10': bmp = new GRBTAvancar10() as Bitmap; break;
				case 'BTVoltar': bmp = new GRBTVoltar() as Bitmap; break;
				case 'BTVoltar10': bmp = new GRBTVoltar10() as Bitmap; break;
				case 'BTInicio': bmp = new GRBTInicio() as Bitmap; break;
				case 'BTPlay': bmp = new GRBTPlay() as Bitmap; break;
				case 'BTPause': bmp = new GRBTPause() as Bitmap; break;
				case 'BTStop': bmp = new GRBTStop() as Bitmap; break;
				case 'BTCompAjuda': bmp = new GRBTCompAjuda() as Bitmap; break;
				case 'BTCompFechar': bmp = new GRBTCompFechar() as Bitmap; break;
				case 'BTCompScan': bmp = new GRBTCompScan() as Bitmap; break;
				case 'BTCompVoltar': bmp = new GRBTCompVoltar() as Bitmap; break;
				case 'MensagemErroDownload': bmp = new GRMensagemErroDownload() as Bitmap; break;
				case 'MensagemSucessoDownload': bmp = new GRMensagemSucessoDownload() as Bitmap; break;
				case 'MensagemAguardeDownload': bmp = new GRMensagemAguardeDownload() as Bitmap; break;
				case 'BTAbrir': bmp = new GRBTAbrir() as Bitmap; break;
				case 'BTAjuda': bmp = new GRBTAjuda() as Bitmap; break;
				case 'BTArquivos': bmp = new GRBTArquivos() as Bitmap; break;
				case 'BTCompartilhar': bmp = new GRBTCompartilhar() as Bitmap; break;
				case 'BTInfo': bmp = new GRBTInfo() as Bitmap; break;
				case 'BTMixer': bmp = new GRBTMixer() as Bitmap; break;
				case 'BTNovo': bmp = new GRBTNovo() as Bitmap; break;
				case 'BTSalvar': bmp = new GRBTSalvar() as Bitmap; break;
				case 'BTReceber': bmp = new GRBTReceber() as Bitmap; break;
				case 'BTOk': bmp = new GRBTOk() as Bitmap; break;
				case 'BTCancel': bmp = new GRBTCancel() as Bitmap; break;
				case 'BTLixeira': bmp = new GRBTLixeira() as Bitmap; break;
				case 'FundoJanela': bmp = new GRFundoJanela() as Bitmap; break;
				case 'BTBiblioteca': bmp = new GRBTBiblioteca() as Bitmap; break;
				case 'BTMeusAudios': bmp = new GRBTMeusAudios() as Bitmap; break;
				case 'BTBibliotecaIm': bmp = new GRBTBibliotecaIm() as Bitmap; break;
				case 'BTMinhasImagens': bmp = new GRBTMinhasImagens() as Bitmap; break;
				case 'BTTexto': bmp = new GRBTTexto() as Bitmap; break;
				case 'BTAbrirMp3': bmp = new GRBTAbrirMp3() as Bitmap; break;
				case 'BTGravarMp3': bmp = new GRBTGravarMp3() as Bitmap; break;
				case 'AreaTextoNome': bmp = new GRAreaTextoNome() as Bitmap; break;
				case 'AreaTextoId': bmp = new GRAreaTextoId() as Bitmap; break;
				case 'AreaTextoSobre': bmp = new GRAreaTextoSobre() as Bitmap; break;
				case 'AreaTextoTexto': bmp = new GRAreaTextoTexto() as Bitmap; break;
				case 'AreaTextoLink': bmp = new GRAreaTextoLink() as Bitmap; break;
				case 'AreaVolume': bmp = new GRAreaVolume() as Bitmap; break;
				case 'BTVolume': bmp = new GRBTVolume() as Bitmap; break;
				case 'BTMicrofoneGrande': bmp = new GRBTMicrofoneGrande() as Bitmap; break;
				case 'MensagemGravandoAudio': bmp = new GRMensagemGravandoAudio() as Bitmap; break;
				case 'MensagemProcessandoAudio': bmp = new GRMensagemProcessandoAudio() as Bitmap; break;
				case 'SobreID': bmp = new GRSobreID() as Bitmap; break;
				case 'BTMais': bmp = new GRBTMais() as Bitmap; break;
				case 'BTFontePfennig': bmp = new GRBTFontePfennig() as Bitmap; break;
				case 'BTFonteAveria': bmp = new GRBTFonteAveria() as Bitmap; break;
				case 'BTFonteGamaliel': bmp = new GRBTFonteGamaliel() as Bitmap; break;
				case 'BTFonteCodeRoman': bmp = new GRBTFonteCodeRoman() as Bitmap; break;
				case 'BTPropMais': bmp = new GRBTPropMais() as Bitmap; break;
				case 'BTPropMenos': bmp = new GRBTPropMenos() as Bitmap; break;
				case 'PropTamanho': bmp = new GRPropTamanho() as Bitmap; break;
				case 'PropRotacao': bmp = new GRPropRotacao() as Bitmap; break;
				case 'PropVermelho': bmp = new GRPropVermelho() as Bitmap; break;
				case 'PropVerde': bmp = new GRPropVerde() as Bitmap; break;
				case 'PropAzul': bmp = new GRPropAzul() as Bitmap; break;
				case 'PropOrdem': bmp = new GRPropOrdem() as Bitmap; break;
				case 'BTLink': bmp = new GRBTLink() as Bitmap; break;
				case 'BTMaisPagina': bmp = new GRBTMaisPagina() as Bitmap; break;
				case 'BTMenosPagina': bmp = new GRBTMenosPagina() as Bitmap; break;
				case 'BTPaginaAnterior': bmp = new GRBTPaginaAnterior() as Bitmap; break;
				case 'BTPaginaProxima': bmp = new GRBTPaginaProxima() as Bitmap; break;
				case 'BTResetImagem': bmp = new GRBTResetImagem() as Bitmap; break;
				case 'BTEditaTexto': bmp = new GRBTEditaTexto() as Bitmap; break;
				case 'BTApresentar': bmp = new GRBTApresentar() as Bitmap; break;
				case 'BTExportarImagem': bmp = new GRBTExportarImagem() as Bitmap; break;
				case 'BTTelaCheia': bmp = new GRBTTelaCheia() as Bitmap; break;
				case 'BTManagana': bmp = new GRBTManagana() as Bitmap; break;
				case 'BTEsquerda': bmp = new GRBTEsquerda() as Bitmap; break;
				case 'BTDireita': bmp = new GRBTDireita() as Bitmap; break;
				case 'BTFechar': bmp = new GRBTFechar() as Bitmap; break;
				
				case 'AJUDA00': bmp = new AJUDA00() as Bitmap; break;
				case 'AJUDA01': bmp = new AJUDA01() as Bitmap; break;
				case 'AJUDA02': bmp = new AJUDA02() as Bitmap; break;
				case 'AJUDA03': bmp = new AJUDA03() as Bitmap; break;
				case 'AJUDA04': bmp = new AJUDA04() as Bitmap; break;
				case 'AJUDA05': bmp = new AJUDA05() as Bitmap; break;
				case 'AJUDA06': bmp = new AJUDA06() as Bitmap; break;
				case 'AJUDA07': bmp = new AJUDA07() as Bitmap; break;
				case 'AJUDA08': bmp = new AJUDA08() as Bitmap; break;
				case 'AJUDA09': bmp = new AJUDA09() as Bitmap; break;
				case 'AJUDA10': bmp = new AJUDA10() as Bitmap; break;
				case 'AJUDA11': bmp = new AJUDA11() as Bitmap; break;
				case 'AJUDA12': bmp = new AJUDA12() as Bitmap; break;
				case 'AJUDA13': bmp = new AJUDA13() as Bitmap; break;
				case 'AJUDA14': bmp = new AJUDA14() as Bitmap; break;
				case 'AJUDA15': bmp = new AJUDA15() as Bitmap; break;
				case 'AJUDA16': bmp = new AJUDA16() as Bitmap; break;
				case 'AJUDA17': bmp = new AJUDA17() as Bitmap; break;
				case 'AJUDA18': bmp = new AJUDA18() as Bitmap; break;
				case 'AJUDA19': bmp = new AJUDA19() as Bitmap; break;
				case 'AJUDA20': bmp = new AJUDA20() as Bitmap; break;
				case 'AJUDA21': bmp = new AJUDA21() as Bitmap; break;
				case 'AJUDA22': bmp = new AJUDA22() as Bitmap; break;
				
				case 'BTHelp1': bmp = new GRBTHelp1() as Bitmap; break;
				case 'BTHelp2': bmp = new GRBTHelp2() as Bitmap; break;
				case 'BTHelp3': bmp = new GRBTHelp3() as Bitmap; break;
				
				case 'Splash': bmp = new GRSplash() as Bitmap; break;
			}
			if (bmp != null) bmp.smoothing = true;
			return (bmp);
		}
		
		/**
		 * Recupera um sprite com o gráfico indicado.
		 * @param	nome	o nome do gráfico a ser usado
		 * @return	objeto Sprite com o gráfico ou null caso o nome não seja encontrado
		 */
		public function getSPGR(nome:String):Sprite
		{
			var retorno:Sprite;
			var bmp:Bitmap = this.getGR(nome);
			if (bmp != null) {
				retorno = new Sprite();
				retorno.addChild(bmp);
				retorno.useHandCursor = true;
				retorno.buttonMode = true;
			}
			return (retorno);
		}
	}

}
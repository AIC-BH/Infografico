package colabora.oaprendizagem.infografico.display 
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class BarraInferiorProp extends Sprite
	{
		
		// VARIÁVIES PÚBLICAS
		
		public var acTamanho:Function;
		public var acRotacao:Function;
		public var acVermelho:Function;
		public var acVerde:Function;
		public var acAzul:Function;
		public var acOrdem:Function;
		
		// VARIÁVEIS PRIVADAS
		
		private var _bg:Shape;
		
		private var _tamanho:Bitmap;
		private var _btTamanhoMais:Sprite;
		private var _btTamanhoMenos:Sprite;
		
		private var _rotacao:Bitmap;
		private var _btRotacaoMais:Sprite;
		private var _btRotacaoMenos:Sprite;
		
		private var _vermelho:Bitmap;
		private var _btVermelhoMais:Sprite;
		private var _btVermelhoMenos:Sprite;
		
		private var _verde:Bitmap;
		private var _btVerdeMais:Sprite;
		private var _btVerdeMenos:Sprite;
		
		private var _azul:Bitmap;
		private var _btAzulMais:Sprite;
		private var _btAzulMenos:Sprite;
		
		private var _ordem:Bitmap;
		private var _btOrdemMais:Sprite;
		private var _btOrdemMenos:Sprite;
		
		public function BarraInferiorProp() 
		{
			// preparando fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(AreaApp.CORBARRAS);
			this._bg.graphics.drawRect(0, 0, AreaApp.AREAWIDTH, (1.5 * AreaApp.TAMBT));
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// criando imagens
			this._tamanho = this.criaImagem('PropTamanho');
			this._rotacao = this.criaImagem('PropRotacao');
			this._vermelho = this.criaImagem('PropVermelho');
			this._verde = this.criaImagem('PropVerde');
			this._azul = this.criaImagem('PropAzul');
			this._ordem = this.criaImagem('PropOrdem');
			
			// criando botões
			this._btTamanhoMais = this.criaBotao('BTPropMais', this.cliqueTamanhoMais);
			this._btTamanhoMenos = this.criaBotao('BTPropMenos', this.cliqueTamanhoMenos);
			this._btRotacaoMais = this.criaBotao('BTPropMais', this.cliqueRotacaoMais);
			this._btRotacaoMenos = this.criaBotao('BTPropMenos', this.cliqueRotacaoMenos);
			this._btVermelhoMais = this.criaBotao('BTPropMais', this.cliqueVermelhoMais);
			this._btVermelhoMenos = this.criaBotao('BTPropMenos', this.cliqueVermelhoMenos);
			this._btVerdeMais = this.criaBotao('BTPropMais', this.cliqueVerdeMais);
			this._btVerdeMenos = this.criaBotao('BTPropMenos', this.cliqueVerdeMenos);
			this._btAzulMais = this.criaBotao('BTPropMais', this.cliqueAzulMais);
			this._btAzulMenos = this.criaBotao('BTPropMenos', this.cliqueAzulMenos);
			this._btOrdemMais = this.criaBotao('BTPropMais', this.cliqueOrdemMais);
			this._btOrdemMenos = this.criaBotao('BTPropMenos', this.cliqueOrdemMenos);
			
			// posicionando botões
			var intervalo:Number = 0.25 * AreaApp.TAMBT;
			this._btTamanhoMais.x = this._bg.width - (1.5 * intervalo) - this._btTamanhoMais.width;
			this._tamanho.x = this._btTamanhoMais.x - this._tamanho.width;
			this._btTamanhoMenos.x = this._tamanho.x - this._btTamanhoMenos.width;
			
			this._btRotacaoMais.x = this._btTamanhoMenos.x - intervalo - this._btRotacaoMais.width;
			this._rotacao.x = this._btRotacaoMais.x - this._rotacao.width;
			this._btRotacaoMenos.x = this._rotacao.x - this._btRotacaoMenos.width;
			
			this._btVermelhoMais.x = this._btRotacaoMenos.x - intervalo - this._btVermelhoMais.width;
			this._vermelho.x = this._btVermelhoMais.x - this._vermelho.width;
			this._btVermelhoMenos.x = this._vermelho.x - this._btVermelhoMenos.width;
			
			this._btVerdeMais.x = this._btVermelhoMenos.x - intervalo - this._btVerdeMais.width;
			this._verde.x = this._btVerdeMais.x - this._verde.width;
			this._btVerdeMenos.x = this._verde.x - this._btVerdeMenos.width;
			
			this._btAzulMais.x = this._btVerdeMenos.x - intervalo - this._btAzulMais.width;
			this._azul.x = this._btAzulMais.x - this._azul.width;
			this._btAzulMenos.x = this._azul.x - this._btAzulMenos.width;
			
			this._btOrdemMais.x = this._btAzulMenos.x - intervalo - this._btOrdemMais.width;
			this._ordem.x = this._btOrdemMais.x - this._ordem.width;
			this._btOrdemMenos.x = this._ordem.x - this._btOrdemMenos.width;
			
			this._btTamanhoMais.y = this._btTamanhoMenos.y = this._tamanho.y = intervalo;
			this._btRotacaoMais.y = this._btRotacaoMenos.y = this._rotacao.y = intervalo;
			this._btVermelhoMais.y = this._btVermelhoMenos.y = this._vermelho.y = intervalo;
			this._btVerdeMais.y = this._btVerdeMenos.y = this._verde.y = intervalo;
			this._btAzulMais.y = this._btAzulMenos.y = this._azul.y = intervalo;
			this._btOrdemMais.y = this._btOrdemMenos.y = this._ordem.y = intervalo;
			
			
		}
		
		// FUNÇÕES PRIVADAS
		
		/**
		 * Cria um botão para a barra.
		 * @param	objeto	objeto a receber o botão
		 * @param	nome	nome do gráfico do botão
		 * @param	acao	ação do clique do botão
		 */
		private function criaBotao(nome:String, acao:Function):Sprite
		{
			var objeto:Sprite = Main.graficos.getSPGR(nome);
			objeto.width = objeto.height = AreaApp.TAMBT;
			objeto.addEventListener(MouseEvent.CLICK, acao);
			this.addChild(objeto);
			return (objeto);
		}
		
		/**
		 * Cria uma imagem para a barra.
		 * @param	objeto	objeto a receber a imagem
		 * @param	nome	nome do gráfico da imagem
		 */
		private function criaImagem(nome:String):Bitmap
		{
			var objeto:Bitmap = Main.graficos.getGR(nome);
			objeto.width = objeto.height = AreaApp.TAMBT;
			this.addChild(objeto);
			return (objeto);
		}
		
		// cliques nos botões
		private function cliqueTamanhoMais(evt:MouseEvent):void { if (this.acTamanho != null) this.acTamanho('+'); }
		private function cliqueTamanhoMenos(evt:MouseEvent):void { if (this.acTamanho != null) this.acTamanho('-'); }
		private function cliqueRotacaoMais(evt:MouseEvent):void { if (this.acRotacao != null) this.acRotacao('+'); }
		private function cliqueRotacaoMenos(evt:MouseEvent):void { if (this.acRotacao != null) this.acRotacao('-'); }
		private function cliqueVermelhoMais(evt:MouseEvent):void { if (this.acVermelho != null) this.acVermelho('+'); }
		private function cliqueVermelhoMenos(evt:MouseEvent):void { if (this.acVermelho != null) this.acVermelho('-'); }
		private function cliqueVerdeMais(evt:MouseEvent):void { if (this.acVerde != null) this.acVerde('+'); }
		private function cliqueVerdeMenos(evt:MouseEvent):void { if (this.acVerde != null) this.acVerde('-'); }
		private function cliqueAzulMais(evt:MouseEvent):void { if (this.acAzul != null) this.acAzul('+'); }
		private function cliqueAzulMenos(evt:MouseEvent):void { if (this.acAzul != null) this.acAzul('-'); }
		private function cliqueOrdemMais(evt:MouseEvent):void { if (this.acOrdem != null) this.acOrdem('+'); }
		private function cliqueOrdemMenos(evt:MouseEvent):void { if (this.acOrdem != null) this.acOrdem('-'); }
	}

}
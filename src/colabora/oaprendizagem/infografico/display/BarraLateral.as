package colabora.oaprendizagem.infografico.display 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class BarraLateral extends Sprite
	{
		// VARIÁVIES PÚBLICAS
		
		public var acMais:Function;
		public var acPagina:Function;
		
		// VARIÁVEIS PRIVADAS
		
		private var _bg:Shape;
		
		private var _btMais:Sprite;
		private var _btpaginamais:Sprite;
		private var _btpaginamenos:Sprite;
		private var _btpaginaanterior:Sprite;
		private var _btpaginaproxima:Sprite;
		private var _pgatual:TextField;
		
		public function BarraLateral() 
		{
			// preparando fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(AreaApp.CORBARRAS);
			this._bg.graphics.drawRect(0, 0, (1.5 * AreaApp.TAMBT), AreaApp.AREAHEIGHT);
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// criando botões
			this._btMais = this.criaBotao('BTMais', this.cliqueMais);
			this._btpaginamais = this.criaBotao('BTMaisPagina', this.cliquePaginaMais);
			this._btpaginamenos = this.criaBotao('BTMenosPagina', this.cliquePaginaMenos);
			this._btpaginaanterior = this.criaBotao('BTPaginaAnterior', this.cliquePaginaAnterior);
			this._btpaginaproxima = this.criaBotao('BTPaginaProxima', this.cliquePaginaProxima);
			
			// página atual
			this._pgatual = new TextField();
			this._pgatual.defaultTextFormat = new TextFormat('_sans', 20, 0xf08435, true, null, null, null, null, 'center');
			this._pgatual.text = '88 / 88';
			this._pgatual.multiline = false;
			this._pgatual.wordWrap = false;
			this._pgatual.selectable = false;
			this._pgatual.width = this._bg.width;
			this._pgatual.height = 40;
			this.addChild(this._pgatual);
			
			// posicionando botões
			var intervalo:Number = 0.25 * AreaApp.TAMBT;
			this._btMais.x = intervalo;
			this._btMais.y = intervalo;
			this._btpaginamais.x = intervalo;
			this._btpaginamais.y = this._btMais.y + this._btMais.height + (4 * intervalo);
			this._btpaginamenos.x = intervalo;
			this._btpaginamenos.y = this._btpaginamais.y + this._btpaginamais.height + (2 * intervalo);
			this._btpaginaanterior.x = intervalo;
			this._btpaginaanterior.y = this._btpaginamenos.y + this._btpaginamenos.height + (4 * intervalo);
			this._pgatual.y = this._btpaginaanterior.y + this._btpaginaanterior.height + 10;
			this._btpaginaproxima.x = intervalo;
			this._btpaginaproxima.y = this._pgatual.y + this._pgatual.height;
		}
		
		// FUNÇÕES PÚBLICAS
		
		/**
		 * Atualiza exibição do número da página.
		 */
		public function atualiza():void
		{
			this._pgatual.text = (Main.projeto.pagina.numero + 1) + ' / ' + Main.projeto.paginas.length;
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
		
		// cliques nos botões
		private function cliqueMais(evt:MouseEvent):void { if (this.acMais != null) this.acMais(); }
		private function cliquePaginaMais(evt:MouseEvent):void { if (this.acPagina != null) this.acPagina('+'); }
		private function cliquePaginaMenos(evt:MouseEvent):void { if (this.acPagina != null) this.acPagina('-'); }
		private function cliquePaginaAnterior(evt:MouseEvent):void { if (this.acPagina != null) this.acPagina('<'); }
		private function cliquePaginaProxima(evt:MouseEvent):void { if (this.acPagina != null) this.acPagina('>'); }
		
	}

}
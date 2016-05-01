package colabora.oaprendizagem.infografico.display 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class BarraLateralProp extends Sprite
	{
		// VARIÁVIES PÚBLICAS
		
		public var acOk:Function;
		public var acApaga:Function;
		public var acLink:Function;
		public var acReset:Function;
		public var acTexto:Function;
		
		// VARIÁVEIS PRIVADAS
		
		private var _bg:Shape;
		private var _btok:Sprite;
		private var _btapaga:Sprite;
		private var _btlink:Sprite;
		private var _btreset:Sprite;
		private var _bttexto:Sprite;
		
		public function BarraLateralProp() 
		{
			// preparando fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(AreaApp.CORBARRAS);
			this._bg.graphics.drawRect(0, 0, (1.5 * AreaApp.TAMBT), AreaApp.AREAHEIGHT);
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// criando botões
			this._btok = this.criaBotao('BTOk', this.cliqueOk);
			this._btapaga = this.criaBotao('BTLixeira', this.cliqueApaga);
			this._btlink = this.criaBotao('BTLink', this.cliqueLink);
			this._btreset = this.criaBotao('BTResetImagem', this.cliqueReset);
			this._bttexto = this.criaBotao('BTEditaTexto', this.cliqueTexto);
			
			// posicionando botões
			var intervalo:Number = 0.25 * AreaApp.TAMBT;
			this._btok.x = intervalo;
			this._btok.y = intervalo;
			this._btapaga.x = intervalo;
			this._btapaga.y = this._btok.y + this._btok.height + (3 * intervalo);
			this._btlink.x = intervalo;
			this._btlink.y = this._btapaga.y + this._btapaga.height + (3 * intervalo);
			this._btreset.x = intervalo;
			this._btreset.y = this._btlink.y + this._btlink.height + (3 * intervalo);
			this._bttexto.x = intervalo;
			this._bttexto.y = this._btreset.y + this._btreset.height + (3 * intervalo);
			
			// edição de texto
			this._bttexto.visible = false;
			this.addEventListener(Event.ADDED_TO_STAGE, onStage);
		}
		
		// FUNÇÕES PÚBLICAS
		
		/**
		 * Mostrar botão de edição de texto.
		 */
		public function mostrarTexto():void
		{
			this._bttexto.visible = true;
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
		 * Objeto adicionado à tela.
		 */
		private function onStage(evt:Event):void
		{
			this._bttexto.visible = false;
		}
		
		// cliques nos botões
		private function cliqueOk(evt:MouseEvent):void { if (this.acOk != null) this.acOk(); }
		private function cliqueApaga(evt:MouseEvent):void { if (this.acApaga != null) this.acApaga(); }
		private function cliqueLink(evt:MouseEvent):void { if (this.acLink != null) this.acLink(); }
		private function cliqueReset(evt:MouseEvent):void { if (this.acReset != null) this.acReset(); }
		private function cliqueTexto(evt:MouseEvent):void { if (this.acTexto != null) this.acTexto(); }
		
	}

}
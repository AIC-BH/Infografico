package colabora.oaprendizagem.infografico.display 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author Lucas S. Junqueira
	 */
	public class BarraInferior extends Sprite
	{
		
		// VARIÁVIES PÚBLICAS
		
		public var acAjuda:Function;
		public var acInfo:Function;
		public var acNovo:Function;
		public var acAbrir:Function;
		public var acSalvar:Function;
		public var acArquivos:Function;
		public var acCompartilhar:Function;
		public var acReceber:Function;
		public var acApresentar:Function;
		public var acExportar:Function;
		public var acTelaCheia:Function;
		
		// VARIÁVEIS PRIVADAS
		
		private var _bg:Shape;
		
		private var _btAjuda:Sprite;
		private var _btInfo:Sprite;
		private var _btNovo:Sprite;
		private var _btAbrir:Sprite;
		private var _btSalvar:Sprite;
		private var _btArquivos:Sprite;
		private var _btCompartilhar:Sprite;
		private var _btReceber:Sprite;
		private var _btApresentar:Sprite;
		private var _btExportar:Sprite;
		private var _btTelaCheia:Sprite;
		
		public function BarraInferior() 
		{
			// preparando fundo
			this._bg = new Shape();
			this._bg.graphics.beginFill(AreaApp.CORBARRAS);
			this._bg.graphics.drawRect(0, 0, AreaApp.AREAWIDTH, (1.5 * AreaApp.TAMBT));
			this._bg.graphics.endFill();
			this.addChild(this._bg);
			
			// criando botões
			this._btAjuda = this.criaBotao('BTAjuda', this.onAjuda);
			this._btInfo = this.criaBotao('BTInfo', this.onInfo);
			this._btNovo = this.criaBotao('BTNovo', this.onNovo);
			this._btAbrir = this.criaBotao('BTAbrir', this.onAbrir);
			this._btSalvar = this.criaBotao('BTSalvar', this.onSalvar);
			this._btArquivos = this.criaBotao('BTArquivos', this.onArquivos);
			this._btCompartilhar = this.criaBotao('BTCompartilhar', this.onCompartilhar);
			this._btReceber = this.criaBotao('BTReceber', this.onReceber);
			this._btExportar = this.criaBotao('BTExportarImagem', this.onExportar);
			this._btApresentar = this.criaBotao('BTApresentar', this.onApresentar);
			this._btTelaCheia = this.criaBotao('BTTelaCheia', this.onTelaCheia);
			
			// posicionando botões
			var intervalo:Number = 0.25 * AreaApp.TAMBT;
			this._btAjuda.x = intervalo;
			this._btAjuda.y = intervalo;
			this._btReceber.x = this._bg.width - this._btReceber.width - intervalo;
			this._btCompartilhar.x = this._btReceber.x - this._btCompartilhar.width - (3.4 * intervalo);
			this._btArquivos.x = this._btCompartilhar.x - this._btArquivos.width - (3.4 * intervalo);
			this._btSalvar.x = this._btArquivos.x - this._btSalvar.width - (3.4 * intervalo);
			this._btAbrir.x = this._btSalvar.x - this._btAbrir.width - (3.4 * intervalo);
			this._btNovo.x = this._btAbrir.x - this._btNovo.width - (3.4 * intervalo);
			this._btInfo.x = this._btNovo.x - this._btInfo.width - (3.4 * intervalo);
			this._btExportar.x = this._btInfo.x - this._btExportar.width - (3.4 * intervalo);
			this._btApresentar.x = this._btExportar.x - this._btApresentar.width - (3.4 * intervalo);
			this._btTelaCheia.x = this._btApresentar.x - this._btTelaCheia.width - (3.4 * intervalo);
			
			this._btReceber.y = this._btCompartilhar.y = this._btArquivos.y = this._btSalvar.y = this._btAbrir.y = this._btNovo.y = this._btInfo.y = this._btExportar.y = this._btApresentar.y = this._btTelaCheia.y = intervalo;
			this._btTelaCheia.visible = Main.desktop;
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
		private function onAjuda(evt:MouseEvent):void { if (this.acAjuda != null) this.acAjuda(); }
		private function onInfo(evt:MouseEvent):void { if (this.acInfo != null) this.acInfo(); }
		private function onNovo(evt:MouseEvent):void { if (this.acNovo != null) this.acNovo(); }
		private function onAbrir(evt:MouseEvent):void { if (this.acAbrir != null) this.acAbrir(); }
		private function onSalvar(evt:MouseEvent):void { if (this.acSalvar != null) this.acSalvar(); }
		private function onArquivos(evt:MouseEvent):void { if (this.acArquivos != null) this.acArquivos(); }
		private function onCompartilhar(evt:MouseEvent):void { if (this.acCompartilhar != null) this.acCompartilhar(); }
		private function onReceber(evt:MouseEvent):void { if (this.acReceber != null) this.acReceber(); }
		private function onApresentar(evt:MouseEvent):void { if (this.acApresentar != null) this.acApresentar(); }
		private function onExportar(evt:MouseEvent):void { if (this.acExportar != null) this.acExportar(); }
		private function onTelaCheia(evt:MouseEvent):void { if (this.acTelaCheia != null) this.acTelaCheia(); }
	}

}
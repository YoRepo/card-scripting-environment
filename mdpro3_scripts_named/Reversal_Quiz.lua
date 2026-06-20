--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 大逆转谜题  (ID: 5990062)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 将自己手卡和场上的卡全部送去墓地。猜自己卡组最上面1张卡的种类（魔法/陷阱/怪兽），若猜对，则将自己与对方的基本分值互换。
--[[ __CARD_HEADER_END__ ]]

--大逆転クイズ
function c5990062.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCost(c5990062.cost)
	e1:SetTarget(c5990062.target)
	e1:SetOperation(c5990062.activate)
	c:RegisterEffect(e1)
end
function c5990062.cfilter(c)
	return not c:IsAbleToGraveAsCost()
end
function c5990062.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND+LOCATION_ONFIELD,0)
	g:RemoveCard(e:GetHandler())
	if chk==0 then return g:FilterCount(Card.IsLocation,nil,LOCATION_HAND)>0
		and g:FilterCount(Card.IsLocation,nil,LOCATION_ONFIELD)>0
		and not g:IsExists(c5990062.cfilter,1,nil) end
	Duel.SendtoGrave(g,REASON_COST)
end
function c5990062.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLP(tp)~=Duel.GetLP(1-tp)
		and Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c5990062.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if not tc then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CARDTYPE)
	local res=Duel.AnnounceType(tp)
	Duel.ConfirmDecktop(tp,1)
	if (res==0 and tc:IsType(TYPE_MONSTER))
		or (res==1 and tc:IsType(TYPE_SPELL))
		or (res==2 and tc:IsType(TYPE_TRAP)) then
		local lp1=Duel.GetLP(tp)
		local lp2=Duel.GetLP(1-tp)
		Duel.SetLP(tp,lp2)
		Duel.SetLP(1-tp,lp1)
	end
	Duel.ShuffleDeck(tp)
end

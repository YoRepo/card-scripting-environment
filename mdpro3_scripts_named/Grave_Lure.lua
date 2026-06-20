--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 来自墓场的引诱  (ID: 57270476)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方卡组最上面1张卡表面向上放回卡组洗切。对方抽到那张卡时，那张卡直接送去墓地。
--[[ __CARD_HEADER_END__ ]]

--墓場からの誘い
function c57270476.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_DECK_REVERSE_CHECK)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c57270476.target)
	e1:SetOperation(c57270476.activate)
	c:RegisterEffect(e1)
end
function c57270476.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_DECK)>0 end
end
function c57270476.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ConfirmDecktop(1-tp,1)
	local g=Duel.GetDecktopGroup(1-tp,1)
	if g:GetCount()>0 then
		local tc=g:GetFirst()
		Duel.ShuffleDeck(1-tp)
		tc:ReverseInDeck()
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_DRAW)
		e1:SetOperation(c57270476.tgop)
		e1:SetReset(RESET_EVENT+0x1de0000)
		tc:RegisterEffect(e1)
	end
end
function c57270476.tgop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoGrave(e:GetHandler(),REASON_EFFECT)
end

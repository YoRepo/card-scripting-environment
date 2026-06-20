--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 冰水摇篮  (ID: 55343303)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 364
--
-- Effect Text:
-- ①：同名卡不在自己的场上·墓地存在的1只「冰水」怪兽从卡组加入手卡。
--[[ __CARD_HEADER_END__ ]]

--氷水揺籃
function c55343303.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c55343303.thtg)
	e1:SetOperation(c55343303.thop)
	c:RegisterEffect(e1)
end
function c55343303.cfilter(c,code)
	return c:IsCode(code) and (c:IsFaceup() or not c:IsOnField())
end
function c55343303.thfilter(c,tp)
	return c:IsSetCard(0x16c) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
		and not Duel.IsExistingMatchingCard(c55343303.cfilter,tp,LOCATION_ONFIELD+LOCATION_GRAVE,0,1,nil,c:GetCode())
end
function c55343303.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c55343303.thfilter,tp,LOCATION_DECK,0,1,nil,tp) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c55343303.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c55343303.thfilter,tp,LOCATION_DECK,0,1,1,nil,tp)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

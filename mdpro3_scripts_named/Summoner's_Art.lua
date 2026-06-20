--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 召唤师的技艺  (ID: 79816536)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：从卡组把1只5星以上的通常怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--召喚師のスキル
function c79816536.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c79816536.target)
	e1:SetOperation(c79816536.activate)
	c:RegisterEffect(e1)
end
function c79816536.filter(c)
	return c:IsLevelAbove(5) and c:IsType(TYPE_NORMAL) and c:IsAbleToHand()
end
function c79816536.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c79816536.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c79816536.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c79816536.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

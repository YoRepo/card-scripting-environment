--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 精神统一  (ID: 7512044)
-- Type: Spell
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 从卡组中选择1张「精神统一」加入手卡。这张卡1回合只能使用1张。
--[[ __CARD_HEADER_END__ ]]

--精神統一
function c7512044.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,7512044+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c7512044.target)
	e1:SetOperation(c7512044.activate)
	c:RegisterEffect(e1)
end
function c7512044.filter(c)
	return c:IsCode(7512044) and c:IsAbleToHand()
end
function c7512044.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c7512044.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c7512044.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c7512044.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

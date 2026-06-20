--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 魔妖回天  (ID: 2364438)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 289
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：从卡组选「魔妖回天」以外的1张「魔妖」卡加入手卡或送去墓地。
--[[ __CARD_HEADER_END__ ]]

--魔妖廻天
function c2364438.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH+CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,2364438+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c2364438.target)
	e1:SetOperation(c2364438.activate)
	c:RegisterEffect(e1)
end
function c2364438.filter(c)
	return c:IsSetCard(0x121) and not c:IsCode(2364438) and (c:IsAbleToHand() or c:IsAbleToGrave())
end
function c2364438.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2364438.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c2364438.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_OPERATECARD)
	local g=Duel.SelectMatchingCard(tp,c2364438.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()<=0 then return end
	local tc=g:GetFirst()
	if tc:IsAbleToHand() and (not tc:IsAbleToGrave() or Duel.SelectOption(tp,1190,1191)==0) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,tc)
	else
		Duel.SendtoGrave(tc,REASON_EFFECT)
	end
end

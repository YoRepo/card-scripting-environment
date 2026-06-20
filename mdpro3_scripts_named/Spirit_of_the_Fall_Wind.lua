--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 里风之精灵  (ID: 26517393)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Fairy
-- Level 4
-- ATK 1800 | DEF 900
--
-- Effect Text:
-- ①：这张卡召唤的场合才能发动。从卡组把1只反转怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--裏風の精霊
function c26517393.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c26517393.tg)
	e1:SetOperation(c26517393.op)
	c:RegisterEffect(e1)
end
function c26517393.filter(c)
	return c:IsType(TYPE_FLIP) and c:IsAbleToHand()
end
function c26517393.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c26517393.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c26517393.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c26517393.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

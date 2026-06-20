--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 魔犬 八鬼犬  (ID: 58616392)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 800 | DEF 800
--
-- Effect Text:
-- 这个卡名的效果1回合只能使用1次。
-- ①：这张卡从场上送去墓地的场合发动。从卡组把1只恶魔族·8星怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--魔犬オクトロス
function c58616392.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCountLimit(1,58616392)
	e1:SetCondition(c58616392.condition)
	e1:SetTarget(c58616392.target)
	e1:SetOperation(c58616392.operation)
	c:RegisterEffect(e1)
end
function c58616392.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c58616392.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c58616392.filter(c)
	return c:IsRace(RACE_FIEND) and c:IsLevel(8) and c:IsAbleToHand()
end
function c58616392.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c58616392.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

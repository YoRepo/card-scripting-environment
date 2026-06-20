--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 守墓的召唤师  (ID: 93023479)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 3
-- ATK 1200 | DEF 1500
-- Setcode: 46
--
-- Effect Text:
-- 这张卡从自己场上送去自己墓地时，从自己的卡组把1只守备力1500以下的名字带有「守墓」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--墓守の召喚師
function c93023479.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(93023479,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(c93023479.condition)
	e1:SetTarget(c93023479.target)
	e1:SetOperation(c93023479.operation)
	c:RegisterEffect(e1)
end
function c93023479.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
		and e:GetHandler():IsPreviousControler(tp)
end
function c93023479.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c93023479.filter(c)
	return c:IsDefenseBelow(1500) and c:IsSetCard(0x2e) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c93023479.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c93023479.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

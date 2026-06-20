--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 壁虱宝宝  (ID: 48588176)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 2
-- ATK 600 | DEF 600
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以从自己卡组把1只守备力1000以下的昆虫族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ダニポン
function c48588176.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(48588176,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c48588176.condition)
	e1:SetTarget(c48588176.target)
	e1:SetOperation(c48588176.operation)
	c:RegisterEffect(e1)
end
function c48588176.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c48588176.filter(c)
	return c:IsDefenseBelow(1000) and c:IsRace(RACE_INSECT) and c:IsAbleToHand()
end
function c48588176.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c48588176.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c48588176.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c48588176.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

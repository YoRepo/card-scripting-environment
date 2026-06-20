--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 钥匙鼠  (ID: 135598)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Beast
-- Level 1
-- ATK 100 | DEF 100
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以从自己卡组把1只3星以下的兽族怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--キーマウス
function c135598.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(135598,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c135598.condition)
	e1:SetTarget(c135598.target)
	e1:SetOperation(c135598.operation)
	c:RegisterEffect(e1)
end
function c135598.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c135598.filter(c)
	return c:IsLevelBelow(3) and c:IsRace(RACE_BEAST) and c:IsAbleToHand()
end
function c135598.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c135598.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c135598.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c135598.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

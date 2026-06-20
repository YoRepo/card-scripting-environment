--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 核成岩人  (ID: 6320631)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Rock
-- Level 4
-- ATK 1200 | DEF 1000
-- Setcode: 29
--
-- Effect Text:
-- 这张卡被战斗破坏送去墓地时，可以从自己卡组把1张「核成兽的钢核」或者1只4星以下的名字带有「核成」的怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--コアキメイル・ロック
function c6320631.initial_effect(c)
	aux.AddCodeList(c,36623431)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(6320631,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCondition(c6320631.condition)
	e1:SetTarget(c6320631.target)
	e1:SetOperation(c6320631.operation)
	c:RegisterEffect(e1)
end
function c6320631.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsLocation(LOCATION_GRAVE) and e:GetHandler():IsReason(REASON_BATTLE)
end
function c6320631.filter(c)
	return (c:IsCode(36623431) or (c:IsLevelBelow(4) and c:IsSetCard(0x1d))) and c:IsAbleToHand()
end
function c6320631.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c6320631.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c6320631.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c6320631.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

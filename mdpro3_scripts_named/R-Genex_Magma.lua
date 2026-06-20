--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 真次世代锅炉人  (ID: 1533292)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Pyro
-- Level 3
-- ATK 1000 | DEF 200
-- Setcode: 4098
--
-- Effect Text:
-- ①：这张卡召唤时才能发动。从卡组把1只2星「真次世代」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--レアル・ジェネクス・マグナ
function c1533292.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(1533292,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c1533292.target)
	e1:SetOperation(c1533292.operation)
	c:RegisterEffect(e1)
end
function c1533292.filter(c)
	return c:IsLevel(2) and c:IsSetCard(0x1002) and c:IsAbleToHand()
end
function c1533292.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c1533292.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c1533292.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c1533292.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end

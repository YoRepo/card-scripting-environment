--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 真次世代破碎机  (ID: 65149697)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level 2
-- ATK 800 | DEF 800
-- Setcode: 4098
--
-- Effect Text:
-- ①：这张卡召唤时才能发动。从卡组把1只4星「真次世代」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--レアル・ジェネクス・クラッシャー
function c65149697.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(65149697,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c65149697.target)
	e1:SetOperation(c65149697.operation)
	c:RegisterEffect(e1)
end
function c65149697.filter(c)
	return c:IsLevel(4) and c:IsSetCard(0x1002) and c:IsAbleToHand()
end
function c65149697.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c65149697.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c65149697.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c65149697.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
